//
//  HomeView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 26/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject var newController : NewsController = NewsController()
    @Binding var selectedTab: Int
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment: .leading) {
                        Text("Discovery")
                            .font(.system(size: 30))
                            .bold()
                        Text("Tuesday 26 December")
                            .fontWeight(.light)
                    }
                    .padding(.trailing,150)
                    VStack(alignment: .leading){
                        ForEach(newController.news, id: \.self) { news in
                            NavigationLink(destination: DetailNewsView(news: News(photoTitle: news.photoTitle, imgSrc: news.imgSrc, description: news.description), selectedTab: $selectedTab)) {
                                VStack(alignment:.leading){
                                    AnimatedImage(url: URL(string: news.imgSrc))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 700)
                                        .clipped()
                                        .background(.blue)
                                        .overlay(alignment:.bottom) {
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.black,lineWidth: 2)
                                                    .background(.white)
                                                    .cornerRadius(20)
                                                    .frame(width: 150,height: 50)
                                                    
                                                Text("View More")
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.trailing,180)
                                            .padding(.bottom,30)
                                        }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(1))
    }
}
