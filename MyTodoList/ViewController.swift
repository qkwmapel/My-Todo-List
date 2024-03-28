//
//  ViewController.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/19/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cellCount : [Todo] = []
    var TodoTable = UITableView()
    var sectionHeader = Set<String>()
    
    struct Todo {
        var Title : String
        var isCompleted : Bool = false
        var writeDay : String
        var dateFormatter = DateFormatter()
        init(Title : String) {
            self.Title = Title
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.writeDay = self.dateFormatter.string(from: Date())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableCreate()
        setUIButton()
        
    }
    
    // MARK: button
    func setUIButton() {
        let button = UIButton(type: .system)
        button.setTitle("추가하기", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.frame = CGRect(x: 294, y: 59, width: 83, height: 35)
        self.view.addSubview(button)
        
    }
    
    //버튼 누르면 alert실행
    @objc func buttonTapped() {
        let Title = "할 일 추가"
        let message = "오늘 할 일을 적어(안하면 안돼)"
        let alert = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "추가", style: .default) {(_) in
            let willDo = alert.textFields?[0].text
            if willDo?.isEmpty != true {
                let new = Todo(Title: willDo!)
                self.cellCount.append(new)
                
                self.TodoTable.performBatchUpdates({
                    if !self.sectionHeader.contains(new.writeDay){
                        self.sectionHeader.insert(new.writeDay)
                        self.TodoTable.insertSections(IndexSet(integer: self.sectionHeader.count - 1), with: .automatic)
                    }
                    self.TodoTable.insertRows(at: [IndexPath(row: self.cellCount.count - 1, section: self.sectionHeader.count - 1)], with: .automatic)})
            }else {
                let failAlert = UIAlertController(title: nil, message: "할일이 없으신가요?", preferredStyle: .alert)
                failAlert.addAction(cancel)
                self.present(failAlert, animated: true)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        // Index 0 Textfield
        alert.addTextField() {(tf) in
            tf.placeholder = "하아아아알 이이이이일"
        }
        
        self.present(alert, animated: true)
    }
    
    //MARK: tableView
    func tableCreate() {
        TodoTable.rowHeight = UITableView.automaticDimension
        TodoTable.frame = CGRect(x: 0, y: 99, width: 393, height: 719)
        TodoTable.delegate = self
        TodoTable.dataSource = self
        TodoTable.register(TodoCell.self, forCellReuseIdentifier: TodoCell.cellId)
        self.view.addSubview(TodoTable)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader.sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.cellId, for: indexPath) as! TodoCell
        cell.TodoLbl.text = cellCount[indexPath.row].Title
        cell.completeSwitch.isOn = cellCount[indexPath.row].isCompleted
        cell.completeSwitch.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { if editingStyle == .delete {
        cellCount.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    } // 해당 indexPath
    // MARK: switch
//    func setswitch() {
//        let mySwitch = UISwitch()
//        mySwitch.isOn = true
//        mySwitch.onTintColor = UIColor.green
//        mySwitch.thumbTintColor = UIColor.white
//        mySwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
//    }
//    @objc func switchValueChanged(_ sender: UISwitch) {
//        if sender.isOn {
//            
//        }else {
//            
//        }
//    }
}
