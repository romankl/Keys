//
//  RemoteEndpoint.swift
//  Keys
//
//  Created by Roman Klauke on 06.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

import Foundation


struct RemoteEndpoint {
    private static let baseUrl = "https://keybase.io/_/api/1.0/"

    /// Helper function to extract the HTTP- GET API calls
    ///
    /// :param: a closure that gets called if the API call was successful and returned a result
    /// :param: the failure closure just in case that an error occured
    /// :param: request parameters or nil if nothing is required
    static func fetch(success: ((operation:AFHTTPRequestOperation!, result:AnyObject!) -> Void), failure: ((operation:AFHTTPRequestOperation!, failure:NSError!) -> Void), endPointUrl: String, params: AnyObject?) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET(baseUrl + endPointUrl, parameters: params, success: success, failure: failure)
    }
}
