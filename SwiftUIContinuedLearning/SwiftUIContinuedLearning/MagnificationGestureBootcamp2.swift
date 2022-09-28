//
//  MagnificationGestureBootcamp2.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 28/09/2022.
//

import SwiftUI

struct MagnificationGestureBootcamp2: View {
    
    @State var currentAmount: CGFloat = 0
//    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Circle().frame(width: 35, height: 35, alignment: .center)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                                currentAmount = value - 1
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                currentAmount = 0
                            }
                        }
                )
            HStack{
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.headline)
                Image(systemName: "text.bubble")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption to my photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
        }
        
    }
}

struct MagnificationGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp2()
    }
}
