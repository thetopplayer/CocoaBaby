//
//  TipsDetailViewController.swift
//  CocoaBaby
//
//  Created by LEOFALCON on 2017. 8. 7..
//  Copyright © 2017년 Sohn. All rights reserved.
//

import UIKit

class TipsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    
    @IBOutlet var tableView: UITableView!
//    @IBOutlet var headTitle: UILabel!
    
    var week : Int!
    
//    @IBOutlet var weekTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "header")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "content")
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        if week == nil {
            week = 1
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.section == 0 ? "header" : "content"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        
        if indexPath.section == 0 {
            let weekLabel = UILabel(frame: CGRect(x: 30, y: 30, width: 200, height: 40))
            weekLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightThin)
            weekLabel.text = "Week \(self.week!)"
                
            cell?.contentView.addSubview(weekLabel)
        } else {
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let segmentedControl = UISegmentedControl(items: ["baby","mama","papa"])
            segmentedControl.tintColor = .blue
            
            return segmentedControl
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ?  80 : 1000
    }
    
    
    
    
    

}
