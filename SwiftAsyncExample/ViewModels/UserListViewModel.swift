//
//  UserListViewModel.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/22.
//

import Foundation
import UIKit

class UserListViewModel {
    
    private var users: [User] = []
    weak var delegate: UserListViewModelDelegate?
    
    /// ユーザーの全取得
    func fetchUsers() {
        let api = ApiManager()
        let url = URL(string: BASE_URL + API_URL + UserApi.all.rawValue)!
        IndicatorView.shared.startIndicator()
        
        // 通常版リクエスト
//        api.request(param: nil, url: url) { (success, result, error) in
//            guard success, let json = (result as AnyObject)["users"] as? [User.Json], json.count > 0 else {
//                IndicatorView.shared.stopIndicator()
//                return
//            }
//            IndicatorView.shared.stopIndicator()
//            self.users = json.map { User.fromJson(user: $0) }
//            self.delegate.dataUpdated()
//        }
        
        // Swift 5.5 Concurrency async/await
        Task {
            do {
                let result = try await api.requestAsync(param: nil, url: url)
                guard let json = (result as AnyObject)["users"] as? [User.Json], json.count > 0 else {
                    IndicatorView.shared.stopIndicator()
                    return
                }
                IndicatorView.shared.stopIndicator()
                self.users = json.map { User.fromJson(user: $0) }
                self.delegate?.dataUpdated()
            } catch {
                IndicatorView.shared.stopIndicator()
                print(error.localizedDescription)
                self.delegate?.getUsersApiFailed()
            }
        }
        
    }
    
    func usersCount() -> Int {
        return self.users.count
    }
    
    func users(row: Int) -> User {
        return self.users[row]
    }
    
}

protocol UserListViewModelDelegate: AnyObject {
    func dataUpdated()
    func getUsersApiFailed()
}
