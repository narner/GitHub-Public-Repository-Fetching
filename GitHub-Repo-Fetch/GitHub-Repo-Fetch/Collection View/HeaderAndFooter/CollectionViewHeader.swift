//
//  HeaderReusableView.swift
//  GitHub-Repo-Fetch
//
//  Created by Nick Arner on 10/21/20.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.isEditable = false
        let attributedString = NSMutableAttributedString(string: "Repositories \n\nA repository is like a folder for your project. Your project's repository contains all of your project's files and stores each file's revision history. You can also discuss and manage your project's work within the repository.\n\n\n")
        
        let attributes0: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 32)
        ]
        attributedString.addAttributes(attributes0, range: NSRange(location: 0, length: 12))
        
        let attributes2: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 18)
        ]
        attributedString.addAttributes(attributes2, range: NSRange(location: 15, length: 226))
        
        textView.attributedText = attributedString
        addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textView]-|", options: [], metrics: nil, views: ["textView": textView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|", options: [], metrics: nil, views: ["textView": textView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
}
