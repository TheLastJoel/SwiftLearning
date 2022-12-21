//
//  CoreDataRelationshipsBootcamp16.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 20/12/2022.
//

import SwiftUI
import CoreData



class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            print("Saved Successfully")
            try context.save()
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject{
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
    }
    
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
//        newBusiness.departments = [departments[0],departments[1]]
//
//        newBusiness.employees = [employees[1]]
        save()
    }
    
    func updateBusiness(){
        
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
        
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Engineering"
        newDepartment.buisnesses = [businesses[0],businesses[1],businesses[2]]
        
//        newDepartment.employees = [employees[1]]
        
        newDepartment.addToEmployees(employees[0])
        
        save()
    }
    
    func addEmployee(){
        
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 99
        newEmployee.dateJoined = Date()
        newEmployee.name = "John"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        save()
        
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.getDepartments()
            self.getBusinesses()
            self.getEmployees()
            self.manager.save()

        }
    }
    
}

struct CoreDataRelationshipsBootcamp16: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20){
                    HStack{
                        Button {
                            vm.updateBusiness()
                        } label: {
                            Text("Business")
                                .foregroundColor(.white)
                                .frame(height:55)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.cornerRadius(20))
                        }
                        Button {
                            vm.addDepartment()
                        } label: {
                            Text("Department")
                                .foregroundColor(.white)
                                .frame(height:55)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.cornerRadius(20))
                        }
                        Button {
                            vm.addEmployee()
                        } label: {
                            Text("Employee")
                                .foregroundColor(.white)
                                .frame(height:55)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.cornerRadius(20))
                        }
                    }
                    
                    ScrollView(.horizontal,showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.businesses){ business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    ScrollView(.horizontal,showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.departments){ department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    ScrollView(.horizontal,showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.employees){ employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }

                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipsBootcamp16_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp16()
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let businesses = entity.buisnesses?.allObjects as? [BusinessEntity]{
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date())")
            
            
            Text("Business:")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            Text(entity.department?.name ?? "")
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.pink.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
