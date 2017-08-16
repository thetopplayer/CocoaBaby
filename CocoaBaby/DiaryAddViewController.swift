//
//  DiaryAddViewController.swift
//  CocoaBaby
//
//  Created by dadong on 2017. 8. 9..
//  Copyright © 2017년 Sohn. All rights reserved.
//

import UIKit

class DiaryAddViewController: DiaryBaseViewController {
    
    @IBOutlet var fatherCommentLabel: UILabel!
    @IBOutlet var addCommentButton: UIButton!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var addDiraryUIToolbar: UIToolbar!
    @IBOutlet var doneAddDiaryBtn: UIBarButtonItem!
    @IBOutlet var textViewBg: UIView!
    @IBOutlet var textView: UITextView!
    @IBOutlet weak var toolbarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyBoardHideBtn: UIBarButtonItem!
    var toolbarBottomConstraintInitialValue: CGFloat?
    
    var diary: Diary?
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var isUpdate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewBg.layer.cornerRadius = 4
        
        if let diary = self.diary {
            initDate(with: diary)
        }
        
        guard let user = UserStore.shared.user else {
            return
        }
        
        if user.gender == "male" {
            updateMaleSettings()
        } else {
            updateFemaleSettings()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let diary = diary {
            updateOriginalValue(diary: diary)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.toolbarBottomConstraintInitialValue = toolbarBottomConstraint.constant
        
        enableKeyboardHideOnTap()
    }
    
    // MARK: Methods
    
    func initDate(with diary: Diary) {
        self.weekLabel.text = "Week \(BabyStore.shared.getPregnantWeekBasedOnDiary(from: diary).week)"
        self.dateLabel.text = "\(CocoaDateFormatter.getWeekDay(from: diary)) \(months[diary.date.month - 1]) \(diary.date.day) \(diary.date.year)"
        
    }
    
    func updateOriginalValue(diary: Diary) {
        self.textView.text = diary.text
        
        if let comment = diary.comment {
            self.fatherCommentLabel.text = "Father's comment: \(comment)"
        }
        
    }
    
    private func enableKeyboardHideOnTap(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration) { () -> Void in
            self.toolbarBottomConstraint.constant = keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration) { () -> Void in
            self.toolbarBottomConstraint.constant = self.toolbarBottomConstraintInitialValue!
            self.view.layoutIfNeeded()
        }
    }
    
    func updateMaleSettings() {
        self.textView.isEditable = false
        self.addCommentButton.addTarget(self, action: #selector(showAddComment), for: .touchUpInside)
    }
    
    func updateFemaleSettings() {
        self.addCommentButton.isHidden = true
    }
    
    func showAddComment() {
        guard var diary = self.diary else {
            return
        }
        
        let alertController = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            if let comment = alertController.textFields?.first?.text {
                diary.comment = comment
            }
            
            DiaryStore.shared.updateComment(diary: diary, completion: { (result) in
                switch result {
                case let .success(diary):
                    self.diary = diary
                    self.updateOriginalValue(diary: diary)
                    return
                case .failure(_):
                    return
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
    
    @IBAction func tappedHideKeyboard(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        if let user = UserStore.shared.user {
            if user.gender == "male" {
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        
        saveDiary()
    }
    
    // MARK: Methods
    func saveDiary() {
        guard var diary = diary else {
            return
        }
        
        diary.text = textView.text
        
        if isUpdate {
            DiaryStore.shared.updateDiary(diary: diary, completion: { (result) in
                switch result {
                case .success(_):
                    self.dismiss(animated: true, completion: nil)
                    
                case let .failure(error):
                    print(error)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            DiaryStore.shared.saveDiary(diary: diary) { (result) in
                switch result {
                case .success(_):
                    self.dismiss(animated: true, completion: nil)
                    
                case let .failure(error):
                    print(error)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //    func updateDiary(diary: CKDiary) {
    //        CKDiaryStore.shared.updateDiary(diary: diary, text: self.textView.text)
    //
    //        self.dismiss(animated: true, completion: nil)
    //    }
}
