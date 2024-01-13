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

struct OrderInfo: Codable {
    var name: String
    var beverage: String
    var sweetLevel: String
    var iceLevel: String
    var size: String
    var price: String
    var userID: UUID
    var picURL: String
}


struct RetrieveData: Codable {
    var records: [BeverageOrdered]
}



struct PostResponse: Codable{
    var records: [BeverageOrdered]
}

//GET得到的資料和post資料上去後會得到id與createTime去解碼
struct BeverageOrdered: Codable {
    let id: String
    let createdTime: String?
    var fields: OrderInfo
}


struct ReviseRecord: Codable {
    var records: [ReviseOrder]
}

struct ReviseOrder: Codable {
    var id: String
    var fields: OrderInfo
}

// 使用者初次訂購飲料之資訊
var userInfo = BeverageOrder(records: [Records(fields: OrderInfo(name: "", beverage: "", sweetLevel: "", iceLevel: "", size: "", price: "", userID: UUID(), picURL: ""))])

// 已送出到Airtable的訂單資訊
var userInfoOrdered = PostResponse(records: [])

// 已在Airtable的訂單，但使用者想要更改
var userRevise = PostResponse(records: [])



struct DeleteOrder:Codable {
    var records: [OrderID]
    
    struct OrderID:Codable {
        var id: String
        var deleted: Bool
    }
}


