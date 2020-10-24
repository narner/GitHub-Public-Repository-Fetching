//
//  FeedViewController.swift
//  GitHub-Repo-Fetch
//
//  Created by Nick Arner on 10/20/20.
//

import UIKit
import Alamofire
import SwiftyJSON


class RepsitoryFeedViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var fetchedRepositories: [Repository] = []
    var nextLink: String!
    var loadingIndicator: UIActivityIndicatorView!
    var isLoading: Bool = false
    var footerView: CollectionViewFooter?
    let footerViewReuseIdentifier = "RefreshFooterView"
    let heaaderViewReuseIdentifier = "HeaderView"

    let headers: HTTPHeaders = [
      "Accept": "application/vnd.github.v3+json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 0)
    
        prepareCollectionView()
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.style = .large
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)

        fetchRepositories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        footerView?.stopAnimating()
    }

    
    // MARK: Repository retrieval
    
    func fetchRepositories() {
        AF.request("https://api.github.com/repositories", headers: headers)
            .responseJSON { [self] response in
            do {
                print(response)
                if let headers = response.response?.allHeaderFields as? [String: String]{
                    let header = headers["Link"]
                    let link = header?.slice(from: "<", to: ">")
                    nextLink = link
                 }
                
                let repositories = try JSONDecoder().decode(Array<Repository>.self, from: response.data!)
                fetchedRepositories = repositories

                DispatchQueue.main.async {
                    self.view.layer.layoutSublayers()
                    self.collectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            } catch {
                print(error)
                self.loadingIndicator.stopAnimating()
                displayErrorAlert()
            }
        }
    }
    
    @objc func fetchMoreRepositories() {

        if nextLink == nil {
            return
        }
        
        guard let url = URL(string: nextLink) else {
            return
        }
        
        AF.request(url, headers: headers)
            .responseJSON { [self] response in
            do {
                if let headers = response.response?.allHeaderFields as? [String: String] {
                    /* Extract the link to the "next" page of public repositories.
                    This initiall call only fetches 100 repositories at a time, but it
                    does provide a link to fetch the next page of repositories when the
                    app is ready to fetch and display them */
                    let header = headers["Link"]
                    let link = header?.slice(from: "<", to: ">")
                    nextLink = link
                 }

                let repositories = try JSONDecoder().decode(Array<Repository>.self, from: response.data!)
                fetchedRepositories.append(contentsOf: repositories)
            
                DispatchQueue.main.async {
                    self.footerView?.stopAnimating()
                    self.collectionView.reloadData()
                }
            } catch {
                displayErrorAlert()
            }
        }
    }

    
    // MARK: - UICollectionViewDelegate
    
    // Compute the scroll value and play witht the threshold to get desired effect
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(abs(triggerThreshold),1.0);
        self.footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            self.footerView?.animateFinal()
        }
        print("pullRation:\(pullRatio)")
    }
    
    // Compute the offset and call the load method
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        print("pullHeight:\(pullHeight)");
        if pullHeight == 0.0 {
            guard let footerView = self.footerView, footerView.isAnimatingFinal else { return }
            print("load more trigger")
            self.isLoading = true
            self.footerView?.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer:Timer) in
                self.fetchMoreRepositories()
                self.isLoading = false
            })
        }
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout  collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        let size = CGSize(width: 400, height: 200)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }

     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath) as! CollectionViewFooter
            self.footerView = footerView
            return self.footerView!
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: heaaderViewReuseIdentifier, for: indexPath) as! CollectionViewHeader
              return headerView
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.prepareInitialAnimation()
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.stopAnimating()
        }
    }
    

    // MARK: - UICollectionViewDataSource

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedRepositories.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell
            else { preconditionFailure("Failed to load collection view cell") }
        cell.repository = fetchedRepositories[indexPath.item]
        return cell
    }
    
    // MARK: UI Helper Methods

    func prepareCollectionView() {
        collectionView?.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        collectionView?.register(UINib(nibName: "CollectionViewFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)

        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)

        collectionView.alwaysBounceVertical = true
    }
     
    // MARK: - Alert

    func displayErrorAlert(){
        let alert = UIAlertController(title: "Alert",
                                      message: "Failed to fetch repositories, please try again later.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
