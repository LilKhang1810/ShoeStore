//
//  FavoriteView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 02/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct FavoriteView: View {
    @ObservedObject var favController = FavoriteController()
    @State var liked : Bool = true
    var body: some View {
        NavigationStack{
                ScrollView{
                    VStack(alignment:.leading){
                        Text("Favorite Shoes")
                            .font(.system(size: 30))
                            .bold()
                            .padding(.horizontal,10)
                            .padding(.vertical,30)
                        VStack{
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                                ForEach(favController.favShoes, id: \.self) { shoe in
                                    NavigationLink(destination: DetailProductView(product: Shoe(id:shoe.id,brand: shoe.brand, description: shoe.description, img_url: shoe.img_url, name: shoe.name, price: shoe.price, rating: shoe.rating, status: shoe.status, type: shoe.type))) {
                                        VStack{
                                            AnimatedImage(url: URL(string: shoe.img_url))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 170,height:170)
                                                .clipped()
                                            VStack(alignment: .leading){
                                                Text(shoe.name)
                                                    .multilineTextAlignment(.leading)
                                                    .font(.system(size: 15))
                                                    .bold()
                                                    .padding(.horizontal,10)
                                                HStack{
                                                    Text(String(shoe.price) + "$")
                                                        .padding(10)
                                                        .bold()
                                                    Spacer()
                                                    Button(action: {favController.delete(id: shoe.id)}) {
                                                        Image(systemName:"heart.fill")
                                                    }
                                                    .padding(.trailing,10)
                                                }
                                            }
                                            .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
