//
//  URLHelper.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/8.
//

import Foundation

class AirtableService {
    
    // 為了讓其他controller可以使用
    static let shared = AirtableService()
    
    enum Result <Success, Failure> where Failure:Error {
        case success(Data)
        
        case failure(NetworkError)
    }

    
    enum NetworkError: Error {
        case invaildData
        case invaildResponse
        
    }
    
    //建立訂單改-URLSession直接也寫在這
    func httpCRUD (urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)  {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data,
                  let content = String(data: data, encoding: .utf8) else {
                            completion(.failure(.invaildData))
                            print("create data failed: ")
                            return
                            }
            print(content)
            completion(.success(data))
        }.resume()
    }
    
    
    
    
    
}


// 設定http Method, Body等等
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
    if let retrieveUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/tbl3UqA2yVZYze2kx?sort%5B0%5D%5Bfield%5D=name&sort%5B0%5D%5Bdirection%5D=asc") {
        var urlRequest = URLRequest(url: retrieveUrl)
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        retrieveRequest = urlRequest
    }
    return retrieveRequest
}

// 用於修改訂單
func urlRequestOfReviseData(userInfoRevise: ReviseRecord) -> URLRequest {
    var reviseRequest: URLRequest!
    if let reviseUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201") {
    var urlRequest = URLRequest(url: reviseUrl)
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PATCH"
        let encoder = JSONEncoder()
        urlRequest.httpBody = try? encoder.encode(userInfoRevise)
        reviseRequest = urlRequest
    }
    return reviseRequest
}


//刪除訂單
func urlRequestOfDeleteData(recordID: String) -> URLRequest{
    var deleteRequest: URLRequest!
    if let deleteUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201?records[]=\(recordID)") {
        var urlRequest = URLRequest(url: deleteUrl)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        deleteRequest = urlRequest
    }
    return deleteRequest
}
