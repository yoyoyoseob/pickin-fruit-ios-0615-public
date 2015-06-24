//
//  FISViewController.m
//  pickinFruit
//
//  Created by Joe Burgess on 7/3/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

- (IBAction)spin:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.fruitsArray = @[@"Apple",@"Orange",@"Banana",@"Pear",@"Grape", @"Kiwi", @"Mango", @"Blueberry", @"Raspberry"];
    
    self.fruitPicker.delegate = self;
    self.fruitPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Spin Methods
- (IBAction)spin:(id)sender
{
    [self performSelector:@selector(spinner:) withObject:@0 afterDelay:0];
    [self performSelector:@selector(spinner:) withObject:@1 afterDelay:.04];
    [self performSelector:@selector(spinner:) withObject:@2 afterDelay:.07];
    
    [self.fruitPicker reloadAllComponents];
    [self performSelector:@selector(checkIfWon) withObject:nil afterDelay:.09];
}

-(void)spinner:(NSNumber *)number
{
    NSUInteger component = [number integerValue];
    NSUInteger randomRow = arc4random_uniform(self.fruitsArray.count * 100);
    [self.fruitPicker selectRow:randomRow inComponent:component animated:YES];
}

-(void)checkIfWon
{
    NSInteger firstrow = ([self.fruitPicker selectedRowInComponent:0] % self.fruitsArray.count);
    NSString *fruit1 = self.fruitsArray[firstrow];
    NSLog(@"%@", fruit1);
    
    NSInteger secondrow = ([self.fruitPicker selectedRowInComponent:1] % self.fruitsArray.count);
    NSString *fruit2 = self.fruitsArray[secondrow];
    NSLog(@"%@", fruit2);
    
    NSInteger thirdrow = ([self.fruitPicker selectedRowInComponent:2] % self.fruitsArray.count);;
    NSString *fruit3 = self.fruitsArray[thirdrow];
    NSLog(@"%@", fruit3);
    
    NSMutableSet *fruitSet = [[NSSet setWithObjects:fruit1, fruit2, fruit3, nil]mutableCopy];
    if (fruitSet.count == 1){
        [self alert];
        [fruitSet removeAllObjects];
    }
}

#pragma mark - Setup
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (self.fruitsArray.count * 100);
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return self.fruitsArray[row];
    return self.fruitsArray[(row % self.fruitsArray.count)];
}

-(void)alert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You won!" message:@"Play again?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *respin = [UIAlertAction actionWithTitle:@"Re-spin" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        [self spin:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        [self.fruitPicker reloadAllComponents];
    }];
    
    [alert addAction:respin];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
