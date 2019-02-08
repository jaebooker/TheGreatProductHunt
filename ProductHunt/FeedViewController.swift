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
    var mockData: [Post] = {
        var meTube = Post(id:0,name:"ItsHere",tagline:"Free stuff",votesCount:25,commentsCount:4)
        var tube2 = Post(id:1,name:"tube2",tagline:"2 You 2 Tube",votesCount:666,commentsCount:42)
        var iToons = Post(id:2,name:"tube3",tagline:"Tube 3: The Final Chapter",votesCount:555,commentsCount:500)
        return [meTube,tube2,iToons]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }


}
extension FeedViewController: UITableViewDataSource {
    /// Determines how many cells will be shown on the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    /// Creates and configures each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        let post = mockData[indexPath.row]
        cell.post = post
        
        return cell
    }
}
extension FeedViewController: UITableViewDelegate {
    // Code to handle cell events goes here...
}

