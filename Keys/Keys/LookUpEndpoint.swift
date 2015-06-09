//
//  DiscoverEndpoint.swift
//  Keys
//
//  Created by Roman Klauke on 06.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation


struct LookUpEndpoint: EndpointProtocol {

    /// Fetches the discover endpoint 
    func fetch(callback: ((result:Array<RemoteUser>?, error:NSError?) -> Void), params: NSDictionary) {
        RemoteEndpoint.fetch({
            (operation, fetchResult) -> Void in
            var transformed = self.transform(fetchResult as! NSDictionary)
            callback(result: transformed, error: nil) // TODO Change protocol definition
        }, failure: {
            (operation, failure) -> Void in
            callback(result: nil, error: failure)
        }, endPointUrl: "user/autocomplete.json", params: params)
    }

    /// Transforms the fetched JSON response to Swift Objects
    ///
    /// :param: `input` untransformed JSON API endpoint response
    /// :returns: an Array with transformed Swift Objects
    private func transform(input: NSDictionary) -> Array<RemoteUser> {
        var users = [RemoteUser]()

        let completions = input["completions"] as! NSArray
        for element in completions {
            let components = element["components"] as! NSDictionary
            var user = RemoteUser()
            var services = [VerifiedNetworks]()

            if let username = components["username"] as? NSDictionary {
                user.username = username["val"] as? String
            }

            if let fullName = components["full_name"] as? NSDictionary {
                user.fullName = fullName["val"] as? String
            }

            if let twitter = components["twitter"] as? NSDictionary {
                let service = VerifiedNetworks(type: .Twitter, username: twitter["val"] as! String)
                services.append(service)
            }

            if let github = components["github"] as? NSDictionary {
                let service = VerifiedNetworks(type: .Github, username: github["val"] as! String)
                services.append(service)
            }

            if let reddit = components["reddit"] as? NSDictionary {
                let service = VerifiedNetworks(type: .Reddit, username: reddit["val"] as! String)
                services.append(service)
            }

            if let coinbase = components["coinbase"] as? NSDictionary {
                let service = VerifiedNetworks(type: .Coinbase, username: coinbase["val"] as! String)
                services.append(service)
            }

            if let hackernews = components["hackernews"] as? NSDictionary {
                let service = VerifiedNetworks(type: .HackerNews, username: hackernews["val"] as! String)
                services.append(service)
            }

            if let websites = components["websites"] as? NSArray {
                for website in websites {

                    let webProtocol = website["protocol"] as! String
                    var type: VerifiedNetworks.NetworkType = .Dns
                    if webProtocol == "dns" {
                        type = VerifiedNetworks.NetworkType.Dns
                    } else if webProtocol == "https:" {
                        type = VerifiedNetworks.NetworkType.Https
                    }
                    let service = VerifiedNetworks(type: type, username: website["val"] as! String)
                    services.append(service)
                }
            }
            user.verified = services
            user.follows = components["is_followee"]?.boolValue

            if let thumbnail = element["thumbnail"] as? String {
                user.thumbnail = thumbnail
            }

            users.append(user)
        }

        return users
    }
}