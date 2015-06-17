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
        static let segueIdentifier = "websiteDetails"
    }

    var user: RemoteUser!

    private var profileHeaderImage: ProfileHeaderImageView!
    private var image = UIImage()


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        user.completeFromEndpoint { (error, result) -> Void in
            if error != nil {
                //TODO: Define a way to handle errors
            } else {
                self.user.publicKey = result
            }
        }
    }

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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            if let networks = user.socialNetworks {
                count += networks.count
            }
        } else {
            count = 1
        }


        return count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        if indexPath.section == 0 {
            if let networks = user.socialNetworks {
                let socialNetwork = networks[indexPath.row]
                let socialUserName = socialNetwork.username

                let socialProfileUrl = networks[indexPath.row].mapNetworkToUrl()
                cell.textLabel?.text = socialProfileUrl + socialUserName
                cell.accessoryType = .None
            }
        } else {
            cell.textLabel?.text = "View verified websites"
            cell.accessoryType = .DisclosureIndicator
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
        newKey.originId = user.uid


        if let thumbnail = user.thumbnail {
            newKey.originPrimaryPicture = thumbnail
        }

        saveContext()
        switchButtonToExistingLocalKey()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        if indexPath.section == 1 {
            performSegueWithIdentifier(constants.segueIdentifier, sender: self)
        }
    }


    @IBOutlet weak var keyActionsButton: UIButton!
    private func switchButtonToExistingLocalKey() {
        self.keyActionsButton.setTitle("Remove key", forState: .Normal)
        self.keyActionsButton.backgroundColor = UIColor(red:255/255.0, green:69/255.0, blue:33/255.0, alpha:255/255.0)
        self.keyActionsButton.tintColor = .whiteColor()
    }


    private func switchToNonExistingKey() {
        self.keyActionsButton.setTitle("Save key", forState: .Normal)
        self.keyActionsButton.backgroundColor = UIColor(red:0/255.0, green:159/255.0, blue:242/255.0, alpha:255/255.0)
        self.keyActionsButton.tintColor = .whiteColor()
    }


    private func saveContext() {
        var error: NSError?
        if !context.save(&error) {
            println("Error: \(error)")
        }
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == constants.segueIdentifier {
            let detail = segue.destinationViewController as! VerifiedWebsitesTableViewController
            detail.networks = user.websites
        }
    }
}
