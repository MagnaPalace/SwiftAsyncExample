//
//  AddUserViewController.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/23.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var commentTextField: UITextField!
    
    weak var delegate: AddUserViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "ユーザー追加"
        
        userIdTextField.delegate = self
        nameTextField.delegate = self
        commentTextField.delegate = self
        
        self.setNumberKeyboardDoneButton()
    }

    @IBAction func addUserButtonTapped(_ sender: Any) {
        guard userIdTextField.text?.count ?? 0 > 0, nameTextField.text?.count ?? 0 > 0, commentTextField.text?.count ?? 0 > 0 else {
            let alert = UIAlertController(title: "確認", message: "入力が完了していない箇所があります。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.addUserAction()
    }
    
    private func addUserAction() {
        let api = ApiManager()
        let url = URL(string: BASE_URL + API_URL + UserApi.store.rawValue)!
        
        let parameter = [
            User.Key.userId.rawValue: userIdTextField.text,
            User.Key.name.rawValue: nameTextField.text,
            User.Key.comment.rawValue: commentTextField.text,
        ]

        IndicatorView.shared.startIndicator()
        
        // 通常版リクエスト
//        api.request(param: parameter as [String : Any], url: url) { (success, result, error) in
//            guard success else {
//                IndicatorView.shared.stopIndicator()
//                let alert = UIAlertController(title: "エラー", message: "ユーザーの追加に失敗しました。", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                return
//            }
//            IndicatorView.shared.stopIndicator()
//            self.delegate.didEndSaveUserAction()
//            DispatchQueue.main.async{
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
        
        // Swift 5.5 Concurrency async/await
        Task {
            let result = try await api.requestAsync(param: parameter as [String : Any], url: url)
            guard result != nil else {
                IndicatorView.shared.stopIndicator()
                return
            }
            IndicatorView.shared.stopIndicator()
            self.delegate?.didEndSaveUserAction()
            DispatchQueue.main.async{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /// ナンバーキーボードに完了ボタン追加
    private func setNumberKeyboardDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.items = [spacer, doneButton]
        userIdTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        userIdTextField.resignFirstResponder()
    }
    
}

extension AddUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

protocol AddUserViewControllerDelegate: AnyObject {
    func didEndSaveUserAction()
}
