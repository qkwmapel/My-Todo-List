//
//  TodoData.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/26/24.
//

import Foundation

struct Todo {
    
    var Title : String
    var isCompleted : Bool = false
    let dateformatter = DateFormatter()
    var writeDay : String
    init(_ Title : String) {
        self.Title = Title
        self.dateformatter.dateFormat = "yy년 MM월 dd일"
        self.writeDay = dateformatter.string(from: Date())
    }
}
