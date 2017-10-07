//
//  TestVC.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 04/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

enum Configuration {
    case staticLayout
    case scrollViewContrainedToView
    case scrollViewConstrainedToSafeArea
    case scorllViewConstrainedToLayoutMargins
}

class TestVC:UIViewController {
    
    private let item:Item
    private let configuration:Configuration
    
    lazy var itemImageView = self._makeImageView()
    lazy var titleLabel = self._makeTitleLabel()
    lazy var descriptionLabel = self._makeDescriptionLabel()
    
    init(with item:Item, configuration: Configuration) {
        self.item = item
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // set data
        self.itemImageView.image = UIImage(named: self.item.itemPictureName)
        self.titleLabel.text = item.itemName
        self.descriptionLabel.text = item.itemDescription

        self.setUpLayout()
    }
    
    private func setUpLayout() {

        // red border to show views boundaries
        [itemImageView, titleLabel, descriptionLabel].forEach {
            ($0 as! UIView).layer.borderColor = UIColor.red.cgColor
            ($0 as! UIView).layer.borderWidth = 1.0
        }
        
        // background views to show different constrains
        self.setUpBackgroundViews()
        
        self.setUpNavigationBar()
        
        // set content based of configuration
        switch configuration {
        case .scorllViewConstrainedToLayoutMargins:
            _ = self._makeMarginConstrainedScrollView(.gray)
            
            if #available(iOS 11.0, *) {
                // this will cause scrollview to go under the bars
                // self.view.insetsLayoutMarginsFromSafeArea = false
            }
            
        case .scrollViewConstrainedToSafeArea:
            _ = self._makeSafeAreaConstrainedScrollView(.gray)
            
        case .scrollViewContrainedToView:
            _ = self._makeViewConstrainedScrollView(.gray)
            
        case .staticLayout:
            self.setUpStaticLayout()
        }
    }
    
    // Navigation bar if there's any
    private func setUpNavigationBar() {
        if #available(iOS 11.0, *) {
            // choose if you want to display large titles here
            self.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // show close button in case VC is presented modally
        if self.navigationController == nil {
            let closeButton = self._makeCloseButton(.red)
            closeButton.addTarget(self, action: #selector(self.closeButtonTapped(sender:)), for: .touchUpInside)
            closeButton.setTitle("X Close", for: .normal)
        }
    }
    
    // Background views
    private func setUpBackgroundViews() {
        
        // constrains view to viewcontrollers' view
        _ = self._makeViewConstrainedBackgroundView(.magenta)
        
        // constrains view to layout margins guide
        _ = self._makeMarginConstrainedBackgroundView(.cyan)
        
        // constrains view to safe areas
        _ = self._makeSafeAreasConstrainedView(.yellow)
    }
    
    // Non-scrollable layout
    private func setUpStaticLayout() {
        
        [itemImageView, descriptionLabel, titleLabel].forEach {
            self.view.addSubview($0)
        }
        
        let layoutGuide = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.itemImageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 20),
            self.itemImageView.trailingAnchor.constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor, constant: -20),
            self.itemImageView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leadingAnchor, constant: 20),
            self.itemImageView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
            ])
        // to fit other content on landscape
        self.itemImageView.setContentCompressionResistancePriority( 249, for: .vertical)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.itemImageView.bottomAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -20),
            self.titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -20),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 20)])
        
        // If we'd contrained labels' bottomAnchor to bottom anchor layout guide it would go under the tabbar.
        if #available(iOS 11.0, *) {
            let safeAreaLayoutGuides = self.view.safeAreaLayoutGuide
            self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuides.bottomAnchor, constant: -20).isActive = true
        } else {
            self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - User Actions
extension TestVC {
    func closeButtonTapped(sender:Any) {
        self.dismiss(animated: true, completion: nil)
    }
}





// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - Background views
extension TestVC {
    
    fileprivate func _makeViewConstrainedBackgroundView(_ color:UIColor) -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        backgroundView.attachAndConstraint(toView: self.view)
        return backgroundView
    }
    
    fileprivate func _makeMarginConstrainedBackgroundView(_ color:UIColor) -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        backgroundView.attachAndconstraintToLayoutMargins(ofViewController: self)
        return backgroundView
    }
    
    fileprivate func _makeSafeAreasConstrainedView(_ color:UIColor) -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        backgroundView.attachAndconstraintToSafeArea(ofViewController: self)
        return backgroundView
    }
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - ScrollViews

extension TestVC {
    fileprivate func _makeSafeAreaConstrainedScrollView(_ color: UIColor) -> UIScrollView {
        let scrollView = self._makeScrollView(color)
        scrollView.attachAndconstraintToSafeArea(ofViewController: self)
        return scrollView
    }
    
    fileprivate func _makeViewConstrainedScrollView(_ color: UIColor) -> UIScrollView  {
        let scrollView = self._makeScrollView(color)
        scrollView.attachAndConstraint(toView: self.view)
        return scrollView
    }
    
    fileprivate func _makeMarginConstrainedScrollView(_ color: UIColor) -> UIScrollView  {
        let scrollView = self._makeScrollView(color)
        scrollView.attachAndconstraintToLayoutMargins(ofViewController: self)
        return scrollView
    }
    
    private func _makeScrollView(_ color:UIColor) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = color
        
        let stackView = UIStackView(arrangedSubviews: [self.itemImageView, self.titleLabel, self.descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 15
        
        stackView.attachAndConstraint(toView: scrollView)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        return scrollView
    }
}



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - Views
extension TestVC {
    
    fileprivate func _makeCloseButton(_ color:UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)
        
        let layoutGuide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            button.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        return button
    }
    
    fileprivate func _makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    fileprivate func _makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }
    
    fileprivate func _makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - Helper functions for constraining views

private extension UIView {
    
    func attachAndconstraintToSafeArea(ofViewController vc: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(self)
        
        let layoutGuide = vc.view.layoutMarginsGuide
        
        /*  Safe areas replace top & bottom layout guides since iOS11
         Top & Bottom layout guides are now deprecated for apps supporting only iOS11 and later versions
         */
        if #available(iOS 11.0, *) {
            let safeAreaGuide = vc.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                self.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)])
        } else {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: vc.topLayoutGuide.bottomAnchor),
                self.bottomAnchor.constraint(equalTo: vc.bottomLayoutGuide.topAnchor)])
        }
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ])
    }
    
    func attachAndconstraintToLayoutMargins(ofViewController vc: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(self)
        
        let layoutGuide = vc.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)])
    }
    
    func attachAndConstraint(toView view:UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
}
