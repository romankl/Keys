//
//  LocalKeyDetailTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class LocalKeyDetailTableViewController: UITableViewController, UITextFieldDelegate {

    private var context: NSManagedObjectContext {
        var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext!
    }

    struct constants {
        static let editSegue = "editKey"
    }

    var detailKey: Key?
    var completionBlock = {
        () -> () in }

    @IBOutlet weak var fingerprint: ROKTextView!
    @IBOutlet weak var key: ROKTextView!
    @IBOutlet weak var owner: UITextField!
    @IBOutlet weak var expireDate: UIDatePicker!

    var editingKey = false

    override func viewDidLoad() {
        super.viewDidLoad()


        if detailKey != nil && !editingKey {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: Selector("edit:"))
            title = "Details"
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: Selector("save:"))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("cancel:"))
            title = "New Key"
        }

        updateUi()
    }


    func save(button: UIBarButtonItem) {
        let repo = LocalKey(owner: owner.text, fingerprint: fingerprint.text, content: key.text, expireDate: expireDate.date)

        if editingKey {
            if repo.update(detailKey!, context: context) {
                presentingViewController?.dismissViewControllerAnimated(true, completion: completionBlock)
            }
        } else {
            if repo.insert(context) {
                presentingViewController?.dismissViewControllerAnimated(true, completion: completionBlock)
            }
        }
    }


    func cancel(button: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }


    func edit(button: UIBarButtonItem) {
        performSegueWithIdentifier(constants.editSegue, sender: self)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == constants.editSegue {
            let navController = segue.destinationViewController as! UINavigationController
            let editController = navController.viewControllers.first as! LocalKeyDetailTableViewController
            editController.detailKey = detailKey
            editController.editingKey = true
            editController.completionBlock = {
                self.context.refreshObject(self.detailKey!, mergeChanges: true)
                self.updateUi()
            }
        }
    }

    @IBOutlet weak var copyCell: UITableViewCell!
    @IBOutlet weak var deleteCell: UITableViewCell!

    private func switchBetweenDetailAndEdit(edit: Bool) {
        owner.userInteractionEnabled = edit
        fingerprint.userInteractionEnabled = edit
        key.userInteractionEnabled = edit
        expireDate.userInteractionEnabled = edit

        if edit {
            copyCell.hidden = true
            deleteCell.hidden = true
        }
    }

    @IBOutlet weak var copyToClipboard: UIButton!
    @IBOutlet weak var delteKey: UIButton!


    @IBAction func copyToClipboardAction(sender: UIButton) {
        UIPasteboard.generalPasteboard().string = detailKey?.content
    }


    @IBAction func deleteKey(sender: UIButton) {
        context.deleteObject(detailKey!)
        var error: NSError?
        context.save(&error)
        navigationController?.popToRootViewControllerAnimated(true)
    }



    private func updateUi() {
        switchBetweenDetailAndEdit(editingKey || detailKey == nil)

        owner.text = detailKey?.owner
        fingerprint.text = detailKey?.fingerprint
        key.text = detailKey?.content

        if let validDate = detailKey?.validTill {
            expireDate.setDate(validDate, animated: true)
        }
    }
}
