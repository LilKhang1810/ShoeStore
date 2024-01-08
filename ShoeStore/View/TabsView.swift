//
//  TabsView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 08/01/2024.
//

import SwiftUI

struct TabsView: View {
    @State var selectedTab: Int = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            ListShoeView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shop")
                }
                .tag(1)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
                .tag(2)
            BagView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Bag")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .frame(height: 870, alignment: .bottom)
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
