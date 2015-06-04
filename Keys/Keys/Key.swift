//
//  Key.swift
//  Keys
//
//  Created by Roman Klauke on 04.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation
import CoreData

@objc
class Key: NSManagedObject {

    @NSManaged var owner: String
    @NSManaged var fingerprint: String
    @NSManaged var content: String
    @NSManaged var originId: String
    @NSManaged var originUsername: String
    @NSManaged var originPrimaryPicture: String

}
