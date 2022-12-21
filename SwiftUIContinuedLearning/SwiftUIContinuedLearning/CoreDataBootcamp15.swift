//
//  CoreDataBootcamp15.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 19/12/2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntitites: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error loading Core Data 💔 \(error)")
            } else{
                print("Successfully loaded Core Data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
           savedEntitites = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching 💔 \(error)")
        }
    }
    
    func addFruit(text: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet){
        
        guard let index = indexSet.first else {return}
        let entity = savedEntitites[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving 💔 \(error)")
        }
    }
    
}

struct CoreDataBootcamp15: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else {return}
                    vm.addFruit(text: textFieldText)
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List{
                    ForEach(vm.savedEntitites) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())

            }.navigationTitle("fruits")
        }
    }
}

struct CoreDataBootcamp15_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp15()
    }
}
