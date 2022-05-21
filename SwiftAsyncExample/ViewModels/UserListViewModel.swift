//
//  UserListViewModel.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/22.
//

import Foundation

class UserListViewModel {
    
    private var users: [User] = []
    let delegate: UserListViewModelDelegate
    
    init(delegate: UserListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchUsers() {
        let api = ApiManager()
        let url = URL(string: BASE_URL + API_URL + UserApi.all.rawValue)!
        api.request(param: nil, url: url) { (success, result, error) in
            guard success, let json = (result as AnyObject)["users"] as? [User.Json], json.count > 0 else {
                return
            }
            self.users = json.map { User.fromJson(user: $0) }
            print(self.users)
            self.delegate.dataUpdated()
        }
    }
    
    func usersCount() -> Int {
        return self.users.count
    }
    
    func users(row: Int) -> User {
        return self.users[row]
    }
    
}

protocol UserListViewModelDelegate {
    func dataUpdated()
}
