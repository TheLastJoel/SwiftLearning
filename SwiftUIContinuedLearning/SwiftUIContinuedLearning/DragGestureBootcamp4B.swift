//
//  DragGestureBootcamp4B.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 28/09/2022.
//

import SwiftUI

struct DragGestureBootcamp4B: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height*0.85
    @State var endingOffsetY: CGFloat = 0
    @State var currentDragOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            MySignUpView()
                .offset(y:startingOffsetY)
                .offset(y:currentDragOffsetY)
                .offset(y:endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150{
                                    endingOffsetY = -startingOffsetY
                                }
                                else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                            
                        })
                )
            VStack{
                Text("\(currentDragOffsetY)")
                Spacer()
            }
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp4B_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp4B()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("This is the description of our app. This is my favourite SwiftUI course and I recommend to all of my friends to subscribe!")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
