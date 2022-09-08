//
//  BackgroundMaterialsBootcamp55.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 08/09/2022.
//

import SwiftUI

struct BackgroundMaterialsBootcamp55: View {
    var body: some View {
        VStack{
            Spacer()
            VStack{
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 50, height: 4, alignment: .center)
                    .padding()
                Spacer()
                Text("Hi")
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
        }
        .background(
            Image("JamesWebb")
                .resizable()
                .scaledToFill()
        )
        .ignoresSafeArea()
    }
}

struct BackgroundMaterialsBootcamp55_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMaterialsBootcamp55()
    }
}
