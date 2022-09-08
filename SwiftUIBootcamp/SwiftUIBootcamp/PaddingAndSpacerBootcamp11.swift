//
//  PaddingAndSpacerBootcamp11.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 07/09/2022.
//

import SwiftUI

struct PaddingAndSpacerBootcamp11: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color.red)
//            .padding(.leading,20)
            .padding(.bottom,20)
            Text("This is the description of what we will do on this sceen. It is multiple lines and we will align the text to the leading edge")
        }
        .padding()
        .padding(.vertical,30)
        .background(
            Color.white
                .cornerRadius(10)
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 10,
                    x: 0, y: 10))
        .padding(.horizontal,10)
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .background(Color.yellow)
//            .padding(.all, 10)
//            .padding(.leading, 20)
//            .background(Color.blue)
    }
}

struct PaddingAndSpacerBootcamp11_Previews: PreviewProvider {
    static var previews: some View {
        PaddingAndSpacerBootcamp11()
    }
}
