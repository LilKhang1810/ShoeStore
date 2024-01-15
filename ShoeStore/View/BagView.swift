//
//  BagView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 28/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct BagView: View {
    @ObservedObject var bagController = BagController()
    @State var isCheckout: Bool = false
    @State private var showingAlert: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        ForEach(bagController.shoes, id: \.self) { shoe in
                            NavigationLink(destination: DetailProductView(product: Shoe(id: shoe.id,brand: shoe.brand, description: shoe.description, img_url: shoe.img_url, name: shoe.name, price: shoe.price, rating: shoe.rating, status: shoe.status, type: shoe.type))) {
                                VStack(alignment:.leading){
                                    HStack{
                                        AnimatedImage(url: URL(string: shoe.img_url))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100,height: 100)
                                            .clipped()
                                        VStack(alignment: .leading){
                                            Text(shoe.name)
                                                .multilineTextAlignment(.leading)
                                                .bold()
                                            Text(shoe.type)
                                        }
                                        .foregroundColor(.black)
                                        Spacer()
                                        Button(action: {
                                            bagController.delete(id: shoe.id)
                                        }){
                                            Image(systemName: "trash")
                                                .foregroundColor(.black)
                                        }
                                        .padding(.trailing,10)
                                    }
                                    HStack {
                                            Text("Qty: \(shoe.quantity)")
                                            Spacer()
                                            Text(String(shoe.price * Double(shoe.quantity)) + "$")
                                        }
                                        .foregroundColor(.black)
                                        .padding(10)
                                }
                                
                            }
                            
                        }
                        HStack{
                            Text("Total")
                                .bold()
                            Spacer()
                            Text(String(bagController.shoes.reduce(0) { $0 + (Double($1.quantity) * $1.price) })+"$")
                        }
                        .font(.system(size:20))
                        .padding(.horizontal,10)
                        .padding(.vertical,30)
                    }
                    
                    NavigationLink(destination: CheckoutView(totalAmount: bagController.shoes.reduce(0) { $0 + (Double($1.quantity) * $1.price) })) {
                        Text("Checkout")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(.black)
                            .cornerRadius(20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct BagView_Previews: PreviewProvider {
    static var previews: some View {
        BagView()
    }
}


