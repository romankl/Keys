//
//  RemoteKeyCell.swift
//  Keys
//
//  Created by Roman Klauke on 09.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation

class RemoteKeyCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        thumbnail.layer.cornerRadius = thumbnail.frame.size.width / 2
        thumbnail.layer.masksToBounds = true
    }
}
