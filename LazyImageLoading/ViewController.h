//
//  ViewController.h
//  LazyImageLoading
//
//  Created by David Liang on 7/30/13.
//  Copyright (c) 2013 David Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageManager.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ImageDownloaderDelegate>
{
	ImageManager *manager;
}

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
