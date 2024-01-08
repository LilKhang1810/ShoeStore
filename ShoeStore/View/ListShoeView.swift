//
//  ListShoeView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 15/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct ListShoeView: View {
    @StateObject var dataManager: BrandController = BrandController()
    @StateObject var shoeManager: ShoeViewController = ShoeViewController()
    @StateObject var bestshoeManager: BestSellShoeController = BestSellShoeController()
    @StateObject var recshoeManager: RecommendShoeController = RecommendShoeController()
    @StateObject var fieldManager: ProducttFieldController = ProducttFieldController()
    private let category = ["Men", "Wommen", "Kid"]
    @State var selectedIndex: Int = 0
    
    @State private var selectedBrand: String?
    
    @State private var productStatus: String?
    let columns = [
            GridItem(.fixed(100)),
            GridItem(.flexible()),
        ]
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment:.leading){
                        HStack{
                            Text("Shop")
                                .font(.system(size: 28).bold())
                                .padding()
                            Spacer()
                            NavigationLink(destination: SearchView()) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(0..<category.count) { i in
                                    CategoryView(isActive: i == selectedIndex, text: category[i])
                                        .onTapGesture {
                                            selectedIndex = i
                                        }
                                }
                            }
                            .padding()
                        }
                        Divider()
                        Text("This week's hightlight")
                            .font(.system(size: 20).bold())
                            .padding()
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(dataManager.brands, id: \.self) {shoe in
                                    NavigationLink(destination: BrandShowAllView(selectedBrand: shoe.brand)) {
                                        VStack(spacing:20){
                                            AnimatedImage(url: URL(string: shoe.img_url))
                                                .resizable()
                                                .frame(width: 180,height: 200 * (180 / 210))
                                                .cornerRadius(20)
                                            Text(shoe.name)
                                                .foregroundColor(.black)
                                                .font(.title3)
                                                .bold()
                                        }
                                        .frame(width: 180)
                                        .padding()
                                        .background(.ultraThickMaterial)
                                        .cornerRadius(20)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding(.bottom,20)
                        VStack(spacing: 40){
                            NavigationLink(destination: ProductFieldShowAll(productStatus: "new")) {
                                ProductFieldView(title: "New and Feature", img: "jordan")
                            }
                            NavigationLink(destination: ProductFieldShowAll(productStatus: "popular")) {
                                ProductFieldView(title: "Popular", img: "popular")
                            }
                            NavigationLink(destination: AccessoryView()) {
                                ProductFieldView(title: "Accessories", img: "accessories")
                            }
                        }
                        .padding(.bottom,20)
                        Divider()
                        Text("Our best sellers")
                            .font(.system(size: 20))
                            .padding()
                        VStack{
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3),spacing: 20){
                                ForEach(bestshoeManager.shoes.prefix(6),id:\.self) { item in
                                    NavigationLink(destination: DetailProductView(product:Shoe(brand: item.brand, description: item.description, img_url: item.img_url, name: item.name, price: item.price, rating: item.rating, status: item.status, type: item.type))) {
                                        VStack(alignment:.leading,spacing:20){
                                            AnimatedImage(url: URL(string: item.img_url))
                                                .resizable()
                                                .frame(width: 100,height: 200 * (100 / 210))
                                            VStack(alignment:.leading,spacing: 10) {
                                                Text(item.name)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                .bold()
                                                Text(String(item.price)+"$")
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .frame(width: 100,height: 200)
                                    }
                                }
                            }
                            NavigationLink(destination: ProductFieldShowAll( productStatus: "best")) {
                                Capsule()
                                    .stroke(Color.black,lineWidth:2)
                                    .frame(width: 130,height: 30)
                                    .overlay(Text("See All")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black))
                            }
                        }
                        Group{
                            Text("Something you may like")
                                .font(.system(size:20))
                                .padding(.top,40)
                                .padding(.horizontal,20)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(["Basketball Shoes", "Gym Shoes", "Running Shoes", "Lifestyle Shoes"], id: \.self) { category in
                                        NavigationLink(destination: CategoryShowAllView(productType: category)) {
                                            CategoryShoe(title: category, img_src: category.lowercased().replacingOccurrences(of: " ", with: ""))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Something you may like")
                            .font(.system(size:20))
                            .padding(.top,40)
                            .padding(.horizontal,20)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 30){
                                ForEach(recshoeManager.recShoes, id: \.self) {shoe in
                                    NavigationLink {
                                        DetailProductView(product: Shoe(brand: shoe.brand,
                                                                        description:shoe.description,
                                                                        img_url: shoe.img_url,
                                                                        name: shoe.name,
                                                                        price: shoe.price,
                                                                        rating: shoe.rating,
                                                                        status: shoe.status,
                                                                        type: shoe.type))
                                    } label: {
                                        VStack(alignment:.leading, spacing:20){
                                            AnimatedImage(url: URL(string: shoe.img_url))
                                                .resizable()
                                                .frame(width: 130,height: 200 * (130 / 210))
                                                .cornerRadius(20)
                                            Text(shoe.name)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.black)
                                            Text(String(shoe.price)+"$")
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        }
                                        .frame(width: 130,height: 200)
                                    }
                                }
                            }
                            .padding(.horizontal,20)
                        }
                    }
                }
            }
        }
            .navigationBarTitle("Shop", displayMode: .inline)
    }
}

struct ListShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ListShoeView()
            .environmentObject(BrandController())
            .environmentObject(BestSellShoeController())
            .environmentObject(RecommendShoeController())
            .environmentObject(ShoeViewController())
            .environmentObject(ProducttFieldController())
    }
}
struct CategoryView: View{
    let isActive: Bool
    let text:String
    var body: some View{
        VStack(alignment: .leading,spacing: 0){
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? .black : .black.opacity(0.5))
            if(isActive){
                Color.black
                    .frame(width: 15,height: 2)
                    .clipShape(Capsule())
            }
        }
        .padding(.trailing)
    }
}

struct ProductFieldView: View{
    let title: String
    let img: String
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
            HStack{
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                Spacer()
                Image(img)
                    .resizable()
                    .frame(width: 140, height: 100, alignment: .trailing)
                    .padding()
            }
            
        }
        .frame(height: 100)
        
    }
}


struct CategoryShoe: View {
    let title: String
    let img_src: String
    var body: some View {
        VStack{
            Image(img_src)
                .resizable()
                .frame(width: 150, height: 150)
            Text(title)
                .foregroundColor(.black)
                .bold()
                .font(.system(size: 15))
        }
        .padding(.horizontal,30)
    }
}
