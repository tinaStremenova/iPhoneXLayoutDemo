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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: item.itemPictureName)
        self.nameLabel.text = item.itemName
        self.descriptionLabel.text = item.itemDescription
        
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
}
