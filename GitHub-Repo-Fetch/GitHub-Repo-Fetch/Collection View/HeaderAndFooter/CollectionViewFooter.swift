//
//  CollectionViewFooter.swift
//  GitHub-Repo-Fetch
//
//  Created by Nick Arner on 10/21/20.
//


import Foundation
import UIKit

class CollectionViewFooter : UICollectionReusableView {
   
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    var isAnimatingFinal :Bool = false
    var currentTransform: CGAffineTransform?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //Reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimating() {
        self.isAnimatingFinal = true
        self.refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimating() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
    }
    
    // Final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) { 
            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
}
