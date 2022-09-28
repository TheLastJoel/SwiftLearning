//
//  TaskListViewModel.swift
//  FirebaseToDoList
//
//  Created by Joel Bearn on 27/09/2022.
//

import Foundation
import Combine

class TaskListViewModel:ObservableObject{
    var taskRespository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        taskRespository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
        
    }
    
    func addTask(task: Task){
        let taskVM = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(taskVM)
    }
}
