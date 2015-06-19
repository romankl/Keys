//
//  ExploreKeysTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class ExploreKeysTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    private struct constants {
        static let cellIdentifier = "remoteKeyCell"
        static let segueIdentifier = "profileView"
    }

    private var items = [RemoteUser]()
    private var filteredData = [RemoteUser]()


    override func viewDidLoad() {
        super.viewDidLoad()

        let endpoint = LookUpEndpoint()
        endpoint.fetch({ (result, error) -> Void in
            if error != nil {
                println("Error while fetching \(error)")
                return
            }

            self.items = result! 
            self.tableView.reloadData() // TODO: Replace with visual correct reload
        }, params: ["q": "a"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController!.searchResultsTableView {
            return filteredData.count
        }

        return items.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let remoteUser = items[indexPath.row]
        if tableView == searchDisplayController?.searchResultsTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath) as! UITableViewCell

            let item = filteredData[indexPath.row] as RemoteUser
            cell.textLabel?.text = item.fullName

            cell.accessoryType = .DisclosureIndicator
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath) as! RemoteKeyCell

            cell.accessoryType = .None

            cell.thumbnail.setImageWithURL(NSURL(string: remoteUser.thumbnail!), placeholderImage: nil)
            cell.titleLabel.text = remoteUser.fullName
            cell.subTitleLabel.text = remoteUser.username
            return cell
        }
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    private func searchRestEndpoin(search: String, displayTextView: UITableView) -> Void {
        let endpoint = LookUpEndpoint()
        endpoint.fetch({ (result, error) -> Void in
            if error != nil {
                println("Error while fetching \(error)")
                return
            }

            self.filteredData = result!
            displayTextView.reloadData()
            }, params: ["q": search])
    }


    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        searchRestEndpoin(searchString, displayTextView: controller.searchResultsTableView)
        return true
    }


    func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController) {
        controller.searchResultsTableView.registerClass(LocalKeyTableViewCell.classForCoder(), forCellReuseIdentifier: constants.cellIdentifier)
    }


    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        searchRestEndpoin(searchDisplayController!.searchBar.text, displayTextView: controller.searchResultsTableView)
        return true
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == constants.segueIdentifier {
            let destination = segue.destinationViewController as! RemoteDetailProfileViewTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            destination.user = items[indexPath!.row] as RemoteUser
        }
    }
}
