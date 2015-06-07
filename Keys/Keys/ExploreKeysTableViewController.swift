//
//  ExploreKeysTableViewController.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class ExploreKeysTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let endpoint = LookUpEndpoint()
        endpoint.fetch({ (result, error) -> Void in
            //
        }, params: ["q": "a"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
