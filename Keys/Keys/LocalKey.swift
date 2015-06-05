//
//  LocalKey.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import UIKit

class LocalKey: NSObject {
    var owner: String
    var fingerprint: String
    var content: String
    var expireDate: NSDate

    init(owner: String, fingerprint: String, content: String, expireDate: NSDate) {
        self.owner = owner
        self.fingerprint = fingerprint
        self.content = content
        self.expireDate = expireDate
    }


    func insert(context: NSManagedObjectContext) -> Bool {
        let key = NSEntityDescription.insertNewObjectForEntityForName("Key", inManagedObjectContext: context) as! Key
        key.fingerprint = fingerprint
        key.owner = owner
        key.content = content
        key.validTill = expireDate

        var error: NSError?
        if !context.save(&error) {
            println("Error while creation of new key: \(error)")
            return false
        }

        return true
    }


    func update(key: Key, context: NSManagedObjectContext) -> Bool {
        key.fingerprint = fingerprint
        key.owner = owner
        key.validTill = expireDate
        key.content = content

        var error: NSError?
        if !context.save(&error) {
            println("Error while updating existing key \(error)")
            return false
        }

        return true
    }
}
