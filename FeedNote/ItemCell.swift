//
//  ItemCell.swift
//  FeedNote
//
//  Created by Dona on 2018. 1. 27..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var trailing: NSLayoutConstraint!
}
