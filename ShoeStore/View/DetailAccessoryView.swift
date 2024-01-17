//
//  DetailAccessoryView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 22/12/2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct DetailAccessoryView: View {
    @State var product: Shoe
    @StateObject var shoeController = ShoeViewController()
    @StateObject var bagViewController =  BagController()
    @Environment(\.dismiss) var dismiss
    @State var showSizeScreen: Bool = false
    @State private var selectedSize: Int = 39
    @State private var showingAlert: Bool = false
    @State private var messageAlert = ""
    @State private var titleAlert = ""

    var body: some View {
        VStack{
            //Back button
            
            ZStack{
                ScrollView{
                    VStack{
                        AnimatedImage(url: URL(string:product.img_url))
                            .resizable()
                            .scaledToFit()
                        VStack(alignment: .leading) {
                            Text(product.type)
                                .font(.system(size: 19))
                                .bold()
                            Text(product.name)
                                .font(.system(size: 25))
                                .bold()
                            Text(String(product.price) + "$")
                                .padding(.vertical, 25)
                                .bold()
                            Text(product.description)
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 10)
                    }
                    VStack(spacing:20){
                        Button(action: { showSizeScreen.toggle() }) {
                            Text("Selected Size: \(selectedSize)")
                                .frame(width: 320, height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                        Button(action: {
                            //                                Task{
                            //                                    await addToCart(item: product)
                            //                                }
                            Task{
                                await bagViewController.addToCart(item: product)
                                showingAlert.toggle()
                            }
                        }) {
                            Text("Add to bag")
                                .frame(width: 320, height: 20)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(20)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Added to bag"), message:Text("Your shoe is added to bag successfully"), dismissButton: .default(Text("OK")))
                        }
                        Button(action: {addToFavorite(item: product)
                            showingAlert.toggle()}) {
                                Text("Add to favorite")
                                    .frame(width: 320, height: 20)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.black)
                                    .cornerRadius(20)
                            }
                            .padding(.bottom,20)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text(bagViewController.titleAlert), message:Text(bagViewController.messageAlert), dismissButton: .default(Text("OK")))
                            }
                    }
                }
            }
        }
        .navigationBarTitle(product.name, displayMode: .inline)
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
    func addToFavorite(item:Shoe){
        let db = Firestore.firestore()
        let favCollection = db.collection("Favorite")
        let documentRef = favCollection.document()
        
        documentRef.setData([
            "name" : item.name,
            "price": item.price,
            "img_url": item.img_url,
            "rating": item.rating,
            "description": item.description,
            "brand": item.brand,
            "type": item.type,
            "status": item.status
        ]){
            error in
            if let error = error{
                print("Failed adding document: \(error)")
                    bagViewController.showAlert(title: "Error", message: "Failed adding to favorite")
            }else{
                bagViewController.showAlert(title: "Added to favorite", message: "Added to your favorite successfully")
            }
        }
    }
}

struct DetailAccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAccessoryView(product: Shoe(id: "", brand: "", description: "", img_url: "", name: "", price: 0.0, rating: "", status: "", type: ""))
    }
}
