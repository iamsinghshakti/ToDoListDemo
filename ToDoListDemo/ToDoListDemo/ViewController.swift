//
//  ViewController.swift
//  ToDoListDemo
//
//  Created by Shakti Singh on 26/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var toDoListModel:ToDoListViewModel = ToDoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dta = self.toDoListModel.retriveDataLocally(){
            self.toDoListModel.list = dta
        }else{
            toDoListModel.addToDoList(listData: ToDoListModel(name: "Add"))
        }
        tableView.register(UINib(nibName: FileName.toDoListTableCell.rawValue, bundle: nil), forCellReuseIdentifier: FileName.toDoListTableCell.rawValue)
        
        // Do any additional setup after loading the view.
    }
    
    func showAddPopUp(){
        let alert = UIAlertController(title: "Add New To Do List", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        let action2 = UIAlertAction(title: "Add", style: .default) { action in
            if let str = alert.textFields?.first?.text{
                self.toDoListModel.addToDoList(listData: ToDoListModel(name: str,time: Date(),status: Status.pending.rawValue))
                self.tableView.reloadData()

                
            }
           
        }
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }

    func showPupUpForDeleteRow(dta:ToDoListModel){
        let alert = UIAlertController(title: "Alert", message: "You want to delete this to do list", preferredStyle: .alert)
        let action = UIAlertAction(title: "No", style: .cancel)
        let action1 = UIAlertAction(title: "Yes", style: .default) { uv in
            self.toDoListModel.removeToDoList(removeData: dta)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addAction(action1)
        self.present(alert, animated: true)
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileName.toDoListTableCell.rawValue, for: indexPath) as! ToDoListTableCell
        let index = (toDoListModel.list.count-1) - indexPath.row
        cell.setDetail(data: toDoListModel.list[index],index: index)
        cell.deleteRow = { tag in
            
            let dta = self.toDoListModel.list[tag]
            if dta.name != "Add"{
                self.showPupUpForDeleteRow(dta: dta)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (toDoListModel.list.count - 1){
            self.showAddPopUp()
        }else{
            let index = (toDoListModel.list.count-1) - indexPath.row

            let dta = toDoListModel.list[index]
            if dta.status == Status.pending.rawValue{
                self.toDoListModel.removeToDoList(removeData: dta)
                self.toDoListModel.addToDoList(listData: ToDoListModel(name: dta.name,time: dta.time,status: Status.completed.rawValue))
            }else{
                self.toDoListModel.removeToDoList(removeData: dta)
                self.toDoListModel.addToDoList(listData: ToDoListModel(name: dta.name,time: dta.time,status: Status.pending.rawValue))
            }
            self.tableView.reloadData()

            
        }
    }
   
    
}

