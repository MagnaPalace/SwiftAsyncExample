//
//  ViewController.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private let viewModel =  UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "SwiftAsyncExample"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setNavigationBar()
        
        self.viewModel.delegate = self
        self.viewModel.fetchUsers()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "AddUserViewController", bundle: nil)
        let addUserViewController = storyboard.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        addUserViewController.delegate = self
        self.navigationController?.pushViewController(addUserViewController, animated: true)
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.viewModel.users(row: indexPath.row)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell
        cell?.initialize(model: .init(userNo: user.userId, name: user.name, comment: user.comment))
        return cell!
    }
    
}

extension ViewController: UserListViewModelDelegate {
        
    func dataUpdated() {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func getUsersApiFailed() {
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "errorAlertTitle".localized, message: "networkCommunicationFailedMessage".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "closeAlertButtonTitle".localized, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: AddUserViewControllerDelegate {
    
    func didEndSaveUserAction() {
        self.viewModel.fetchUsers()
    }
    
}
