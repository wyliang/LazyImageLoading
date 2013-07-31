//
//  PendingOperations.h
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingOperations : NSObject
@property (nonatomic, strong) NSMutableDictionary *downloadsInProgress;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end
