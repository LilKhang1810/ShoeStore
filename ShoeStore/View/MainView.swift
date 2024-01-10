//
//  ContainerView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 25/12/2023.
//

import SwiftUI

struct MainView: View {
    @AppStorage("currentPage") var currentPage = 1 
    @State var selectedTab: Int = 1
    @EnvironmentObject var viewModel : AuthencationController
    @StateObject var mainViewVM  = MainViewController()
    var body: some View {
        NavigationView{
            if mainViewVM.isSignIn,!mainViewVM.currentUserId.isEmpty{
                if currentPage > totalPage{
                    TabsView()
                }
                else{
                    WalkthroughScreen()
                }
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

struct WalkthroughScreen: View{
    @AppStorage("currentPage") var currentPage = 1
    var body: some View{
        ZStack{
            if currentPage == 1 {
                SlideView(image: "1", title: "Step 1", detail: "Welcome to shoe app, where you can choose for yourself best shoe",bgColor: Color("Color1"))
                    .transition(.scale)
            }
            if currentPage == 2{
                SlideView(image: "2", title: "Step 2", detail: "Welcome to shoe app, where you can choose for yourself best shoe",bgColor: Color("Color2"))
                    .transition(.scale)
            }
            if currentPage == 3{
                SlideView(image: "3", title: "Step 3", detail: "Welcome to shoe app, where you can choose for yourself best shoe",bgColor: Color("Color3"))
                    .transition(.scale)
            }
        }
        .overlay (
            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage <= totalPage{
                        currentPage += 1
                    }
                    else
                    {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size:20,weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60,height: 60)
                    .background(.white)
                    .clipShape(Circle())
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                            Circle()
                                .trim(from: 0,to:CGFloat(currentPage)/CGFloat(totalPage))
                                .stroke(Color.black,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                    )
            }),alignment: .bottom
        )
    }
}

struct SlideView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                if currentPage == 1 {
                    Text("Hello new friend!")
                        .font(.system(size: 25).bold())
                }
                else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .font(.title3)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.system(size: 25).bold())
            
            Text(detail)
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer(minLength: 0)
        }
        .background(bgColor)
    }
}

var totalPage = 3
