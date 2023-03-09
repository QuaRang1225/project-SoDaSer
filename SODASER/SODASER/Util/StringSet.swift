//
//  StringSet.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/07.
//

import Foundation

extension String {
    func substring(stringLength:Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: 0)
        let endIndex = index(self.startIndex, offsetBy: stringLength - 10)
        return String(self[startIndex ..< endIndex])
    }
}   //문자열 자르기

