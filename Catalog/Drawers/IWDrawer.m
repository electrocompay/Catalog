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

-(void)addLayer:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        NSLog(@"MISSING IMAGE: %@", imageName);
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.frame = _view.bounds;
    [_view addSubview:imageView];
}


@end
