//
//  DetailAccessoryView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 22/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailAccessoryView: View {
    @State var product: Accessory
    @EnvironmentObject var accessoryManager: AccessoryController
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            //Back button
            
            ZStack{
                ScrollView{
                    VStack{
                        AnimatedImage(url: URL(string:product.img_url))
                            .resizable()
                            .scaledToFit()
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
}

struct DetailAccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAccessoryView(product: Accessory(name: "", description: "", img_url: "", price: 0.0, rating: ""))
    }
}
