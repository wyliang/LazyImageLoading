//
//  ImageManager.m
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager
- (id)init {
	NSLog(@"you are not supposed to use init");
	return nil;
}

- (id)initWithImageDownloaderDelegate:(id<ImageDownloaderDelegate>)delegate {
	if(self = [super init]) {
		self.delegate = delegate;
		self.pendingOperations = [[PendingOperations alloc] init];
	}
	return self;
}

- (void)startOperationsForPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath {
    // 1
    if (![self.pendingOperations.downloadsInProgress.allKeys containsObject:indexPath]) {
		
        // 2
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self.delegate];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:indexPath];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
}

- (void)removeFromDownloadInProgress:(NSIndexPath *)indexPath {
	[self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];

}

- (void)setDownloadQueueSuspended:(BOOL)suspended {
	[self.pendingOperations.downloadQueue setSuspended:suspended];
}

- (void)setFiltrationQueueSuspended:(BOOL)suspended {
}

- (void)cancelAllOperations {
	[self.pendingOperations.downloadQueue cancelAllOperations];
}

@end
