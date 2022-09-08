//
//  viewModelBootcamp50.swift
//  SwiftUIBootcamp
//
//  Created by Joel Bearn on 08/09/2022.
//

import SwiftUI

struct FruitModel: Identifiable {
    
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    
    @Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    init(){
        getFruits()
    }
    
    func getFruits(){
        let fruit1 = FruitModel(name: "Orange", count: 1)
        let fruit2 = FruitModel(name: "Banana", count: 2)
        let fruit3 = FruitModel(name: "Water Melon", count: 88)
        
        isLoading = true
        
        // need self. because the code is inside a closure
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)
            
            self.isLoading = false
        }
        
        

        
    }
    
    func deleteFruit(index: IndexSet){
        fruitArray.remove(atOffsets: index)
    }
    
}

struct viewModelBootcamp50: View {
    
    
    //@StateObject -> USE THIS ON CREATION / INIT
    //@ObservedObject -> USE THIS FOR SUBVIEWS
    
    
    //if view refreshes, then observed object reloads.
//    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    //if you want data to persist even in reloading, then use state object instead of observed object. That is the difference between the two.
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView{
            List{
                
                if fruitViewModel.isLoading{
                    ProgressView()
                }
                else{
                    ForEach(fruitViewModel.fruitArray){ fruit in
                        HStack{
                            Text("\(fruit.count)")
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                                .bold()
                        }
                    }
                    .onDelete(perform: fruitViewModel.deleteFruit)
                }

            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Fruit List")
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: RandomScreen(fruitViewModel: fruitViewModel),
                    label: {
                    Image(systemName: "arrow.right")
                        .font(.title)
                    })
            )

        }
    }

    
}

struct RandomScreen: View{
    
    @Environment(\.dismiss) var dismiss
    //observedobject as this is not where the fruitViewModel is created. i.e one is passed through
    @StateObject var fruitViewModel: FruitViewModel
    
    var body: some View{
        ZStack{
            Color.green.ignoresSafeArea()
            
            Button {
                dismiss()
            } label: {
                VStack{
                    ForEach(fruitViewModel.fruitArray){ fruit in
                        Text(fruit.name)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }

        }
    }
}

struct viewModelBootcamp50_Previews: PreviewProvider {
    static var previews: some View {
        viewModelBootcamp50()
//        RandomScreen()
    }
}
