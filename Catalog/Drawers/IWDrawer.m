//
//  IWDrawer.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWDrawer.h"

@implementation IWDrawer


-(id)init
{
    self = [super init];
    
    if (self) {
        _frontView = YES;
        _offsetY = 0;
    }
    
    return self;
}

+(id)drawerWithView:(UIView *)view
{
    IWDrawer *drawer = [[IWDrawer alloc] init];
    drawer.view = view;
    return drawer;
}


-(void)drawForniture:(IWForniture *)forniture
{
}

-(void) clear
{
    [_view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(UIView*)addLayer:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        NSLog(@"MISSING IMAGE: %@", imageName);
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        imageView.frame = CGRectOffset(_view.bounds, 0, _offsetY);
        [_view addSubview:imageView];
        return imageView;
    }
    return  nil;
}


@end
