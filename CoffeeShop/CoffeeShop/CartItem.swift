import SwiftUI
import Combine

import SwiftUI  // Foundation yerine SwiftUI kullanalım

struct CartItem: Identifiable {
    let id = UUID()
    let coffee: Coffee
    let size: CoffeeSize
    var quantity: Int
    
    var totalPrice: Double {
        return (coffee.basePrice + size.price) * Double(quantity)
    }
}

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    func addToCart(coffee: Coffee, size: CoffeeSize) {
        if let index = items.firstIndex(where: { $0.coffee.id == coffee.id && $0.size == size }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(coffee: coffee, size: size, quantity: 1))
        }
    }
    
    func removeItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}
