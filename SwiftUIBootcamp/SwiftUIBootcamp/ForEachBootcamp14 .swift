//
//  ForEachBootcamp14 .swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 08/09/2022.
//

import SwiftUI

struct ForEachBootcamp14_: View {
    
    let data: [String] = ["Hi", "Hello", "What's poppin"]
    
    var body: some View {
        VStack {
            ForEach(0..<10) { index in
                Text("Hi: \(index)")
            }
            ForEach(data.indices) { index in
                Text("\(data[index]) : \(index)")
            }
            
        }
    }
}

struct ForEachBootcamp14__Previews: PreviewProvider {
    static var previews: some View {
        ForEachBootcamp14_()
    }
}
