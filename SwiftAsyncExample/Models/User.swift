//
//  User.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import Foundation

class User {
    
    var userId: Int
    var name: String
    var commnet: String
    
    typealias Json = Dictionary<String, Any?>
    
    init(
        userId: Int,
        name: String,
        comment: String
    ) {
        self.userId = userId
        self.name = name
        self.commnet = comment
    }
    
    static func fromJson(user: Json) -> User {
        return .init(
            userId: user[Key.userId.rawValue] as? Int ?? 0,
            name: user[Key.name.rawValue] as? String ?? "",
            comment: user[Key.comment.rawValue] as? String ?? ""
        )
    }
    
}

extension User {
    enum Key: String, CaseIterable {
        case userId = "user_id"
        case name = "name"
        case comment = "comment"
    }
}
