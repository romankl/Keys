//
//  VerifiedNetworks.swift
//  Keys
//
//  Created by Roman Klauke on 07.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation


struct VerifiedNetworks {
    var type: NetworkType
    var username: String

    init(type: NetworkType, username: String) {
        self.type = type
        self.username = username
    }

    enum NetworkType {
        case Https
        case Dns
        case Github
        case Twitter
        case Reddit
        case Coinbase
        case HackerNews
    }
}