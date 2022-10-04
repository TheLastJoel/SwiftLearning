//
//  ListView.swift
//  FirebaseAuthSignUpTutorial
//
//  Created by Joel Bearn on 30/09/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var dataMangager: DataManager
    
    var body: some View {
        NavigationView {
            List(dataMangager.dogs, id: \.id) { dog in
                Text(dog.breed)
            }
            .navigationTitle("Dogs")
            .navigationBarItems(trailing: Button(action: {
                //add
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
