//
//  EntrySectionHeaderView.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 01/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class EntrySectionHeaderView:UITableViewHeaderFooterView {
    lazy var titleLabel:UILabel = self._makeTitleLabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // self.contentView.backgroundColor = UIColor.cyan
        
        
        /* For iPhone X you should set the color for background view, not the content view.
           However background view is at this point of initialization nonexistent - therefore it makes sense to set this property in UITableviewController/UIViewController
           in tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
           instead of initializing background view here by yourself. */
        
        // self.backgroundView = UIView()
        // self.backgroundView?.backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntrySectionHeaderView {
    
    fileprivate func _makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(label)
        
        let guides = self.contentView.layoutMarginsGuide
        label.topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
        
        return label
    }
}
