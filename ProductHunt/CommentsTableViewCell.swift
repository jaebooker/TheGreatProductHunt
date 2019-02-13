//
//  CommentsTableViewCell.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/12/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var commentsTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
