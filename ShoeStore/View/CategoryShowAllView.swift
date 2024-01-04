//
//  CategoryShowAllView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 21/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryShowAllView: View {
    @ObservedObject var shoeviewController = ShoeViewController()
    let productType: String
    @Environment(\.dismiss) var dismiss
    var filteredShoes: [Shoe] {
        shoeviewController.shoes.filter { $0.type == productType }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                        ForEach(filteredShoes, id: \.self) { shoe in
                            NavigationLink(destination:DetailProductView(product: Shoe(brand: shoe.brand, description: shoe.description, img_url: shoe.img_url, name: shoe.name, price: shoe.price, rating: shoe.rating, status: shoe.status, type: shoe.type))) {
                                VStack {
                                    AnimatedImage(url: URL(string: shoe.img_url))
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                    Text(shoe.name)
                                        .font(.caption)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .padding(.top, 8)
                                        .frame(width: 120, height: 50)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    shoeviewController.fetchShoe()
                }
            }
        }
        .navigationTitle("\(productType)")
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

struct CategoryShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryShowAllView(productType: "Lifestyle Shoes")
    }
}
