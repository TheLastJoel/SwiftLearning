//
//  ProtocolsBootcamp15.swift
//  SwiftUIAdvancedLearning
//
//  Created by Joel Bearn on 03/10/2022.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .black
    let secondary: Color = .white
    let tertiary: Color = .pink
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .orange
    var secondary: Color = .black
    var tertiary: Color = .yellow
    
}

protocol ColorThemeProtocol {
    
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
    
    
}

protocol ButtonTextProtocol {
    var buttonText: String {get}
    
}

protocol ButtonPressedProtocol {
    
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol{
    
}

class DefaultDataSource: ButtonDataSourceProtocol{
    
    var buttonText: String = "We could be heros, just for one day"
    
    func buttonPressed(){
        print("Button was pressed")
    }
}

class AlternativeDataSource: ButtonTextProtocol{
    var buttonText: String = "Oh! you pretty things"
    
}

struct ProtocolsBootcamp15: View {
    
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
    
    //interesting how colorTheme conforms to a protocol although looks like a type.
    
    let dataSource: ButtonDataSourceProtocol
    let colorTheme: ColorThemeProtocol
    
    var body: some View {
        ZStack{
            
            colorTheme.tertiary.ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
             
        }
    }
}

struct ProtocolsBootcamp15_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp15(dataSource: DefaultDataSource(), colorTheme: AnotherColorTheme())
    }
}
