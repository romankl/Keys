//
//  ProfileHeaderImageView.swift
//  Keys
//
//  Created by Roman Klauke on 11.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class ProfileHeaderImageView: UIView {

    @IBOutlet weak var username: UILabel!
    var thumbnailUrl: String! {
        didSet {
            let url = NSURL(string: thumbnailUrl)

            backgroundImage.setImageWithURL(url, placeholderImage: nil)
            profileImage.setImageWithURL(url, placeholderImage: nil)
        }
    }

    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var fullname: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)

        let bundle = NSBundle.mainBundle()
        let nibs = bundle.loadNibNamed("ProfileHeaderImageView",
                                       owner: self,
                                       options: nil)
        let subView = nibs.first as! UIView


        addSubview(subView)
        subView.frame = frame
        subView.setNeedsUpdateConstraints()

        // Blur the background image
        let blur = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: blur)
        visualEffectView.frame = frame
        backgroundImage.addSubview(visualEffectView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
