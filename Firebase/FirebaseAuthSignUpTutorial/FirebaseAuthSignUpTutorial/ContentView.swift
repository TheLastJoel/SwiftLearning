//
//  ContentView.swift
//  FirebaseAuthSignUpTutorial
//
//  Created by Joel Bearn on 30/09/2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password: String = ""
    @State private var userIsLoggedIn: Bool = false
    
    var body: some View {
        
        if userIsLoggedIn{
            ListView()
        }
        else{
            content
        }


    }
    
    var content: some View{
        ZStack{
            Color.black

            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400, alignment: .center)
                .rotationEffect(Angle(degrees: 135))
                .offset(y: -350)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            
            VStack(spacing:20){
                Text("Welcome")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 40,weight: .bold, design: .serif))
                    .offset(y: -135)
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1, alignment: .center)
                SecureField("Password", text: $password )
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1, alignment: .center)
                
                VStack{
                    Button{
                        register()
                    } label:{
                        Text("Sign up")
                            .bold()
                            .frame(width: 200, height: 40, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.red,.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                            )
                    }
                    
                    Button{
                        login()
                    } label:{
                        Text("Already have an account? Log in")
                            .padding(.top)
                    }
                }
                .offset(y:50)
            }
            .foregroundColor(.white)
            .padding()
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        userIsLoggedIn = true
                    }
                }
            }
        }
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
