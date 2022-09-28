//
//  Task.swift
//  FirebaseToDoList
//
//  Created by Joel Bearn on 08/09/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable{
    
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    
}

#if DEBUG
let testDataTasks = [
    Task(title: "Implement the UI", completed: true),
    Task(title: "Shine your shoes", completed: false),
    Task(title: "????", completed: false),
    Task(title: "Eat a fancy dancy snack", completed: true)
]
#endif
