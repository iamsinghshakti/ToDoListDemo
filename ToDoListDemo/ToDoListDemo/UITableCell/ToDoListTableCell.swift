//
//  ToDoListTableCell.swift
//  ToDoListDemo
//
//  Created by Shakti Singh on 26/04/23.
//

import UIKit

class ToDoListTableCell: UITableViewCell {

    @IBOutlet weak var crossLineLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var toStatusLbl: UILabel!
    @IBOutlet weak var toDoLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    var deleteRow:((Int)->(Void))?
    var tagIndex:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetail(data:ToDoListModel,index:Int){
        tagIndex = index
        toStatusLbl.isHidden = true
        dateLbl.isHidden = true
        checkBtn.isHidden = true
        toDoLbl.textColor = UIColor.black
        crossLineLbl.isHidden = true
        if let dta = data.name{
            toDoLbl.text = dta
        }
        if let dta = data.status{
            toStatusLbl.isHidden = false
            toStatusLbl.text = dta
            checkBtn.isHidden = false
            if dta == Status.completed.rawValue{
                checkBtn.isSelected = true
                crossLineLbl.isHidden = false
            }else{
                checkBtn.isSelected = false
                toDoLbl.textColor = UIColor.red

            }
        }
        if let time = data.time{
            dateLbl.isHidden = false
            dateLbl.text = CommonMethod.getTime(time: time)
        }
        let rcognizer = UILongPressGestureRecognizer(target: self, action: #selector(recognizer))
        self.addGestureRecognizer(rcognizer)
    }
    
    @objc func recognizer(){
        if let dta = tagIndex{
            deleteRow?(dta)
        }
    }
}
