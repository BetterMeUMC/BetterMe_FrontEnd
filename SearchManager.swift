//
//  SearchManager.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/16.
//

import Foundation

class SearchManager {
    let token = UserDefaults.standard.string(forKey: "token")
    let userIdx = UserDefaults.standard.string(forKey: "userIdx")
    
    
    func getSearchName(searchNameText: String) {
        var components = URLComponents(string: "http://54.180.13.219:3000/app//follow/searchN/\(userIdx ?? "")")!
        guard let url = components.url else {return}
        components.queryItems = [URLQueryItem(name: "nickName", value: searchNameText)]
        let header = ["x-access-token": token ?? ""]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                 print("Error: \(error)")
             } else if let data = data {
                 do {
                     let decoder = JSONDecoder()
                     let searchNameResponse = try decoder.decode(SearchNameResponse.self, from: data)
                     for searchName in searchNameResponse.result {
                          print("Name: \(searchName.nickName)")
                      }
                 } catch let error {
                     print("Error decoding response: \(error)")
                 }
             }
        }
        task.resume()
    }
    func getSearchEmail(searchEmailText : String) {
        var components = URLComponents(string: "http://54.180.13.219:3000/app//follow/searchN/\(userIdx ?? "")")!
        guard let url = components.url else { return }
        components.queryItems = [URLQueryItem(name: "nickName", value: searchEmailText)]
        let header = ["x-access-token": token ?? ""]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                 print("Error: \(error)")
             } else if let data = data {
                 do {
                     let decoder = JSONDecoder()
                     let searchNameResponse = try decoder.decode(SearchEmailResponse.self, from: data)
                     for searchName in searchNameResponse.result {
                          print("Name: \(searchName.nickName)")
                      }
                 } catch let error {
                     print("Error decoding response: \(error)")
                 }
             }
        }
        task.resume()
    }
}
