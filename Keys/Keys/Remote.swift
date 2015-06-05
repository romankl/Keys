//
//  Remote.swift
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation
import CoreData

@objc
class Remote: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var username: String
    @NSManaged var fullname: String
    @NSManaged var bio: String
    @NSManaged var fingerprint: String
    @NSManaged var publickey: String
    @NSManaged var cachedAt: NSDate

}
