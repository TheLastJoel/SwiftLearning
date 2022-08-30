//
//  SheetBootcamp7.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 30/08/2022.
//

import SwiftUI

struct SheetBootcamp7: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack{
            Color.green
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                Text("Button")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))
            })
            // One can use multiple sheets now, and with conditional logic too.
            .sheet(isPresented: $showSheet) {
                SecondScreen()
            }
        }
    }
}

struct SecondScreen:View{
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
        ZStack(alignment: .topLeading){
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
            .padding()

        }
    }
}


struct SheetBootcamp7_Previews: PreviewProvider {
    static var previews: some View {
        SheetBootcamp7()
    }
}
