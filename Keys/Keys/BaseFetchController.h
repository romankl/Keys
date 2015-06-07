//
//  BaseFetchController.h
//  Cocktails
//
//  Created by Roman Klauke on 02.05.15.
//  Copyright (c) 2015 Roman Klauke. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreData;

@interface BaseFetchController : UITableViewController <NSFetchedResultsControllerDelegate>

@property(strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end