//
//  IWPickerViewViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWSimplePickerViewController.h"
#import "IWColor.h"
#import "IWStrokeLabel.h"

@interface IWSimplePickerViewController ()

@end

@implementation IWSimplePickerViewController
{
    IBOutlet UIPickerView *_pickerView;
    NSInteger _lastRow;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWSimplePickerViewController" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
//    CGRect rect = view.frame;
//    self.frame = rect;
    [_pickerView setDelegate:self];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _items.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    IWColor *color = [_items objectAtIndex:row];
    return [color name];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, pickerView.bounds.size.width, 24);
        pickerLabel = [[UILabel alloc] initWithFrame:frame] ;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.numberOfLines = 1;
    }
    
    pickerLabel.textColor = [UIColor blackColor];
    
    IWColor *color = [_items objectAtIndex:row];
    [pickerLabel setText:color.name];
    
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        IWColor *newSelection = [_items objectAtIndex:row];
        if (newSelection != _selection) {
            _lastRow = row;
            _selection = newSelection;
            if (_delegate) {
                [_delegate simplePickerViewController:self didSelectRow:_selection];
            }
        }
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    [self reloadAllComponents];
     
}

-(void)reloadAllComponents{
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:0 inComponent:0 animated:NO];
    _selection = [_items objectAtIndex:0];
}

-(void)setEnabled:(BOOL)enabled
{
    _pickerView.userInteractionEnabled = enabled;
}

-(BOOL)enabled
{
    return _pickerView.userInteractionEnabled;
}

-(void)reset
{
    if (_items.count > 0) {
        [_pickerView selectRow:0 inComponent:0 animated:NO];
        _selection = [_items objectAtIndex:0];
    }
}

-(void)resetAndDisable
{
    [self reset];
    [self setEnabled:NO];
}

-(NSInteger)selectedIndex
{
    return [_pickerView selectedRowInComponent:0];
}

-(void)refresh
{
    [_pickerView reloadAllComponents];
}


@end
