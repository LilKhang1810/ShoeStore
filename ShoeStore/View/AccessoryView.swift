//
//  ContentView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 15/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AccessoryView: View {
    @ObservedObject var accessoryController = AccessoryController()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
                        ForEach(accessoryController.accessories, id: \.self) { item in
                            NavigationLink(destination:DetailAccessoryView(product: Accessory(name: item.name, description: item.description, img_url: item.img_url, price: item.price, rating: item.rating))) {
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
