//
//  ViewController.m
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	manager = [[ImageManager alloc] initWithImageDownloaderDelegate:self];
	
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"]];
	CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data, kCFPropertyListImmutable, NULL);
	NSDictionary *datasource_dictionary = (__bridge NSDictionary *)plist;

	NSMutableArray *records = [NSMutableArray array];
	
	for (NSString *key in datasource_dictionary) {
		PhotoRecord *record = [[PhotoRecord alloc] init];
		record.URL = [NSURL URLWithString:[datasource_dictionary objectForKey:key]];
		record.name = key;
		[records addObject:record];
		record = nil;
	}
	
	// 7
	self.photos = records;
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *kCellIdentifier = @"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
        // 1
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = activityIndicatorView;
		
    }
	
    // 2
    PhotoRecord *aRecord = [self.photos objectAtIndex:indexPath.row];
	
    // 3
    if (aRecord.hasImage) {
		
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = aRecord.image;
        cell.textLabel.text = aRecord.name;
		
    }
    // 4
    else if (aRecord.isFailed) {
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Failed.png"];
        cell.textLabel.text = @"Failed to load";
		
    }
    // 5
    else {
		
        [((UIActivityIndicatorView *)cell.accessoryView) startAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.textLabel.text = @"";
        [manager startOperationsForPhotoRecord:aRecord atIndexPath:indexPath];
    }
	
    return cell;
}

- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader {
	
    NSIndexPath *indexPath = downloader.indexPathInTableView;
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [manager removeFromDownloadInProgress:indexPath];
}



@end
