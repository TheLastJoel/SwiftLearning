//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 05/10/2022.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
