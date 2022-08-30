//
//  ImageBootcamp7.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 29/08/2022.
//

import SwiftUI

struct ImageBootcamp7: View {
    var body: some View {
        VStack{
        Image("WHITEBEAR")
            .resizable()
//            .aspectRatio(contentMode: .fill)
            .scaledToFill()
            .frame(width: 300, height: 200)
            .clipShape(Circle())
//            .frame(width: 300, height: 200)
//            .cornerRadius(150)
            .clipped()
            .padding()
        
        Image("GOOGLE")
//            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 200)
            .foregroundColor(.red)
        }
    }
}

struct ImageBootcamp7_Previews: PreviewProvider {
    static var previews: some View {
        ImageBootcamp7()
    }
}
