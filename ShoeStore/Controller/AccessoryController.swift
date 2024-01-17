//
//  AccessoryController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 20/12/2023.
//

import Foundation
import Firebase

class AccessoryController: ObservableObject{
    @Published var accessories: [Accessory] = []
    
    init(){
        fetchProduct()
    }
    func fetchProduct(){
        accessories.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Accessory")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.0
                    let rating = data["rating"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let product = Accessory(name: name, description: description, img_url: img_url, price: price, rating: rating,type:type)
                    self.accessories.append(product)
                }
            }
        }
    }
}
