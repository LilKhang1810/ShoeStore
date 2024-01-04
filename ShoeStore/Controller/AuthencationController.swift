//
//  AuthencationController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 03/01/2024.
//

import Foundation
import FirebaseAuth

class AuthencationController: ObservableObject{
    let auth = Auth.auth()
    @Published var signIn = false
    var issignedIn: Bool{
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self]result,error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signUp( email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signIn = false
    }
}
