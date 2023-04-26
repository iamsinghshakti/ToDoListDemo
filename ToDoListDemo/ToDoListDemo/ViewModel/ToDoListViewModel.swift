//
//  ToDoListViewModel.swift
//  ToDoListDemo
//
//  Created by Shakti Singh on 26/04/23.
//

import Foundation

class ToDoListViewModel{
    
    var list:[ToDoListModel] = []
    
    func addToDoList(listData:ToDoListModel){
        self.list.append(listData)
        saveListLocally()
    }
    
    func removeToDoList(removeData:ToDoListModel){
        let dta = self.list.filter({$0.time != removeData.time})
        self.list.removeAll()
        self.list.append(contentsOf: dta)
        saveListLocally()
    }
    
    func saveListLocally(){
        let dta = try? JSONEncoder().encode(self.list)
        UserDefaults.standard.set(dta, forKey: KeyName.toDoList.rawValue)
        UserDefaults.standard.synchronize()
        
    }
    
    func retriveDataLocally()->[ToDoListModel]?{
        if let dta = UserDefaults.standard.value(forKey: KeyName.toDoList.rawValue) as? Data{
            do{
                let dta = try JSONDecoder().decode([ToDoListModel].self, from: dta)
                return dta
            }catch{
                print(error)
            }
        }
        return nil
    }
    
}
