//
//  SlideOptionsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SlideOptionsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuOptions.register(SlideOptionCell.self, forCellReuseIdentifier: cellId)
        slideMenuOptions.delegate = self
        slideMenuOptions.dataSource = self
        
        setupViews()
        self.title = "Menu"
    }
    
    let slideMenuOptions: UITableView = {
        let tb = UITableView()
        tb.rowHeight = 70
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView()
        return tb
    }()
    
    let cellId = "cellId"
    let menuOptions = ["Budget Overview", "Analytics", "Transactions", "Goals", "Premium", "More"]
    let menuIcons = ["Budget", "Analytics", "Transaction", "Goals", "Premium", "More"]
}

//MARK: Setup
extension SlideOptionsController {
    fileprivate func setupViews() {
        view.addSubview(slideMenuOptions)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        slideMenuOptions.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        slideMenuOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slideMenuOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        slideMenuOptions.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension SlideOptionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SlideOptionCell
        cell.accessoryType = .disclosureIndicator
        cell.title.text = menuOptions[indexPath.row]
        cell.icon.image = UIImage(named: menuIcons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Menu"
    }

}

