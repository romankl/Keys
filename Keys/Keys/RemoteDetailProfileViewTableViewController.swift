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

        profileHeaderImage = ProfileHeaderImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 270))
        profileHeaderImage.thumbnailUrl = user.thumbnail!
        profileHeaderImage.fullname.text = user.fullName
        profileHeaderImage.username.text = user.username

        tableView.tableHeaderView = profileHeaderImage

        checkIfUserExistsLocally()
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

        if let networks = user.socialNetworks {
            if indexPath.row == networks.count {
                cell.textLabel?.text = "View verified websites"
            } else {
                let socialNetwork = networks[indexPath.row]
                cell.textLabel?.text = socialNetwork.username
            }
        } else if let websites = user.websites {
            cell.textLabel?.text = "View verified websites"
        }

        return cell
    }


    private var context: NSManagedObjectContext! {
        var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext!
    }


    private var existsAlready: Bool = false
    private func checkIfUserExistsLocally() {
        let result = fetchExistingKeyFromLocalTable()

        existsAlready = result.count > 0
        existsAlready ? switchButtonToExistingLocalKey() : switchToNonExistingKey()
    }


    private func fetchExistingKeyFromLocalTable() -> Array<Key> {
        let fetchRequest = NSFetchRequest(entityName: "Key")
        fetchRequest.predicate = NSPredicate(format: "originUsername == %@", user.username!)

        var error: NSError?
        let result = context.executeFetchRequest(fetchRequest, error: &error) as! Array<Key>

        if error != nil {
            println("Error while fetching \(error)")
        }

        return result
    }

    
    @IBAction func keyActions(sender: UIButton) {
        if existsAlready {
            deleteExistingRemoteKey()
        } else {
            createNewLocalKeyFromRemoteUser()
        }
        existsAlready = !existsAlready
    }


    private func deleteExistingRemoteKey() {
        let result = fetchExistingKeyFromLocalTable()
        let key = result.first
        context.deleteObject(key!)

        saveContext()
        switchToNonExistingKey()
    }


    private func createNewLocalKeyFromRemoteUser() {
        let newKey = NSEntityDescription.insertNewObjectForEntityForName("Key", inManagedObjectContext: context) as! Key
        newKey.originUsername = user.username

        if let publicKey = user.publicKey {
            newKey.content = publicKey
        }

        if let fingerprint = user.fingerprint {
            newKey.fingerprint = fingerprint
        }

        newKey.owner = user.fullName

        if let thumbnail = user.thumbnail {
            newKey.originPrimaryPicture = thumbnail
        }

        saveContext()
        switchButtonToExistingLocalKey()
    }


    @IBOutlet weak var keyActionsButton: UIButton!
    private func switchButtonToExistingLocalKey() {
        keyActionsButton.setTitle("Remove key", forState: .Normal)
    }


    private func switchToNonExistingKey() {
        keyActionsButton.setTitle("Save key", forState: .Normal)
    }


    private func saveContext() {
        var error: NSError?
        if !context.save(&error) {
            println("Error: \(error)")
        }
    }
}
