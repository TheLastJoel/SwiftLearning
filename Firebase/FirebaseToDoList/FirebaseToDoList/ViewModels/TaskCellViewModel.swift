//
//  TaskCellViewModel.swift
//  FirebaseToDoList
//
//  Created by Joel Bearn on 27/09/2022.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable{

    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task){
        self.task = task
        
        // !!!: So the $task is essentially cutting out the middle man of having a button binding things together. It does the instant binding right here. I think
        $task.map { task in
            task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
        
        $task.compactMap { task in
            task.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
    
}
