//
//  FavoriteController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 02/01/2024.
//

import Foundation
import SwiftUI
import Firebase

class FavoriteController: ObservableObject{
    @Published var favShoes: [Shoe] = []
    private var db = Firestore.firestore()
    
    init(){
        startListeningForChanges()
    }
    
    
    
    func startListeningForChanges() {
        let ref = db.collection("Favorite")
        // Lắng nghe sự kiện thay đổi
        ref.addSnapshotListener { snapshot, error in
            guard error == nil else {
                print("Error listening for changes: \(error!.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                // Cập nhật danh sách khi có sự kiện thay đổi
                self.favShoes = snapshot.documents.compactMap { document in
                    let data = document.data()
                    let brand = data["brand"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.0
                    let rating = data["rating"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let quantity = data["quantity"] as? Int ?? 0
                    return Shoe(brand: brand, description: description, img_url: img_url, name: name, price: price, rating: rating, status: status, type: type,quantity: quantity)
                }
            }
        }
    }
}
