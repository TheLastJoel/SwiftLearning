//
//  UnitTestingBootcampViewModel.swift
//  SwiftUIAdvancedLearning
//
//  Created by Joel Bearn on 04/10/2022.
//

import Foundation
import SwiftUI
import Combine


class UnitTestingBootcampViewModel: ObservableObject{
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    let dataService: NewDataServiceProtocol
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)){
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String){
        guard !item.isEmpty else{ return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String){
        if let x = dataArray.first(where: {$0 == item}){
            selectedItem = x
        }
        else{
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws{
        
        guard !item.isEmpty else{
            throw DataError.noData
        }
        if let _ = dataArray.first(where: {$0 == item}){
            print("Save Item Here")
        } else{
            throw DataError.itemNotFound
        }
        
        
    }

    enum DataError: LocalizedError{
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping(){
        dataService.downloadItemsWithEscaping { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    
    func downloadWithCombine(){
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)

    }
}