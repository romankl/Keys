//
//  RemoteUser.swift
//  Keys
//
//  Created by Roman Klauke on 07.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation

class RemoteUser {
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
}