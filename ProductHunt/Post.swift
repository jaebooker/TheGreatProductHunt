//
//  Post.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/8/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import Foundation
struct Post {
    let id: Int
    let name: String
    let tagline: String
    let votesCount: Int
    let commentsCount: Int
    let previewImageURL: URL
}
extension Post: Decodable {
    enum PostKeys: String, CodingKey {
        case id
        case name
        case tagline
        case votesCount = "votes_count"
        case commentsCount = "comments_count"
        case previewImageURL = "screenshot_url"
    }
    enum PreviewImageURLKeys: String, CodingKey {
        case imageURL = "850px"
    }
    init(from decoder: Decoder) throws {
        let postsContainer = try decoder.container(keyedBy: PostKeys.self)
        id = try postsContainer.decode(Int.self, forKey: .id)
        name = try postsContainer.decode(String.self, forKey: .name)
        tagline = try postsContainer.decode(String.self, forKey: .tagline)
        votesCount = try postsContainer.decode(Int.self, forKey: .votesCount)
        commentsCount = try postsContainer.decode(Int.self, forKey: .commentsCount)
        previewImageURL = try postsContainer.decode(URL.self, forKey: .previewImageURL)
    }
}
