//
//  IntroView.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 08/09/2022.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            // background
            
            RadialGradient(
                gradient: Gradient(colors: [Color.purple,Color.pink ]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            // !!!: Tutorial is at 5:35
            
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
