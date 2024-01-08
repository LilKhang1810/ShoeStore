//
//  AuthencationController.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 03/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
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
            guard result == result, error == nil else {
                print("Lỗi khi tạo tài khoản: \(error?.localizedDescription ?? "")")
                return
            }
            self?.savetoFirestore(email: result?.user.email ?? "")
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signIn = false
    }
    func savetoFirestore(email: String){
        let collection = Firestore.firestore().collection("user")
        let document = collection.document(email)
        document.setData([
            "id": document.documentID,
            "email": email
        ])
        {
            error in
            if let error = error {
                print("Lỗi khi lưu dữ liệu vào Firestore: \(error.localizedDescription)")
            }
            else{
                print("Dữ liệu đã được lưu vào Firestore thành công.")
            }
        }
    }
}
