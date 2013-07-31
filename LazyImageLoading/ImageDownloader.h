//
//  ImageDownloader.h
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoRecord;

@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSOperation

@property (nonatomic, assign) id<ImageDownloaderDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) PhotoRecord *photoRecord;

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>) theDelegate;

@end


@protocol ImageDownloaderDelegate
- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;
@end