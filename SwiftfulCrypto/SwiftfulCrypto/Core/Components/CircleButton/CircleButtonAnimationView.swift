//
//  CircleButtonAnimationView.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 05/10/2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
//    Changed to @Binding (instead of @State) so can be changed on home view. Bindings cannot be private
    @Binding var animate: Bool
    
//    @State private var animate: Bool = false
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.5)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1) : .none)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        // The .constant(false) is to simulate a binding
        CircleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.red )
            .frame(width: 100, height: 100, alignment: .center)
    }
}
