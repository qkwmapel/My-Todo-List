//
//  TodoCell.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/20/24.
//

import UIKit


class TodoCell: UITableViewCell {
    static let cellId = "TodoCellId"
    let TodoLbl = UILabel()
    var completeSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been impl")
        }
    
    // MARK: layout
    func layout() {
        TodoLbl.font = UIFont.systemFont(ofSize: 15)
        TodoLbl.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        completeSwitch.isOn = true
        completeSwitch.onTintColor = UIColor.green
        completeSwitch.thumbTintColor = UIColor.white
        completeSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        self.addSubview(TodoLbl)
        self.contentView.addSubview(completeSwitch)
        
        TodoLbl.translatesAutoresizingMaskIntoConstraints = false
        completeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            TodoLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            TodoLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            completeSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            completeSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
//        label.text = ""

//        label.textAlignment = .left
//        label.numberOfLines = 1
//        label.lineBreakMode = .byTruncatingTail
//        label.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
//        
//        self.addSubview(label)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            let attributeString = NSMutableAttributedString(string: TodoLbl.text!)

              attributeString.addAttribute(.strikethroughStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: NSMakeRange(0, attributeString.length))

              TodoLbl.attributedText = attributeString
        }else {
            let attributeString = NSMutableAttributedString(string: TodoLbl.text!)
            TodoLbl.attributedText = attributeString
        }
    }

}
