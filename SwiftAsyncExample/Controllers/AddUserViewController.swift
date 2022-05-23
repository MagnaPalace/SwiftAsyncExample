//
//  AddUserViewController.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/23.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet var userNoTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "ユーザー追加"
        
        userNoTextField.delegate = self
        nameTextField.delegate = self
        commentTextField.delegate = self
        
        self.setNumberKeyboardDoneButton()
    }

    @IBAction func addUserButtonTapped(_ sender: Any) {
        guard userNoTextField.text?.count ?? 0 > 0, nameTextField.text?.count ?? 0 > 0, commentTextField.text?.count ?? 0 > 0 else {
            let alert = UIAlertController(title: "確認", message: "入力が完了していない箇所があります。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.addUserAction()
    }
    
    private func addUserAction() {
        // TODO: ユーザー保存
    }
    
    /// ナンバーキーボードに完了ボタン追加
    private func setNumberKeyboardDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.items = [spacer, doneButton]
        userNoTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        userNoTextField.resignFirstResponder()
    }
    
}

extension AddUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
