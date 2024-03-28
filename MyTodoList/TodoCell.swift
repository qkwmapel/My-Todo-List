//
//  TodoCell.swift
//  MyTodoList
//
//  Created by 송정훈 on 3/26/24.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet var TodoSwitch: UISwitch!
    @IBOutlet var TodoTitle: UILabel!
    //스위치 클릭 이벤트
    @IBAction func TodoSwitchAction(_ sender: Any) {
        if self.TodoSwitch.isOn == true {
            let attributeString = NSMutableAttributedString(string: self.TodoTitle.text!)
            attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            TodoTitle.attributedText = attributeString
            
        }else {
            let attributeString = NSMutableAttributedString(string: TodoTitle.text!)
            TodoTitle.attributedText = attributeString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
