//
//  FaveAndRateApp.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-18.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,

                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true

  }

}


@main
struct FaveAndRateApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var dbConnection = DbConnection()
    @StateObject var movieManager = MovieManager() // Is this suppose to be StateObject? This code fixed our login issue
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dbConnection)
                .environmentObject(movieManager) // Is this suppose to be StateObject? This code fixed our login issue
        }
    }
}
