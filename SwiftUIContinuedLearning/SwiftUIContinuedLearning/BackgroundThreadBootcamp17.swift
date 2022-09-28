//
//  BackgroundThreadBootcamp17.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 28/09/2022.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject{
    
    @Published var dataArray: [String] = []
    
    func fetchData(){
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            //Checks which thread this code is running on
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check 1: \(Thread.isMainThread)")
                print("Check 1: \(Thread.current)")

            }

        }
        

    }
    
    private func downloadData() -> [String]{
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
    
}

struct BackgroundThreadBootcamp17: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing:10){
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
            }
        }
    }
}

struct BackgroundThreadBootcamp17_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp17()
    }
}
