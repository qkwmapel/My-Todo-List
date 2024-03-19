//
//  ViewController.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/19/24.
//

import UIKit

class ViewController: UIViewController {
    struct Todo {
        var id : Int
        var Title : String
        var isCompleted : Bool = false
        
        init(id: Int, Title : String) {
            self.id = id
            self.Title = Title
        }
        
        mutating func Complete() {
            isCompleted = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

