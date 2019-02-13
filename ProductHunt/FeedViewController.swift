//
//  ViewController.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/7/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
//    var mockData: [Post] = {
//        var meTube = Post(id:0,name:"ItsHere",tagline:"Free stuff",votesCount:25,commentsCount:4)
//        var tube2 = Post(id:1,name:"tube2",tagline:"2 You 2 Tube",votesCount:666,commentsCount:42)
//        var iToons = Post(id:2,name:"tube3",tagline:"Tube 3: The Final Chapter",votesCount:555,commentsCount:500)
//        return [meTube,tube2,iToons]
//    }()
    var posts: [Post] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    var networkManager = NetworkManager()
    override func viewDidLoad() {
        feedTableView.dataSource = self
        feedTableView.delegate = self
        updateFeed()
        super.viewDidLoad()
    }
    func updateFeed(){
        networkManager.getPosts() { result in
            self.posts = result
        }
    }
}
extension FeedViewController: UITableViewDataSource {
    /// Determines how many cells will be shown on the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    /// Creates and configures each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
}
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let commentsView = storyboard.instantiateViewController(withIdentifier: "commentsView") as? CommentsViewController else {
            return
        }
        commentsView.comments = ["WOOAHAHAH!", "Guitar solo", "Get down with the sickness!"]
        navigationController?.pushViewController(commentsView, animated: true)
    }
}

