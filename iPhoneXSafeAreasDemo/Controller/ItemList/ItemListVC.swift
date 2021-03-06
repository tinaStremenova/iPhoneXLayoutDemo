//
//  ItemListVC.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 26/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class ItemListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let cellReuseIdentifier = "ItemTableViewCell"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var searchedItems:[Item] = []
    fileprivate lazy var viewModel:ItemListVM = ItemListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView - - - - -
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Navigation Bar - - - - -
        self.navigationItem.title = self.viewModel.tabbarItemTitle
        
        // Search controller - - - - -
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            
            // 'Activates' large titles in navigation controller
            navigationController?.navigationBar.prefersLargeTitles = true
            
            // Sets if this viewcontroller will display large titles in navigation controller that uses them            
            // Can be also set in storyboard for every view controller
            self.navigationItem.largeTitleDisplayMode = .always

        } else {
            definesPresentationContext = true
            searchController.searchBar.barTintColor = UIColor.STRV.red
            searchController.searchBar.backgroundImage = UIImage()
            searchController.searchBar.isTranslucent = false
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    var itemCount:Int {
        return isSearching ? self.searchedItems.count : self.viewModel.items.count
    }
    
    func item(for indexPath:IndexPath) -> Item {
        return isSearching ? self.searchedItems[indexPath.row] :
            self.viewModel.items[indexPath.row]
    }
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - UITableView

extension ItemListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.item(for: indexPath)
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        
        cell.titleLabel.text = item.itemName
        cell.subtitleLabel.text = "Last Office Entry:\n" + item.timeEntries.first!.type.rawValue + " " + self.viewModel.entryDateFormatter.string(from: item.timeEntries.first!.dateTime)
        cell.descriptionCell.text = item.itemDescription
        cell.itemImageView.image = UIImage(named: item.itemPictureName)
        
        return cell
    }
}

extension ItemListVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.item(for: indexPath)
        self.showStoryboardDetail(item: item)
    }
    
    /// Shows detail VC with layout created in storyboard
    private func presentStoryboardDetail(item: Item) {
        let detailVC = R.storyboard.main().instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        detailVC.item = item
        detailVC.hidesBottomBarWhenPushed = true
        self.present(detailVC, animated: true, completion: nil)
    }
    
    /// Shows detail VC with layout created in storyboard
    private func showStoryboardDetail(item: Item) {
        let detailVC = R.storyboard.main().instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        detailVC.item = item
        detailVC.hidesBottomBarWhenPushed = true
        self.show(detailVC, sender: self)
    }
    
    /// Shows detail VC with layout created in code
    /// Demonstrates how views behave when constrained to different guides with navigation controller & tab bar
    /// Debug view hierarchy to see which views went under the bars
    private func showCodeGeneratedLayoutDetail(item: Item) {
        
        // choose the configuration you want to test
        let detailVC = TestVC(with: item, configuration: .scrollViewContrainedToView)
        self.navigationController?.show(detailVC, sender: self)
    }
    
    /// Presents detail VC with layout created in code
    /// Demonstrates how views behave when constrained to different guides
    private func presentCodeGeneratedLayoutDetail(item: Item) {
        let detailVC = TestVC(with: item, configuration: .scorllViewConstrainedToLayoutMargins)
        detailVC.hidesBottomBarWhenPushed = true
        self.present(detailVC, animated: true, completion: nil)
    }
}



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: - Search Handlers

extension ItemListVC {
    
    var isSearching:Bool {
        guard let searchText = self.searchController.searchBar.text else { return false }
        return searchText.characters.count > 0
    }
    
    fileprivate func filterItems(by searchString: String?) {
        guard let searchString = searchString else { return self.searchedItems = [] }
        self.searchedItems = self.viewModel.items.filter({ $0.itemName.contains(searchString) || $0.itemDescription.contains(searchString)})
    }
}

extension ItemListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterItems(by: searchController.searchBar.text)
        self.tableView.reloadData()
    }
}
