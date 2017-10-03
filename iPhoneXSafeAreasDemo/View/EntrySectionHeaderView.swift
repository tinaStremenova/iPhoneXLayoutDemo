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
        
        self.contentView.backgroundColor = UIColor.white
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
