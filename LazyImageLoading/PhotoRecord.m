//
//  PhotoRecord.m
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import "PhotoRecord.h"

@implementation PhotoRecord

- (BOOL)isFailed {
    return _failed;
}

- (BOOL)hasImage {
	return _image != nil;
}


@end
