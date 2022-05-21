//
//  ViewController.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: UserListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "SwiftAsyncExample"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel = UserListViewModel(delegate: self)
        self.viewModel.fetchUsers()
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell
        cell?.userIdLabel.text = self.viewModel.users(row: indexPath.row).userId.description
        cell?.nameLabel.text = self.viewModel.users(row: indexPath.row).name
        cell?.commentLabel.text = self.viewModel.users(row: indexPath.row).commnet
        return cell!
    }
    
}

extension ViewController: UserListViewModelDelegate {
    
    func dataUpdated() {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
}
