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
    
    init(
        userId: Int,
        name: String,
        comment: String
    ) {
        self.userId = userId
        self.name = name
        self.commnet = comment
    }
    
}
