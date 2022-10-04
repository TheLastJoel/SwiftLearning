//
//  DependencyInjectionBootcamp16.swift
//  SwiftUIAdvancedLearning
//
//  Created by Joel Bearn on 03/10/2022.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL
// 2. Can't customise the init
// 3. Can't swap out dependencies

struct PostsModel: Codable, Identifiable{
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}

protocol DataServiceProtocol{
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    
    let url: URL
    
    init(url: URL){
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel]
    
    init(data: [PostsModel]?){
        self.testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "Imagine", body: "All The People"),
            PostsModel(userId: 2, id: 2, title: "Living", body: "Life In Peace"),
            ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
}

class Dependencies{
    
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol){
        self.dataService = dataService
    }
}


class DependencyInjectionViewModel: ObservableObject{
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol){
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts(){
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)

    }
    
}

struct DependencyInjectionBootcamp16: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol){
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.dataArray) { post in
                    Text("\(post.title)! \n")
                    
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp16_Previews: PreviewProvider {
    
//    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    static let dataService = MockDataService(data: nil)
    
    static var previews: some View {
        DependencyInjectionBootcamp16(dataService: dataService)
    }
}
