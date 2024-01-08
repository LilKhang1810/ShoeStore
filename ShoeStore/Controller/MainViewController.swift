//
//  MainViewController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 08/01/2024.
//

import Foundation
import FirebaseAuth
class MainViewController: ObservableObject{
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    init(){
        self.handler = Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    public var isSignIn: Bool{
        return Auth.auth().currentUser != nil
    }
}
