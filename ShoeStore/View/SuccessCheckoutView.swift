//
//  SuccessCheckoutView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 11/01/2024.
//

import SwiftUI

struct SuccessCheckoutView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    ZStack{
                        Circle()
                            .fill(.black)
                            .frame(width: 150,height: 150)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Text("Successed order")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .bold()
                    Text("Thank for shopping!")
                        .padding(.bottom,50)
                    NavigationLink(destination: BagView() ,label: {
                        Text("Go to the order")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .bold()
                            .background(
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 350,height: 50)
                                    .cornerRadius(20)
                                    .shadow(color: .gray, radius: 10,y:10)
                            )
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct SuccessCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCheckoutView()
    }
}
