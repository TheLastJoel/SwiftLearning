//
//  AlertBootcamp32.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 16/12/2022.
//

import SwiftUI

struct AlertBootcamp32: View {
    
    @State var showAlert: Bool = false
    @State var alertType: MyAlerts? = nil
//    @State var alertTitle: String = ""
//    @State var alertMessage: String = ""
    @State var backgroundColour: Color = Color.yellow
    
    enum MyAlerts{
        case success
        case error
    }
    
    var body: some View {
        ZStack{
            
            backgroundColour.edgesIgnoringSafeArea(.all)
            
                VStack {
                    Button("Click Here") {
                        alertType = .error
                        //alertTitle = "ERROR UPLOADING VIDEO🥸"
                        //alertMessage = "The video could not be uploaded"
                        showAlert.toggle()
                    }
                    Button("Don't click here") {
                        alertType = .success
                        //alertTitle = "success!✅"
                        //alertMessage = "Keep the change"
                        showAlert.toggle()
                    }

                }
                .alert(isPresented: $showAlert) {
                    //Alert(title: Text("There was an error!"))
                    getAlert()
            }
        }
    }
    
    func getAlert() -> Alert{
        
        switch alertType {
        case .error:
            return Alert(title: Text("There was an error🛑"))
        case .success:
            return Alert(title: Text("This was a success ✅"),dismissButton: .default(Text("OK"),action: {
                backgroundColour = .green
            }))
        default:
            return Alert(title: Text("ERROR"))
        }
        
        
//        return Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        
//        return                 Alert(
//            title: Text("This is the title"),
//            message: Text("Here we will describe the error"),
//            primaryButton: .destructive(Text("Delete"),action: {
//                backgroundColour = .red
//            }),
//            secondaryButton: .cancel()
//        )
    }
}

struct AlertBootcamp32_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp32()
    }
}
