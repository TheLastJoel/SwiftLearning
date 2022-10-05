//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 05/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                Text("AccentColor")
                    .foregroundColor(.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(.theme.red)
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)

        }
    }
}
