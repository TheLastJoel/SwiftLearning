//
//  AnimationBootcamp25.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 07/09/2022.
//

import SwiftUI

struct AnimationBootcamp25: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        VStack{
            Button("Button") {
                //add Animation.default instead of .default when chaining with other modifiers.
                withAnimation(
                    Animation
                        .default
                        .repeatCount(5, autoreverses: true)
                ){
                    isAnimated.toggle()
                }
            }
            .padding()
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 10) // As 50 is half of 100 this makes a circle when animated.
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300 : 0)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0)) // rotating after the offset rotates around the offset point.
            
            Spacer()
        }
    }
}

struct AnimationBootcamp25_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootcamp25()
    }
}
 
