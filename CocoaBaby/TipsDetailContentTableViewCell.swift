//
//  TipsDetailContentTableViewCell.swift
//  CocoaBaby
//
//  Created by LEOFALCON on 2017. 8. 14..
//  Copyright © 2017년 Sohn. All rights reserved.
//

import UIKit

class TipsDetailContentTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.textColor = UIColor.white
        self.content.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }

    func setContent(title: String, content: String)  {
        self.title.text = title
        self.content.text = content
    }
    
    
}
