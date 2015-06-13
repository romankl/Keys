//
//  LocalKeyTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class LocalKeyTableViewController: BaseFetchController, UISearchBarDelegate, UISearchDisplayDelegate {

    struct constants {
        static let reuseIdentifier = "keyCell"
        static let detailSegue = "detailKey"
        static let newSegue = "newKey"
    }

    private var context: NSManagedObjectContext {
        var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let all = AllLocalKeys(context: context)
        let request = all.requestForAllFetching()

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.reuseIdentifier, forIndexPath: indexPath) as! LocalKeyTableViewCell
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Key
        cell.title.text = item.owner
        cell.fingerprint.text = item.fingerprint

        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == constants.detailSegue {
            let destination = segue.destinationViewController as! LocalKeyDetailTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            let item = fetchedResultsController.objectAtIndexPath(indexPath!) as! Key
            destination.detailKey = item
        }
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Key
            context.deleteObject(item)

            var error: NSError?
            if !context.save(&error) {
                println("Error while deletion of new Item: \(error)")
            }
        } else if editingStyle == .Insert {
        }
    }
}
