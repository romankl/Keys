//
//  AllLocalKeys.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class AllLocalKeys {
    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func requestForAllFetching() -> NSFetchRequest {
        var request = NSFetchRequest(entityName: "Key")
        request.sortDescriptors = [NSSortDescriptor(key: "owner", ascending: true, selector: Selector("localizedCompare:"))]

        return request
    }
}
