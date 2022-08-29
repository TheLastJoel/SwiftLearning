//
//  EnvironmentObjectBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 26/08/2022.
//

import SwiftUI

class EnvironmentViewModel: ObservableObject{
    
    @Published var dataArray: [String] = []
    
    init(){
        getData()
    }
    
    func getData(){
        self.dataArray.append(contentsOf: ["iPad","iPhone","iMac","Apple Watch"])
    }
}

struct EnvironmentObjectBootcamp51: View {
    
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink(destination: DetailView(selecteditem: item),
                                   label: {Text(item)})
                }
            }
            .navigationTitle("iOS Devices")
        }

    }
}

struct DetailView: View{
    
    let selecteditem: String
    
    var body: some View{
        ZStack{
            
            Color.orange.ignoresSafeArea()
            
            NavigationLink(destination: FinalView(), label: {
                Text(selecteditem)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(30)
            })

        }
    }
}

struct FinalView: View{
    
    var body: some View{
        ZStack{
            //background
            LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 20){
                    Text("Item1")
                    Text("Item2")
                    Text("Item3")
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
        }
    }
}

struct EnvironmentObjectBootcamp51_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectBootcamp51()
//        DetailView(selecteditem: "iPhone")
//        FinalView()
    }
}
