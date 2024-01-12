//
//  RecommendShoeController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 19/12/2023.
//

import SwiftUI
import Firebase
class RecommendShoeController: ObservableObject{
    @Published var recShoes: [Shoe] = []
    init(){
        fetchRecShoe()
    }
    func fetchRecShoe(){
        let db = Firestore.firestore()
        let ref = db.collection("PopularProducts")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print (error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let id = document.documentID
                    let brand = data["brand"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.0
                    let rating = data["rating"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let recshoe = Shoe(id:id,brand: brand, description: description, img_url: img_url, name: name, price: price, rating: rating, status: status,type: type)
                    self.recShoes.append(recshoe)
                    
                }
            }
        }
    }
}
