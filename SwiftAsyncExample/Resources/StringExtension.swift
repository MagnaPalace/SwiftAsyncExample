//
//  StringExtension.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/26.
//

import Foundation

extension String {
    
    /// 文章のローカライズ呼び出し
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
