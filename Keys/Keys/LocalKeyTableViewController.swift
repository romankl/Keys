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
        static let searchDetailSegue = "searchKeySegue"
        static let newSegue = "newKey"
    }


    private var filteredData = [Key]()


    private var context: NSManagedObjectContext {
        var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()

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


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController!.searchResultsTableView {
            return filteredData.count
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.reuseIdentifier, forIndexPath: indexPath) as! LocalKeyTableViewCell
        cell.accessoryType = .None
        var item: Key
        if tableView == searchDisplayController?.searchResultsTableView {
            item = filteredData[indexPath.row] as Key
            cell.textLabel?.text = item.owner

            cell.accessoryType = .DisclosureIndicator
        } else {
            item = fetchedResultsController.objectAtIndexPath(indexPath) as! Key
        }

        cell.title?.text = item.owner
        cell.fingerprint?.text = item.fingerprint

        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == constants.detailSegue {
            let destination = segue.destinationViewController as! LocalKeyDetailTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            let item = fetchedResultsController.objectAtIndexPath(indexPath!) as! Key
            destination.detailKey = item
        } else if segue.identifier == constants.searchDetailSegue {
            let destination = segue.destinationViewController as! LocalKeyDetailTableViewController
            destination.detailKey = sender as? Key
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


    private func searchDb(query: String) {
        let wildcard = "*" + query + "*"
        let fetchRequest = NSFetchRequest(entityName: "Key")

        let namePredicate = NSPredicate(format: "owner LIKE %@", wildcard)
        let originUsername = NSPredicate(format: "originUsername LIKE %@", wildcard)
        let fingerprint = NSPredicate(format: "fingerprint LIKE %@", wildcard)
        let content = NSPredicate(format: "content LIKE %@", wildcard)

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "owner", ascending: true, selector: Selector("localizedCompare:"))]


        fetchRequest.predicate = NSCompoundPredicate .orPredicateWithSubpredicates([content, fingerprint, namePredicate, originUsername])

        var error: NSError?
        let result = context.executeFetchRequest(fetchRequest, error: &error)

        filteredData = result as! Array<Key>
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == searchDisplayController?.searchResultsTableView {
            let item = filteredData[indexPath.row]
            performSegueWithIdentifier(constants.searchDetailSegue, sender: item)
        }
    }


    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        searchDb(searchString)
        return true
    }


    func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController) {
        controller.searchResultsTableView.registerClass(LocalKeyTableViewCell.classForCoder(), forCellReuseIdentifier: constants.reuseIdentifier)
    }


    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        searchDb(searchDisplayController!.searchBar.text)
        return true
    }
}
