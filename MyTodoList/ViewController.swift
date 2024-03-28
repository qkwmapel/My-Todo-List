//
//  ViewController.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/19/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var cellCount : [Todo] = []
    var SectionHeader = Set<String>()
    
    @IBOutlet var TodoTable: UITableView!
    // 버튼 클릭시 alert생성
    @IBAction func addbutton(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "할 일을 적으세요", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        let ok = UIAlertAction(title: "ok", style: .default) { (_) in
            let willDo = alert.textFields?[0].text
            if willDo?.isEmpty != true {
                //Ok버튼을 클릭했는데 값이 있을때 실행
                let new = Todo(willDo!)
                self.cellCount.append(new)
                
                self.TodoTable.performBatchUpdates({
                    if !self.SectionHeader.contains(new.writeDay) {
                        self.SectionHeader.insert(new.writeDay)
                        self.TodoTable.insertSections(IndexSet(integer: self.SectionHeader.count - 1), with: .automatic)
                        
                    }
                    self.TodoTable.insertRows(at: [IndexPath(row: self.cellCount.count - 1, section: self.SectionHeader.count - 1)], with: .automatic)
                })
            }else {
                //값이 없을때 실행
                let failAlert = UIAlertController(title: "할일도 없어?", message: nil, preferredStyle: .alert)
                failAlert.addAction(cancel)
                self.present(failAlert, animated: true)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        //alert에 텍스트 필드 추가
        alert.addTextField(){(tf) in
            tf.placeholder = "ex) 골프치기"
        }
        
        self.present(alert, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TodoTable.delegate = self
        TodoTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    // MARK: tableViewSection
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionHeader.sorted()[section]
    }
    // MARK: tableViewRow
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
            cell.TodoTitle.text = cellCount[indexPath.row].Title
            cell.TodoSwitch.isOn = cellCount[indexPath.row].isCompleted
            return cell
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cellCount.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

