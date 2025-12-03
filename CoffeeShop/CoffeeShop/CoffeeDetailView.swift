import SwiftUI

struct CoffeeDetailView: View {
    let coffee: Coffee
    @State private var selectedSize: CoffeeSize = .medium
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    @State private var showingAddedAlert = false
    
    var totalPrice: Double {
        return coffee.basePrice + selectedSize.price
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Kahve resmi
                Image(coffee.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.starbucksGreen)
                    .padding()
                    .background(Color.starbucksCream)
                    .cornerRadius(20)
                
                // İsim ve açıklama
                VStack(alignment: .leading, spacing: 10) {
                    Text(coffee.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.starbucksBrown)
                    
                    Text(coffee.description)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Boyut seçimi
                VStack(alignment: .leading, spacing: 15) {
                    Text("Select Size")
                        .font(.headline)
                        .foregroundColor(.starbucksBrown)
                    
                    HStack(spacing: 15) {
                        ForEach(CoffeeSize.allCases, id: \.self) { size in
                            SizeButton(
                                size: size,
                                isSelected: selectedSize == size,
                                action: { selectedSize = size }
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Fiyat
                HStack {
                    Text("Total Price:")
                        .font(.title2)
                        .foregroundColor(.starbucksBrown)
                    Spacer()
                    Text("$\(totalPrice, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.starbucksGreen)
                }
                .padding()
                .background(Color.starbucksCream)
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Sepete ekle butonu
                Button(action: {
                    cartManager.addToCart(coffee: coffee, size: selectedSize)
                    showingAddedAlert = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add to Cart")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.starbucksGreen)
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Added to Cart! ✓", isPresented: $showingAddedAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// Boyut butonu komponenti
struct SizeButton: View {
    let size: CoffeeSize
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.title2)
                Text(size.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                if size.price > 0 {
                    Text("+$\(size.price, specifier: "%.2f")")
                        .font(.caption2)
                }
            }
            .foregroundColor(isSelected ? .white : .starbucksGreen)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isSelected ? Color.starbucksGreen : Color.starbucksCream)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.starbucksGreen, lineWidth: isSelected ? 0 : 2)
            )
        }
    }
}
