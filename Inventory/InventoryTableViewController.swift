//
//  InventoryTableViewController.swift
//  Inventory
//
//  Created by Grant Maloney on 11/29/18.
//  Copyright © 2018 Grant Maloney. All rights reserved.
//

import UIKit

class InventoryTableViewController: UITableViewController {

    var inventoryResponse: InventoryItem?
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let inventory = Inventory()
        inventoryResponse = inventory.loadInventory()
        
        if let inventoryResponse = inventoryResponse {
            let status = inventoryResponse.status
            if status == "ok" {
                products = inventoryResponse.products
            } else {
                print("Error status not OK when checking inventory!")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if let cell = cell as? InventoryTableViewCell {
            let product = products[indexPath.row]
            cell.itemLabel.text = product.title
            cell.priceLabel.text = "$\(String(product.price))"
            cell.IDLabel.text = "ID: \(String(product.id))"
            cell.categoryLabel.text = "Cateogry: \(product.category.rawValue)"
            cell.stockedQuantityLabel.text = "Current Stock: \(String(product.stockedQuantity))"
        }

        return cell
    }
}
