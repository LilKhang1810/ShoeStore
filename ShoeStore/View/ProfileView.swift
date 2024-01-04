//
//  ProfileView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 02/01/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authencationViewModel: AuthencationController
    var body: some View {
        VStack(alignment: .leading){
            Text("Account")
                .font(.system(size: 25))
                .bold()
                .padding(.vertical,40)
            Divider()
            Item(itemName: "Profile", icon: "person")
            Item(itemName: "Order", icon: "shippingbox.circle")
            Item(itemName: "Address", icon: "mappin.circle")
            Spacer()
            Button(
                action: {authencationViewModel.signOut()},
                label: {
                    HStack{
                        Image(systemName: "chevron.backward.square")
                            .foregroundColor(.red)
                            .font(.system(size: 30))
                        Text("Log Out")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    }
                    .padding(.leading,10)
                })
        }
        .padding(10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthencationController())
    }
}

struct Item: View{
    let itemName: String
    let icon: String
    var body: some View{
        HStack{
            Image(systemName: icon)
                .padding(.horizontal,10)
                .frame(width: 50, height: 50)
                .font(.system(size: 30))
            Text(itemName)
        }
        .font(.system(size: 20))
    }
}
