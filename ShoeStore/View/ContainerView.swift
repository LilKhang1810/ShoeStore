//
//  ContainerView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 25/12/2023.
//

import SwiftUI

struct ContainerView: View {
    @State var selectedTab: Int = 1
    @EnvironmentObject var viewModel : AuthencationController
    var body: some View {
        NavigationView{
            if viewModel.signIn{
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
            else{
                LoginView()
            }
        }
        .onAppear{
            viewModel.signIn = viewModel.issignedIn
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .environmentObject(AuthencationController())
    }
}
