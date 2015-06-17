//
//  RemoteUser.swift
//  Keys
//
//  Created by Roman Klauke on 07.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation

struct RemoteUser {
    var username: String?
    var fullName: String?
    var bio: String?
    var fingerprint: String?
    var publicKey: String?
    var socialNetworks: Array<VerifiedNetworks>?
    var websites: Array<VerifiedNetworks>!
    var follows: Bool?
    var thumbnail: String?
    var uid: String?

    func completeFromEndpoint(callback: (error: NSError?, key: String?) -> Void) -> Void {
        RemoteEndpoint.fetch({ (operation, result) -> Void in
            let found = self.transform(result)
            callback(error:nil, key: found)
        }, failure: { (operation, failure) -> Void in
            callback(error: failure!, key: nil)
        }, endPointUrl: "user/lookup.json?usernames=" + username!, params: nil)
    }


    private func transform(result: AnyObject) -> String {
        let them = result["them"] as! NSArray

        for singleObject in them {
            let publicKeys = singleObject["public_keys"] as! NSDictionary
            let primaryKey = publicKeys["primary"] as! NSDictionary
            return primaryKey["bundle"] as! String
        }

        return ""
    }
}