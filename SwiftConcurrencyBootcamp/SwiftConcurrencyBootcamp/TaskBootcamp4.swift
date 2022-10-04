//
//  TaskBootcamp4.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Joel Bearn on 29/09/2022.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async{
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        do {
            
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data,_) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY")
            })
            
           
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async{
        
        do {
            
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data,_) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
            })
            
           
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct TaskBootcampHomeView: View{
    
    var body: some View{
        NavigationView{
            ZStack{
                NavigationLink("Click ME! 🐶") {
                    TaskBootcamp4()
                }
            }
        }
    }
}

struct TaskBootcamp4: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
    
    @State private var fetchedImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing:40){
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
            }
            if let image = viewModel.image2{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
        .task {
            //autocancel of task if view disappears before action completes!
            await viewModel.fetchImage()
        }
        /*
        .onAppear(){

            self.fetchedImageTask = Task{
                await viewModel.fetchImage()
            }
            /*
            Task{
                print(Thread.current)
                print(Task.currentPriority)
                await viewModel.fetchImage2()
            }
             */
            
            /*
            Task(priority: .high){
//                try? await Task.sleep(nanoseconds: 2_000_000_000)
                await Task.yield()
                print("High: \(Thread.current) : \(Task.currentPriority)")
                
            }
            Task(priority: .userInitiated){
                print("User initiated: \(Thread.current) : \(Task.currentPriority)")
            }
            

            Task(priority: .medium){
                print("Med: \(Thread.current) : \(Task.currentPriority)")
            }


            Task(priority: .low){
                print("Low: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .utility){
                print("Utility: \(Thread.current) : \(Task.currentPriority)")
            }
            
            Task(priority: .background){
                print("Background: \(Thread.current) : \(Task.currentPriority)")
            }
             */
            
            /*
            Task(priority: .userInitiated){
                print("User initiated: \(Thread.current) : \(Task.currentPriority)")
                
                Task {
                    print("detached: \(Thread.current) : \(Task.currentPriority)")
                }
                
            }
             */
        }
        .onDisappear{
            fetchedImageTask?.cancel()
        }
         */
    }
}

struct TaskBootcamp4_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp4()
    }
}
