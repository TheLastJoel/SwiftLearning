//
//  DragGestureBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 28/09/2022.
//

import SwiftUI

struct DragGestureBootcamp4: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack{
                Text("\(offset.width)")
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500, alignment: .center)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
                
            )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currrentAmount = abs(offset.width)
        let fraction = currrentAmount / max
        return 1.0 - min(fraction, 0.5)*0.5
    }
    
    func getRotationAmount() -> Double{
        let max = UIScreen.main.bounds.width/2
        let currentAmount = offset.width
        let fraction = currentAmount / max
        let percentageAsDouble = Double(fraction)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp4()
    }
}
