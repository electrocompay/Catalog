//
//  IWOptionView.h
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWOptionView : UIView

@property (nonatomic, strong) IBOutlet UILabel* label;
@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSString* image;
-(void)clearSelection;

@end
