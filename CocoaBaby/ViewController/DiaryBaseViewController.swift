//
//  DiaryBaseViewController.swift
//  CocoaBaby
//
//  Created by dadong on 2017. 8. 9..
//  Copyright © 2017년 Sohn. All rights reserved.
//

import UIKit

class DiaryBaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(colorWithHexValue: 0xF5CECA)
        
    }
    
}
