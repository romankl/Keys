//
//  LocalKeyDetailTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class LocalKeyDetailTableViewController: UITableViewController {

    var detailKey: Key?
    var completionBlock = {()->() in}

    @IBOutlet weak var key: ROKTextView!
    @IBOutlet weak var owner: UITextField!
    @IBOutlet weak var fingerprint: UITextField!
    @IBOutlet weak var expireDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if detailKey != nil {
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
            title = "Details"
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: Selector("save:"))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("cancel:"))
            title = "New Key"
        }
    }


    func save(button: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: completionBlock)
    }


    func cancel(button: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
