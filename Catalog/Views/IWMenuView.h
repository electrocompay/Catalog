//
//  IWMenuView.h
//  Catalog
//
//  Created by Abel Miranda on 4/29/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWMenuView;

@protocol IWMenuViewdelegate <NSObject>

-(void)menuView:(IWMenuView*) menuView didClick:(NSInteger)optionIndex;

@end

@interface IWMenuView : UIView

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, weak) id<IWMenuViewdelegate> delegate;

@end
