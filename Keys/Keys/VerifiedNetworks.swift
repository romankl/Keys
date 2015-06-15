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


    func mapNetworkToHumanName() -> String {
        var result = "Verified through "
        switch type {
        case .Dns:
            result += "DNS"
            break
        case .Https:
            result += "HTTPS"
        default:
            result = ""
        }

        return result
    }


    func mapNetworkToUrl() -> String {
        var result: String 
        switch type {
        case .Reddit:
            result = "https://reddit.com/u/"
            break
        case .Twitter:
            result = "https://twitter.com/"
            break
        case .Github:
            result = "https://github.com/"
            break
        case .HackerNews:
            result = "https://news.ycombinator.com/user?id="
            break
        case .Coinbase:
            result = "https://www.coinbase.com/"
            break
        default:
            return ""
        }

        return result
    }
}