//
//  UserProfileManager.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "UserProfileManager.h"
#import "UserManager.h"

#define K_MAX_ARRAYCOUNT 1
static UserProfileManager *_sharedManager = nil;

@implementation UserProfileManager

@synthesize userId = _userId;
@synthesize userPayCardArray = _userPayCardArray;
@synthesize userDeliveryAddressArray = _userDeliveryAddressArray;

+ (UserProfileManager *)sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[UserProfileManager alloc] init];
    }
    
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self loadData];
    }
    
    return self;
}

- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if (![UserManager sharedManager].userID || [UserManager sharedManager].userID.length == 0) {
        return nil;
    }
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"userProfile%@.data", [UserManager sharedManager].userID]];
}

- (void)loadData
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]])
    {
        NSArray *itemListGroup = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        self.userPayCardArray = [NSMutableArray arrayWithArray:[itemListGroup objectAtIndex:0]];
        self.userDeliveryAddressArray = [NSMutableArray arrayWithArray:[itemListGroup objectAtIndex:1]];

    }
    else
    {
        self.userPayCardArray = [NSMutableArray arrayWithCapacity:1];
        self.userDeliveryAddressArray = [NSMutableArray arrayWithCapacity:1];
    }
        
}

- (void)storeDataToFile
{
    NSArray *itemListGroup = [NSArray arrayWithObjects:self.userPayCardArray, 
                              self.userDeliveryAddressArray, 
                              nil];
    if (![NSKeyedArchiver archiveRootObject:itemListGroup toFile:[self filePath]])
    {
        //NSLog(@"Failed to archive favorite list to file <%@>", [self filePath]);
    }
}

- (void)addNewBankCard:(UserBankCardItem *)item
{
    [_userPayCardArray insertObject:item atIndex:0];
    int count = [_userPayCardArray count];
    if (count > K_MAX_ARRAYCOUNT) {
        [self removeBankCard:count -1];
    }
    
    [self storeDataToFile];
}

- (void)removeBankCard:(int)index
{
    int count = [_userPayCardArray count];
    if (count > 0 && count > index ) {
        [_userPayCardArray removeObjectAtIndex:index];
    }
}

- (void)addNewDeliveryAddress:(UserDeliveryAddress *)address
{
    [_userDeliveryAddressArray insertObject:address atIndex:0];
    int count = [_userDeliveryAddressArray count];
    if (count > K_MAX_ARRAYCOUNT) {
        [self removeBankCard:count -1];
    }
    
    [self storeDataToFile];
}

- (void)removeDeliveryAddress:(int)index
{
    int count = [_userDeliveryAddressArray count];
    if (count > 0 && count > index ) {
        [_userDeliveryAddressArray removeObjectAtIndex:index];
    }
}

- (void)dealloc
{
    [_userId release];
    [_userPayCardArray release];
    [_userDeliveryAddressArray release];
    
    [super dealloc];
}

@end
