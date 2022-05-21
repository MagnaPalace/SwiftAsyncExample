//
//  ViewController.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "SwiftAsyncExample"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.start()
    }
    
    func start() {
        let api = ApiManager()
        let url = URL(string: BASE_URL + API_URL + UserApi.all.rawValue)!
        api.request(param: nil, url: url) { (success, result, error) in
            guard success else { return }
            let result = result as! NSDictionary
            print(result)
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell
        return cell!
    }
    
    
}
