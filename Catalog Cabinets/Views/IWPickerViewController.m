//
//  IWPickerViewViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWPickerViewController.h"
#import "IWColor.h"
#import "IWStrokeLabel.h"

@interface IWPickerViewController ()

@end

@implementation IWPickerViewController
{
    IBOutlet UIPickerView *_pickerView;
    IBOutlet UILabel *label;
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
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWPickerViewController" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
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

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    IWStrokeLabel *stroke;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, pickerView.bounds.size.width, 32);
        pickerLabel = [[UILabel alloc] initWithFrame:frame] ;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        stroke = [[IWStrokeLabel alloc] init];
        [pickerLabel addSubview:stroke];
        stroke.frame = pickerLabel.bounds;
    } else {
        stroke = pickerLabel.subviews[0];
    }
    
    
    if ([self selectionInvalid:row]) {
        stroke.hidden = NO;
        pickerLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    } else {
        stroke.hidden = YES;
        pickerLabel.textColor = [UIColor blackColor];
    }
    
    IWColor *color = [_items objectAtIndex:row];
    [pickerLabel setText:color.name];
    
    return pickerLabel;
}

-(BOOL)selectionInvalid:(NSInteger)row
{
    IWColor *color = [_items objectAtIndex:row];
    return ((_left == 1 || _right == 1) && [color.code isEqualToString:@"1,0"]) || (_dissableMoreThan1 && row > 1);
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self selectionInvalid:row]) {
        [pickerView selectRow:_lastRow inComponent:0 animated:YES];
    } else {
        IWColor *newSelection = [_items objectAtIndex:row];
        if (newSelection != _selection) {
            _lastRow = row;
            _selection = newSelection;
            if (_delegate) {
                [_delegate pickerViewController:self didSelectRow:_selection];
            }
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

-(void)setTitle:(NSString *)title
{
    _title = title;
    [label setText:_title];
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
