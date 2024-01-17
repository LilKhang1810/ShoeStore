import SwiftUI
import Firebase
import FirebaseAuth
class BagController: ObservableObject {
    @Published var shoes: [Shoe] = []
    private let db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    @State var showingAlert: Bool = false
    @State var messageAlert = ""
    @State var titleAlert = ""
    init() {
        fetchShoe()
        // Bắt đầu lắng nghe sự kiện thay đổi
        startListeningForChanges()
    }

    func fetchShoe() {
        guard let uId else{
            return
        }
        // Fetch dữ liệu ban đầu
        let ref = db.collection("User").document(uId).collection("Cart")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                self.shoes = snapshot.documents.compactMap { document in
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
                    let quantity = data["quantity"] as? Int ?? 0
                    return Shoe(id: id,brand: brand, description: description, img_url: img_url, name: name, price: price, rating: rating, status: status, type: type,quantity: quantity)
                }
            }
        }
    }

    func startListeningForChanges() {
        guard let uId else{
            return
        }
        let ref = db.collection("User").document(uId).collection("Cart")
        // Lắng nghe sự kiện thay đổi
        ref.addSnapshotListener { snapshot, error in
            guard error == nil else {
                print("Error listening for changes: \(error!.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                // Cập nhật danh sách khi có sự kiện thay đổi
                self.shoes = snapshot.documents.compactMap { document in
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
                    let quantity = data["quantity"] as? Int ?? 0
                    return Shoe(id:id,brand: brand, description: description, img_url: img_url, name: name, price: price, rating: rating, status: status, type: type,quantity: quantity)
                }
            }
        }
    }
    func delete(id: String){
        guard let uId else{
            return
        }
        let db = Firestore.firestore()
        
        db.collection("User")
            .document(uId)
            .collection("Cart")
            .document(id)
            .delete()
    }
    func addToCart(item: Shoe) async{
        guard let uId else{
            return
        }
        
        let newId  = UUID().uuidString
        
        let newItem = Shoe(id: newId,
                           brand: item.brand,
                           description: item.description,
                           img_url: item.img_url,
                           name: item.name,
                           price: item.price,
                           rating: item.rating,
                           status: item.status,
                           type: item.type)
        let db = Firestore.firestore()
        do{
            let cartItem = db.collection("User").document(uId).collection("Cart")
            if let existingItem = try await cartItem.whereField("name", isEqualTo: item.name).getDocuments().documents.first{
                
                let currentQuantity = existingItem.data()["quantity"] as? Int ?? 1
                try await existingItem.reference.updateData(["quantity": currentQuantity+1])
                showAlert(title: "Added to bag", message: "Your shoe is added to bag successfully")
                
            }
            else{
                let documentRef = cartItem.document(newId)
                try await documentRef.setData(newItem.asDictionary())
                showAlert(title: "Added to bag", message: "Your shoe is added to bag successfully")
            }
        }
        catch {
            print("Error adding/updating document: \(error)")
        }
    }
    func showAlert(title: String, message: String){
        titleAlert = title
        messageAlert = message
        showingAlert = true
    }
}
