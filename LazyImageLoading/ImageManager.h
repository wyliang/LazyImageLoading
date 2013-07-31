//
//  ImageManager.h
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"
#import "PhotoRecord.h"
#import "PendingOperations.h"

@class PhotoRecord;
@protocol ImageDownloaderDelegate;

@interface ImageManager : NSObject

@property (nonatomic, strong) PendingOperations *pendingOperations;
@property (nonatomic, assign) id<ImageDownloaderDelegate> delegate;

- (void)startOperationsForPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath;
- (void)removeFromDownloadInProgress:(NSIndexPath *)indexPath;

- (id)initWithImageDownloaderDelegate:(id<ImageDownloaderDelegate>)delegate;

- (void)setDownloadQueueSuspended:(BOOL)suspended;
- (void)setFiltrationQueueSuspended:(BOOL)suspended;
- (void)cancelAllOperations;

@end
