//
//  FirebaseToDoListApp.swift
//  FirebaseToDoList
//
//  Created by Joel Bearn on 26/08/2022.
//

import SwiftUI
import Firebase

@main
struct FirebaseToDoListApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
