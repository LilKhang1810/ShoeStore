//
//  ShowAllView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 18/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct BrandShowAllView: View {
    let selectedBrand: String
    
    @ObservedObject var shoeManager = ShoeViewController()
    @Environment(\.dismiss) var dismiss
    var filteredShoes: [Shoe] {
        shoeManager.shoes.filter { $0.brand == selectedBrand }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20) {
                        ForEach(filteredShoes, id: \.self) { shoe in
                            NavigationLink(destination: DetailProductView(product: Shoe(brand: shoe.brand, description: shoe.description, img_url: shoe.img_url, name: shoe.name, price: shoe.price, rating: shoe.rating, status: shoe.status, type: shoe.type))) {
                                VStack {
                                    AnimatedImage(url: URL(string: shoe.img_url))
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                    Text(shoe.name)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .fontWeight(.regular)
                                        .padding(.top, 8)
                                        .frame(width: 120, height: 50)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Shoes from \(selectedBrand)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image("left")
                                .resizable()
                                .frame(width: 30,height: 30)
                        }

                    }
                }
    }
}

struct ShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        BrandShowAllView(selectedBrand:"Vans")
            .environmentObject(ShoeViewController())
    }
}
