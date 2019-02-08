//
//  PostTableViewCell.swift
//  ProductHunt
//
//  Created by Jaeson Booker on 2/8/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var thisLabel: UILabel!
    @IBOutlet weak var thisOtherLabelAsWell: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
