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
    //create url from API
    func getPosts(completion:@escaping([Post])->Void){
        let query = "posts/all?sort_by=votes_count&order=desc&search[featured]=true&per_page=20"
        let fullURL = URL(string: baseURL + query)!
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        //set header with API token
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)",
            "Host": "api.producthunt.com"
        ]
        let task = urlSession.dataTask(with: request) { data, response, error in
            //check errors
            if let error = error { print("There was an error, Sir. It reads \(error.localizedDescription)")
                return
            }
            //check for data
            guard let data = data else {
                return
            }
            //decode the data, if possible
            guard let result = try? JSONDecoder().decode(PostList.self, from: data) else {
                return
            }
            let posts = result.posts
            //return result
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        task.resume()
    }
}
