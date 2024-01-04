//
//  DetailProductView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 16/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct DetailProductView: View {
    @State var product: Shoe
    @EnvironmentObject var shoeManager: ShoeViewController
    @Environment(\.dismiss) var dismiss
    @State var showSizeScreen: Bool = false
    @State private var selectedSize: Int = 39
    @State private var showingAlert: Bool = false
    @State private var messageAlert = ""
    @State private var titleAlert = ""
    var body: some View {
        VStack {
            // Back button
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        AnimatedImage(url: URL(string: product.img_url))
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
                                Task{
                                    await addToCart(item: product)
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
                                Alert(title: Text(titleAlert), message:Text(messageAlert), dismissButton: .default(Text("OK")))
                            }
                            Button(action: {addToFavorite(item: product)}) {
                                Text("Add to favorite")
                                    .frame(width: 320, height: 20)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.black)
                                    .cornerRadius(20)
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text(titleAlert), message:Text(messageAlert), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                }

                sizeScreen(showSizeScreen: $showSizeScreen, selectedSize: $selectedSize) { newSize in
                    // Handle the selected size here
                    selectedSize = newSize
                    showSizeScreen = false // Hide the sizeScreen when a size is selected
                }
                .offset(y: showSizeScreen ? 180 : UIScreen.main.bounds.height * (1))
                .animation(.spring())
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
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
    func addToCart(item: Shoe) async {
        let db = Firestore.firestore()

        do {
            let cartCollection = db.collection("Cart")
            // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng hay chưa
            if let existingDocument = try await cartCollection.whereField("name", isEqualTo: item.name).getDocuments().documents.first {
                // Nếu sản phẩm đã tồn tại, tăng số lượng
                let currentQuantity = existingDocument.data()["quantity"] as? Int ?? 1
                try await existingDocument.reference.updateData(["quantity": currentQuantity + 1])
                showAlert(title: "Successed", message: "Added to bag successfully")
            } else {
                // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới với số lượng là 1
                let documentRef = cartCollection.document()
                try await documentRef.setData([
                    "name" : item.name,
                    "price": item.price,
                    "img_url": item.img_url,
                    "rating": item.rating,
                    "description": item.description,
                    "brand": item.brand,
                    "type": item.type,
                    "status": item.status,
                    "quantity": 1
                ])
                showAlert(title: "Successed", message: "Added to bag successfully")
            }
        } catch {
            print("Error adding/updating document: \(error)")
            showAlert(title: "Error", message: "Failed to add/update item to bag.")
        }
    }

    func showAlert(title: String, message: String) {
            titleAlert = title
            messageAlert = message
            showingAlert = true
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
                showAlert(title: "Error", message: "Failed adding to favorite")
            }else{
                showAlert(title: "Added to favorite", message: "Added to your favorite successfully")
            }
        }
    }
}

struct DetailProductView_Previews: PreviewProvider {
    static var previews: some View {
        DetailProductView(product: Shoe(brand: "",
                                        description: "The signature adidas Stan Smith shoe line explores the timeless world of BAPE — resulting in a design made for the golf course. With a design suitable for both the golf course and clubhouse, these shoes blend classic tennis style with golf-appropriate details.",
                                        img_url: "https://assets.adidas.com/images/w_600,f_auto,q_auto/87cd0b80e0434c758b15ae9801598eb2_9366/Giay_Chay_Bo_adidas_4DFWD_2_Xam_GX9250_01_standard.jpg",
                                        name: "Adidas 4DFWD 2",
                                        price: 205,
                                        rating: "",
                                        status: "",
                                        type: "Gym Shoes"))
    }
}

struct sizeScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSizeScreen: Bool
    @Binding var selectedSize: Int
    var onSizeSelected: (Int) -> Void
    let sizeRange = 39..<45

    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    Text("Size")
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .font(.system(size: 25))
                    Spacer()
                    Button(action: {
                        showSizeScreen.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                Form {
                    Picker("", selection: $selectedSize) {
                        ForEach(sizeRange, id: \.self) { size in
                            Text("\(size)").tag(size)
                                .font(.system(size: 20))
                        }
                    }
                    .pickerStyle(.inline)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
        .onChange(of: selectedSize) { newValue in
            onSizeSelected(newValue)
        }
    }
}


