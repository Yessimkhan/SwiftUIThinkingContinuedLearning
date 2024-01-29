//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 28.01.2024.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Succesfully saved")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusiness()
        getDepartments()
        getEmployees()
    }
    
    // MARK: - Create
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
//        add exiting department to the new business
//        newBusiness.departments = [departments[0], departments[1]]
         
//        add exiting employees to the new business
//        newBusiness.employees = [employees[1]]
        
//        add new business to exiting department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
//        add new business to exiting emlpoyee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2], businesses[3], businesses[4]]
        
//        newDepartment.employees = [employees[1]] astyndagysymen birdei
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Aza"
        newEmployee.dateJoined = Date()
        newEmployee.age = 20
        
        newEmployee.business = businesses[5]
        newEmployee.department = departments[6]
        save()
    }
    
    // MARK: - Reade
    
    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Delivex")
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch business entity \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch department entity \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch employee entity \(error.localizedDescription)")
        }
    }
    
    // get employees with filter
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch employee entity \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update
    
    func updateBusiness() {
        let exitingBusiness = businesses[5]
        exitingBusiness.addToDepartments(departments[6])
        save()
    }
    
    // MARK: - Delete
    
    func deleteDepartment() {
        let department = departments[2]
        manager.context.delete(department)
        save()
    }

    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
            self.getEmployees()
        }
        
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.deleteDepartment()
//                        vm.getEmployees(forBusiness: vm.businesses[0])
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.businesses) {business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.departments) {department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.employees) {employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationship")
        }
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Text("Name \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Emloyees:")
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5).cornerRadius(10))
        .shadow(radius: 10)
    }
}


struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Text("Name \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5).cornerRadius(10))
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Text("Name \(entity.name ?? "")")
                .bold()
            Text("Age \(entity.age)")
            Text("Data joined \(entity.dateJoined ?? Date())")
            
            
            Text("Business:")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5).cornerRadius(10))
        .shadow(radius: 10)
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}
