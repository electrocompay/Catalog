//
//  IWTriangle.m
//  Catalog
//
//  Created by Abel Miranda on 5/1/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWTriangle.h"

@interface IWTriangle ()

@end

@implementation IWTriangle

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSInteger width = 20;
    NSInteger offset = 15;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMaxX(rect) - width - offset, CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect) - offset, CGRectGetMaxY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect) - 2*width - offset, CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    CGContextSetRGBFillColor(ctx, 0.9, 0.9, 0.9, 1);
    CGContextFillPath(ctx);
}

@end
