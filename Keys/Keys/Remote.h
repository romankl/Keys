//
//  Remote.h
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Remote : NSManagedObject

@property(nonatomic, retain) NSString *id;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *fullname;
@property(nonatomic, retain) NSString *bio;
@property(nonatomic, retain) NSString *fingerprint;
@property(nonatomic, retain) NSString *publickey;
@property(nonatomic, retain) NSDate *cachedAt;

@end
