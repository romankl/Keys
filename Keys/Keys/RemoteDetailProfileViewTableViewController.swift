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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
