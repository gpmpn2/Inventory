//
//  Inventory.swift
//  Inventory
//
//  Created by Grant Maloney on 11/29/18.
//  Copyright © 2018 Grant Maloney. All rights reserved.
//
import Foundation

struct InventoryItem: Codable {
    let status: String
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let category: Category
    let title: String
    let price: Double
    let stockedQuantity: Int
}

enum Category: String, Codable {
    case computers = "Computers"
    case electronics = "Electronics"
    case kitchen = "Kitchen"
    case pets = "Pets"
}

/**
 * Handles loading the inventory from base JSON file
 **/
class Inventory {
    func loadInventory() -> InventoryItem? {
        if let path = Bundle.main.path(forResource: "inventory", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                return try! decoder.decode(InventoryItem.self, from: jsonData)
            } catch {
                print("Error reading file!")
            }
        }
        
        return nil
    }
}
