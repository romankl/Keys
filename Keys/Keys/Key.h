//
//  Key.h
//  Keys
//
//  Created by Roman Klauke on 05.06.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Key : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * fingerprint;
@property (nonatomic, retain) NSString * originId;
@property (nonatomic, retain) NSString * originPrimaryPicture;
@property (nonatomic, retain) NSString * originUsername;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSDate * validTill;

@end
