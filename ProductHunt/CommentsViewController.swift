//
//  CommentsViewController.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/12/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    var comments: [Comment] = [] {
        didSet {
            commentsTableView.reloadData()
        }
    }
    var postID: Int!
    var networkManager = NetworkManager()
    override func viewDidLoad() {
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        updateComments()
        super.viewDidLoad()
    }
    func updateComments(){
        networkManager.getComments(postID) { result in
            switch result {
            case let .success(comments):
                self.comments = comments
            case let .failure(error):
                print(error)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CommentsViewController: UITableViewDataSource {
    /// Determines how many cells will be shown on the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    /// Creates and configures each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsTableViewCell
        let comment = comments[indexPath.row]
        cell.commentsTextView.text = comment.body
        return cell
    }
}
extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
