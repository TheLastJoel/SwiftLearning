//
//  TaskRepository.swift
//  FirebaseToDoList
//
//  Created by Joel Bearn on 27/09/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject{
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init(){
        loadData()
    }
    
    func loadData(){
        db.collection("tasks").addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                querySnapshot.documents.compactMap { document in
                    
                    do{
                       try? document.data(as: Task.self)

                    }
                    catch{
                        print(error)
                    }
                }
            }
        }
    }
}
