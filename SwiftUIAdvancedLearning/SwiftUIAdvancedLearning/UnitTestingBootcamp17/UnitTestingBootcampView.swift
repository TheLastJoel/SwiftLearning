//
//  UnitTestingBootcampView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Joel Bearn on 04/10/2022.
//

/*
 
 1. Unit Tests
 - test the business logic in your app
 
 2. UI Tests
 - test the UI of your app
 
 */

import SwiftUI


struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool){
        //apparently underscore needed to set up property wrapper (i.e. @StateObject)?
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcampView(isPremium: true)
    }
}
