//
//  RemoteDetailProfileViewTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 10.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class RemoteDetailProfileViewTableViewController: UITableViewController {
    private struct constants {
        static let cellIdentifier = "userData"
    }

    var user: RemoteUser!

    private var profileHeaderImage: ProfileHeaderImageView!
    private var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        profileHeaderImage = ProfileHeaderImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 220))
        profileHeaderImage.thumbnailUrl = user.thumbnail!
        profileHeaderImage.username.text = user.fullName

        tableView.tableHeaderView = profileHeaderImage
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let networks = user.socialNetworks {
            count += networks.count
        }

        if let sites = user.websites {
            count++
        }

        return count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        return cell
    }
}
