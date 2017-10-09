//
//  EntriesListVC.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 29/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class EntriesListVC:UITableViewController {
    
    lazy var viewModel:EntriesListVM = EntriesListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EntryCell")
        self.tableView.register(EntrySectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? EntrySectionHeaderView else { return }
        
        /* This line will cover whole cell area from edge to edge.
           See the difference between setting the color to background view and content view on landscape. */
        headerView.backgroundView?.backgroundColor = .yellow

        // This line will cover cell area inset by safe areas
        headerView.contentView.backgroundColor = .cyan
        
        // This will not set any background color
        headerView.backgroundColor = .magenta
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! EntrySectionHeaderView
        view.titleLabel.text = self.viewModel.title(forSection: section)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.text(at: indexPath)
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
}

