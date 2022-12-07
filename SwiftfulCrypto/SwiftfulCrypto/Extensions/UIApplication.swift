//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 10/10/2022.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditting(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
