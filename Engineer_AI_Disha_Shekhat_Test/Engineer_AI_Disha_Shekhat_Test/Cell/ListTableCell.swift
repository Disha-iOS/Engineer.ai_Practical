//
//  ListTableCell.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import UIKit

final class ListTableCell: UITableViewCell {

    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    @IBOutlet private weak var switchToggle: UISwitch!
    
    
    var hit: Hits? {
        didSet {
            if let hit = hit {
                self.labelTitle.text = hit.title ?? ""
                self.labelDate.text = Util.formattedDate(date: hit.createdDate ?? "")
                self.switchToggle.isOn = hit.isSelected
            }
        }
    }
    
}
