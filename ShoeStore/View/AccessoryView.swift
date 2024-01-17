//
//  ContentView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 15/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AccessoryView: View {
    @ObservedObject var accessoryController = ShoeViewController()
    @Environment(\.dismiss) var dismiss
    var filteredShoes: [Shoe] {
        accessoryController.shoes.filter { $0.type == "Accessory" }
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
                        ForEach(filteredShoes, id: \.self) { item in
                            NavigationLink(destination:DetailAccessoryView(product: Shoe(id: item.id, brand: item.brand, description: item.description, img_url: item.img_url, name: item.name, price: item.price, rating: item.rating, status: item.status, type: item.type))){
                                VStack {
                                    AnimatedImage(url: URL(string: item.img_url))
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                    Text(item.name)
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
            }
        }
        .navigationTitle("Accessory")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryView()
    }
}
