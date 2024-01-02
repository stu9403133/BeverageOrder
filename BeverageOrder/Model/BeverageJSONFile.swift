//
//  beverage.swift
//  beverageOrder
//
//  Created by stu on 2023/12/29.
//

import Foundation


let categoryPic = ["季節限定", "單品茶_Classic", "調茶_Mix_tea", "雲蓋_Sweet_Cream_Cold_Foam", "歐蕾_Milk_tea"]

struct Beverage: Codable {
    var category: String
    var drinks: [Drink]?
    var toppings: [Topping]?
}

struct Drink: Codable {
    var name: String?
    var info: Infos?
    var picUrl: String?
}

struct Infos: Codable {
    var M: String?
    var L: String?
    var description: String?
    var hotAvailable: Bool?
}

struct Topping: Codable {
    var name: String?
    var price: String?
}
