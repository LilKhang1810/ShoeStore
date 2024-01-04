//
//  DetailNewsView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 26/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailNewsView: View {
    @EnvironmentObject var newsController: NewsController 
    @State var news : News
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int
    var body: some View {
        
            NavigationStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        AnimatedImage(url: URL(string: news.imgSrc))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 400)
                            .clipped()
                        Text(news.photoTitle)
                            .font(.system(size: 30).bold())
                        Text(news.description)
                            .padding(.vertical,10)
                            .padding(.horizontal,10)
                    }
                    Button(action: {
                        // Thực hiện các hành động khi nhấn vào nút "Shop Now"
                        selectedTab = 1 // Đặt selectedTab thành 1
                        dismiss() // Đóng màn hình hiện tại
                    }) {
                        Text("Shop Now")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                }
            }
            .navigationTitle(news.photoTitle)
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
}

struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView(news: News(
            photoTitle: "Discover the lastest",
            imgSrc: "https://i.pinimg.com/564x/24/23/39/242339f684884bf285e1fea95a9f8b0e.jpg",
            description: "Sustainability with a focus on eco-friendly materials and production methods. Sneaker collaborations and limited releases highly anticipated by collectors and fans. Vintage and retro styles from the '80s and '90s making a comeback. High-tech features like self-lacing systems and smart sneakers gaining popularity. The industry becoming more inclusive with gender-neutral and gender-inclusive designs. Customization options allowing customers to personalize their sneakers. Luxury brands entering the sneaker market, blurring the line between streetwear and high fashion."), selectedTab: .constant(1))
    }
}
