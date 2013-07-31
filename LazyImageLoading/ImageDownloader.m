//
//  ImageDownloader.m
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import "ImageDownloader.h"
#import "PhotoRecord.h"

@implementation ImageDownloader

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath
				 delegate:(id<ImageDownloaderDelegate>) theDelegate {
	if (self = [super init]) {
        _delegate = theDelegate;
        _indexPathInTableView = indexPath;
        _photoRecord = record;
    }
    return self;
}

- (void)main {
	if (self.isCancelled)
		return;
	NSLog(@"Downloader started for record: %@", self.photoRecord);

	NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.photoRecord.URL];
	
	if (self.isCancelled) {
		imageData = nil;
		return;
	}
	
	if (imageData) {
		UIImage *downloadedImage = [UIImage imageWithData:imageData];
		self.photoRecord.image = downloadedImage;
	}
	else {
		self.photoRecord.failed = YES;
	}
	
	imageData = nil;
	
	if (self.isCancelled)
		return;
	
	// 5
	NSLog(@"Downloader stopped for record: %@", self.photoRecord);
	[(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];

}

@end
