import SwiftUI

struct ContentView: View {
    @StateObject private var cartManager = CartManager()
    
    var body: some View {
        NavigationView {
            List(Coffee.sampleCoffees) { coffee in
                NavigationLink(destination: CoffeeDetailView(coffee: coffee)) {
                    CoffeeRow(coffee: coffee)
                }
            }
            .navigationTitle("☕ Coffee Shop")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.starbucksGreen)
                                .font(.title3)
                            
                            if cartManager.itemCount > 0 {
                                Text("\(cartManager.itemCount)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 16, height: 16)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: 0)
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(cartManager)
    }
}

// ********** 
struct CoffeeRow: View {
    let coffee: Coffee
    
    var body: some View {
        HStack(spacing: 15) {
            Image(coffee.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(coffee.name)
                    .font(.headline)
                    .foregroundColor(.starbucksBrown)
                
                Text(coffee.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text("$\(coffee.basePrice, specifier: "%.2f")")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.starbucksGreen)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
