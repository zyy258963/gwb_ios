//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "AddressDate.h"
#import "PhoneNumberFormatter.h"

@implementation AddressDate

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        addressArray = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)dealloc
{
    [addressArray release];
    [super dealloc];
}

- (void)collectContacts
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef people  = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for(int i = 0;i<CFArrayGetCount(people);i++)
    {
        AddressItem *addItem = [[AddressItem alloc] init];
        
        ABRecordRef ref=CFArrayGetValueAtIndex(people, i);
        NSString *firstName = (NSString *)ABRecordCopyValue(ref,kABPersonFirstNameProperty);
        NSString *lastName = (NSString *)ABRecordCopyValue(ref,kABPersonLastNameProperty);
        
        NSMutableString *name = [[NSMutableString alloc] init];
        if (lastName) 
        {
            [name appendString:lastName];
        }
        if (firstName) 
        {
            [name appendString:firstName];
        }

        addItem.name = name;
        
        [name release];
        
        (firstName==NULL)?:[firstName release];  
        (lastName==NULL)?:[lastName release];
        
        
        NSMutableString *arPhone = [[NSMutableString alloc] init];
        ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);    
        multiPhone = ABRecordCopyValue(ref, kABPersonPhoneProperty);  
        for(CFIndex j = 0; j < ABMultiValueGetCount(multiPhone); j++)
        {  
            if (j>=1) 
            {
                break;
            }
            CFStringRef labelRef = ABMultiValueCopyLabelAtIndex(multiPhone, j);  
            CFStringRef numberRef = ABMultiValueCopyValueAtIndex(multiPhone, j);  
             
            if([(NSString *)labelRef isEqualToString:(NSString *) kABPersonPhoneMobileLabel])
            {  
                PhoneNumberFormatter *pnf = [[PhoneNumberFormatter alloc] init];
                NSString *number = (NSString *)numberRef;
                if (number.length >= 11) 
                {
                    [arPhone appendString:[pnf stringFromPhoneNumber:(NSString *)numberRef]];
                }
               
                [pnf release];
                
            }
            CFRelease(labelRef);  
            CFRelease(numberRef);
            
        }
        
        addItem.phoneNumber = arPhone;
        [arPhone release];
        
        if (arPhone.length !=0) 
        {
            [addressArray addObject:addItem];
        }
   
        [addItem release];
    }
    
    CFRelease(addressBook);
    CFRelease(people);
    
}

- (NSMutableArray *)address
{
    return addressArray;
}

@end
