//
//  Coffee.swift
//  CoffeeShop
//
//  Created by Can Arda on 03.12.25.
//

import Foundation

enum CoffeeSize: String, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    
    var price: Double {
        switch self {
        case .small:
            return 3.50
        case .medium:
            return 4.00
        case .large:
            return 4.50
        }
    }
}

struct Coffee: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let basePrice: Double
    let imageName: String
}

extension Coffee {
    static let sampleCoffees = [
        Coffee(name: "Americano", description: "Espresso with steamed milk.", basePrice: 3.50, imageName: "americano"),
        Coffee(name: "Latte", description: "Espresso with steamed milk and a touch of foam.", basePrice: 4.00, imageName: "latte"),
        Coffee(name: "Cappuccino", description: "Espresso with steamed milk, a layer of foam, and a touch of cocoa powder.", basePrice: 4.50, imageName: "cappuccino"),
    ]
}
