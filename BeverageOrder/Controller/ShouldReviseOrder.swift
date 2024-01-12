//
//  File.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/6.
//

import Foundation

var isOrdered = false

func shouldReviseOrder() -> Bool {
    if isOrdered {
        return true
    } else {
        return false
    }
}
