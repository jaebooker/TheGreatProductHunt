//
//  Comment.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/12/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import Foundation
struct Comment: Decodable {
    var id: Int
    var body: String
}
struct CommentApiResponse: Decodable {
    var comments: [Comment]
}
