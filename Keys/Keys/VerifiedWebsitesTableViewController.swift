//
//  VerifiedWebsitesTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 15.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class VerifiedWebsitesTableViewController: UITableViewController {

    var networks: [VerifiedNetworks]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("websiteCell", forIndexPath: indexPath) as! UITableViewCell
        let item = networks[indexPath.row]
        cell.detailTextLabel?.text = item.mapNetworkToHumanName()
        cell.textLabel?.text = item.username
        
        return cell
    }
}
