//
//  NewsController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 26/12/2023.
//

import Foundation
import SwiftUI
import Firebase

class NewsController: ObservableObject{
    @Published var news: [News] = []
    init(){
        fetchNews()
    }
    func fetchNews(){
        let db = Firestore.firestore()
        let ref = db.collection("News")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let title = data["photoTitle"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let imgSrc = data["imgSrc"] as? String ?? ""
                    let newsInf = News(photoTitle: title, imgSrc: imgSrc, description: description)
                    self.news.append(newsInf)
                }
            }
        }
    }
}
