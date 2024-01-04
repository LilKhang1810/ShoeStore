//
//  ShoeViewController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 15/12/2023.
//

import SwiftUI
import Firebase
class BrandController: ObservableObject{
    @Published var brands: [Brand] = []
   
    init(){
        fetchBrand()
    }
    func fetchBrand(){
        brands.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Brands")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let brand = data["brand"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let brandShoe = Brand(brand: brand, name: name, img_url: img_url)
                    self.brands.append(brandShoe)
                }
            }
        }
    }
}
