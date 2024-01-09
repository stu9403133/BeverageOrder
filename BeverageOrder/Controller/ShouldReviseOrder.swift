//
//  File.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/6.
//

import Foundation

func shouldReviseOrder() -> Bool {
    if  userInfo.records[0].fields.picURL != "" && userInfo.records[0].fields.size != "" && userInfo.records[0].fields.price != "" && userInfo.records[0].fields.beverage != "" {
        return true
    } else {
        return false
    }
}
