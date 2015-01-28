//
//  DemoTableControllerViewController.m
//  FPPopoverDemo
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "DemoTableController.h"

@interface DemoTableController ()

@end

@implementation DemoTableController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"目录";
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ConfigManager sharedManager].muluArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell.textLabel setNumberOfLines:2];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    MuLuItem *temp = [[ConfigManager sharedManager].muluArray objectAtIndex:indexPath.row];
    cell.textLabel.text = temp.muluName;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MuLuItem *temp = (MuLuItem *)[[ConfigManager sharedManager].muluArray objectAtIndex:indexPath.row];
    
    [ConfigManager sharedManager].chooseMulu = temp.muluPage;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choosemulu" object:nil];
    
}

@end
