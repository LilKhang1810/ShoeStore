//
//  SearchView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 07/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct SearchView: View {
    @State var txt = ""
    @ObservedObject var data = ShoeViewController()
    @Environment(\.dismiss) var dismiss
    var body : some View{
        NavigationStack{
            ScrollView{
                VStack(spacing: 0){
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: self.$txt)
                        Button(action: {
                            
                            dismiss()
                            
                        }) {
                            
                            Text("Cancel")
                        }
                        .foregroundColor(.black)
                        
                        
                        
                    }.padding()
                    
                    if self.txt != ""{
                        
                        if  data.shoes.filter({$0.name.lowercased().contains(self.txt.lowercased())}).count == 0{
                            
                            Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                        }
                        else{
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20) {
                                ForEach(data.shoes.filter({$0.name.lowercased().contains(self.txt.lowercased())}), id: \.self) { shoe in
                                    NavigationLink(destination: DetailProductView(product: Shoe(id:shoe.id,brand: shoe.brand, description: shoe.description, img_url: shoe.img_url, name: shoe.name, price: shoe.price, rating: shoe.rating, status: shoe.status, type: shoe.type))) {
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
                }.background(Color.white)
                    .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
