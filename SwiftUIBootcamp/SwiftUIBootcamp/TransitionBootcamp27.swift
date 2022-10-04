//
//  TransitionBootcamp27.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 30/09/2022.
//

import SwiftUI

struct TransitionBootcamp27: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                Button("BUTTON") {
                    showView.toggle()
                }
                Spacer()
            }
            if showView{
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height*0.5)
//                    .transition(.slide)
//                    .transition(.move(edge: .bottom))
//                    .transition(AnyTransition.scale.animation(.easeInOut))
//                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
                    .animation(.easeInOut(duration: 0.2))
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransitionBootcamp27_Previews: PreviewProvider {
    static var previews: some View {
        TransitionBootcamp27()
    }
}
