//
//  Untitled.swift
//  CoffeeShop
//
//  Created by Can Arda on 03.12.25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        Group {
            if cartManager.items.isEmpty {
                // Sepet boşsa
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 80))
                        .foregroundColor(.gray)
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text("Add some delicious coffee!")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            } else {
                // Sepet doluysa
                List {
                    ForEach(cartManager.items) { item in
                        CartItemRow(item: item)
                    }
                    .onDelete(perform: cartManager.removeItem)
                    
                    // Toplam fiyat
                    Section {
                        HStack {
                            Text("Total")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.starbucksGreen)
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Checkout butonu
                    Section {
                        Button(action: {
                            // Ödeme işlemi burada olur
                            print("Proceeding to checkout...")
                        }) {
                            HStack {
                                Spacer()
                                Text("Proceed to Checkout")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color.starbucksGreen)
                            .cornerRadius(10)
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Sepet item satırı
struct CartItemRow: View {
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.coffee.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.starbucksGreen)
                .padding(8)
                .background(Color.starbucksCream)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.coffee.name)
                    .font(.headline)
                
                Text(item.size.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Quantity: \(item.quantity)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("$\(item.totalPrice, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.starbucksGreen)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NavigationView {
        CartView()
            .environmentObject(CartManager())
    }
}
