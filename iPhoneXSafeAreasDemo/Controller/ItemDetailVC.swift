//
//  ItemDetailVC.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 27/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    var item:Item!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: item.itemPictureName)
        self.nameLabel.text = item.itemName
        self.descriptionLabel.text = item.itemDescription
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        // test insets behaviour
        self.setInsets()
    }
    
    private func setInsets() {
        
        // content inset to inset content for developpers
        self.scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        if #available(iOS 11.0, *) {
            
            // When constraining scrollview to superview, you can controll whether it takes into account safe areas
            // Automatic setting is default and takes value set in viewcontroller
            // If you constrain scrollview to safe area, you don't have to bother with this
            self.scrollView.contentInsetAdjustmentBehavior = .never
            
            // When false, scrollview goes under the navigation bar if contrained to superview instead of safe area
            // Scrollview property contentInsetAdjustmentBehavior overrides this behaviour if not set to .automatic
            self.automaticallyAdjustsScrollViewInsets = false
            
            // Constrains label to scrollview frame to fixed position
            // The layout guide based on the untransformed frame rectangle of the scroll view - so it does not take account of the insets or safe areas
            let frameLayoutGuide = self.scrollView.frameLayoutGuide
            let label = self._makeEmployeeOfTheMonthLabel()
            
            self.scrollView.addSubview(label)
            
            // Use scrollView.adjustedContentInset so label will be constrained as all scrollview content
            label.topAnchor.constraint(equalTo: frameLayoutGuide.topAnchor, constant: self.scrollView.adjustedContentInset.top).isActive = true
            label.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: self.scrollView.adjustedContentInset.right).isActive = true
        }
    }
    
    private func _makeEmployeeOfTheMonthLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Employee of the month!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.backgroundColor = UIColor.STRV.red
        label.textColor = .white
        return label
    }
}
