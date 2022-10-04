//
//  FirebaseAuthSignUpTutorialApp.swift
//  FirebaseAuthSignUpTutorial
//
//  Created by Joel Bearn on 30/09/2022.
//

import SwiftUI
import Firebase

@main
struct FirebaseAuthSignUpTutorialApp: App {
    
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(dataManager)
        }
    }
}
