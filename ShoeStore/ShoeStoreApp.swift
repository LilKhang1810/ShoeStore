//
//  ShoeStoreApp.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 15/12/2023.
//

import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print ("Firebase has connected")
    return true
  }
}
@main
struct ShoeStoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var shoeManager = ShoeViewController()
    @StateObject var authencationManager = AuthencationController()
    var body: some Scene {
        WindowGroup {
           ContainerView()
                .environmentObject(shoeManager)
                .environmentObject(authencationManager)
        }
    }
}
