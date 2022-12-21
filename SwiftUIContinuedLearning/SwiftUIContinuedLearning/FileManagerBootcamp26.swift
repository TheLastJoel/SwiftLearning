//
//  FileManagerBootcamp26.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 21/12/2022.
//

import SwiftUI

class FileManagerViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder(){
        image = UIImage(named: "MontyPython")
    }
    
    
}

struct FileManagerBootcamp26: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let image = vm.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                    
                    Spacer()
                }
                
                Button {
                    
                } label: {
                    Text("Save to FM")
                        .foregroundColor(.white)
                        .padding()
                }

                
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp26_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp26()
    }
}
