//
//  ContainerView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 25/12/2023.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Int = 1
    @EnvironmentObject var viewModel : AuthencationController
    @StateObject var mainViewVM  = MainViewController()
    var body: some View {
        NavigationView{
            if mainViewVM.isSignIn,!mainViewVM.currentUserId.isEmpty{
                TabsView()
            }
            else{
                LoginView()
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthencationController())
    }
}
