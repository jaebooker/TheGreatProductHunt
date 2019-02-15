//
//  NetworkManager.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/11/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import Foundation
class NetworkManager {
    let urlSession = URLSession.shared
    var baseURL = "https://api.producthunt.com/v1/"
    var token = "dad9b80f1d851904c0fe6bda9138fb72774aafd365a877921d963a21f77892a3"
    enum EndPoints {
        case posts
        case comments(postId: Int)
        func getPath()->String{
            switch self {
            case .posts:
                return "posts/all"
            case .comments:
                return "comments"
            }
        }
        func getHTTPMethod()->String{
            return "GET"
        }
        func getHeaders(token: String)->[String:String]{
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)",
                "Host": "api.producthunt.com"]
        }
        func getParams()->[String:String]{
            switch self {
            case .posts:
                return [
                    "sort_by": "votes_count",
                    "order": "desc",
                    "per_page": "20",
                    "search[featured]": "true"
                ]
            case let .comments(postId):
                return [
                    "sort_by": "votes",
                    "order": "desc",
                    "per_page": "20",
                    "search[post_id]": "\(postId)"
                ]
            }
        }
        func paramsToString()->String{
            let parameterArray = getParams().map { key, value in
                return "\(key)=\(value)"
            }
            return parameterArray.joined(separator: "&")
        }
    }
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    private func makeRequest(for endPoint: EndPoints)->URLRequest{
        let stringParams = endPoint.paramsToString()
        let path = endPoint.getPath()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))!
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHTTPMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(token: token)
        return request
    }
    //create url from API
    func getPosts(_ completion:@escaping(Result<[Post]>)->Void){
//        let query = "posts/all?sort_by=votes_count&order=desc&search[featured]=true&per_page=20"
//        let fullURL = URL(string: baseURL + query)!
//        var request = URLRequest(url: fullURL)
//        request.httpMethod = "GET"
//        //set header with API token
//        request.allHTTPHeaderFields = [
//            "Accept": "application/json",
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(token)",
//            "Host": "api.producthunt.com"
//        ]
        let postsRequest = makeRequest(for: .posts)
        let task = urlSession.dataTask(with: postsRequest) { data, response, error in
            //check errors
            if let error = error {
                return completion(Result.failure(error))
            }
            //check for data
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            //decode the data, if possible
            guard let result = try? JSONDecoder().decode(PostList.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            let posts = result.posts
            //return result
            DispatchQueue.main.async {
                completion(Result.success(posts))
            }
        }
        task.resume()
    }
    func getComments(_ postId:Int,completion:@escaping(Result<[Comment]>)->Void){
        let commentsRequest = makeRequest(for: .comments(postId: postId))
        let task = urlSession.dataTask(with: commentsRequest) { data, response, error in
            //check errors
            if let error = error {
                return completion(Result.failure(error))
            }
            //check for data
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            //decode the data, if possible
            guard let result = try? JSONDecoder().decode(CommentApiResponse.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            //return result
            DispatchQueue.main.async {
                completion(Result.success(result.comments))
            }
        }
        task.resume()
    }
}
