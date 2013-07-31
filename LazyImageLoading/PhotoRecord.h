//
//  PhotoRecord.h
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoRecord : NSObject

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) BOOL hasImage; // Return YES if image is downloaded.
@property (nonatomic, getter = isFailed) BOOL failed;

@end
