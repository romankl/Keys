//
//  LocalKeyTableViewCell.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class LocalKeyTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var fingerprint: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
