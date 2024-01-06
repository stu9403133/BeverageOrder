//
//  BeverageEncodableJSON.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/4.
//

import Foundation
// var name

struct BeverageOrder: Encodable {
    var records: [Records]
}

struct Records: Encodable {
    var fields: OrderInfo
}

struct OrderInfo: Encodable {
    var name: String
    var beverage: String
    var sweetLevel: String
    var iceLevel: String
    var size: String
    var price: String
    var userID: UUID
    var picURL: String
}

var userInfo = BeverageOrder(records: [Records(fields: OrderInfo(name: "", beverage: "", sweetLevel: "", iceLevel: "", size: "", price: "", userID: UUID(), picURL: ""))])
