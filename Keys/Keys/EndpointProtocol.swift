//
//  EndpointProtocol.swift
//  Keys
//
//  Created by Roman Klauke on 06.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation

protocol EndpointProtocol {
    func fetch(callback: ((result:AnyObject?, error:NSError?) -> Void), params: NSDictionary)
}