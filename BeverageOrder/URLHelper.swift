//
//  URLHelper.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/8.
//

import Foundation

// 建立訂單
func urlRequestOfUploadData(userIfno: BeverageOrder) -> URLRequest {
    let uploadUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201")!
    var urlRequest = URLRequest(url: uploadUrl)
    urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let encoder = JSONEncoder()
    urlRequest.httpBody = try? encoder.encode(userInfo)
    print(urlRequest.httpBody!)
    return urlRequest
}

//檢索或取回訂單，用於呈現訂單資料
func urlRequestOfRetrieveData() -> URLRequest {
    var retrieveRequest: URLRequest!
    if let retrieveUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201") {
        var urlRequest = URLRequest(url: retrieveUrl)
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        retrieveRequest = urlRequest
    }
    return retrieveRequest
}

// 用於修改訂單
func urlRequestOfReviseData(userInfo: BeverageOrder) -> URLRequest {
    var reviseRequest: URLRequest!
    if let reviseUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201") {
    var urlRequest = URLRequest(url: reviseUrl)
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PATCH"
        
        let encoder = JSONEncoder()
        urlRequest.httpBody = try? encoder.encode(userInfo)
        reviseRequest = urlRequest
    }
    return reviseRequest
}


//刪除訂單
func urlRequestOfDeleteData(userInfo: DeleteOrder) -> URLRequest{
    var deleteRequest: URLRequest!
    if let deleteUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201") {
        var urlRequest = URLRequest(url: deleteUrl)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        let encoder = JSONEncoder()
        urlRequest.httpBody = try? encoder.encode(userInfo)
        deleteRequest = urlRequest
    }
    return deleteRequest
}
