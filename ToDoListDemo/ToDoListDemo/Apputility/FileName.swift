//
//  FileName.swift
//  ToDoListDemo
//
//  Created by Shakti Singh on 26/04/23.
//

import Foundation

enum FileName:String{
    case toDoListTableCell = "ToDoListTableCell"
}


struct CommonMethod{
    static  func getTime(time:Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let str = formatter.string(from: time)
        return str
    }
}

enum Status:String{
    case pending = "Pending"
    case completed = "Completed"
}

enum KeyName:String{
    case toDoList = "toDoList"
}
