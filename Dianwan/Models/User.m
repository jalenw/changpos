//
//  User.m
//  xunyu
//
//  Created by noodle on 16/6/22.
//  Copyright © 2016年 intexh. All rights reserved.
//

#import "User.h"
#import "DBHelper.h"

@implementation UserPicObject

@end

@implementation User
+ (NSArray*)insertWithArray:(NSArray*)array context:(NSManagedObjectContext*)context
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];
    for(NSDictionary *dict in array)
    {
        User *object = [User insertOrReplaceWithDictionary:dict context:context];
        if (object)
        {
            [result addObject:object];
        }
    }
    
    return result;
}


+ (instancetype)insertOrReplaceWithDictionary:(NSDictionary*)dict context:(NSManagedObjectContext*)context
{
    if (!dict)
    {
        return nil;
    }
    
    User *object = nil;
    if ([dict hasObjectForKey:@"user_id"]) {
        object = [User getObjectById:[dict safeLongLongForKey:@"user_id"] context:context];
    }
    else
        object = [User getObjectById:[dict safeLongLongForKey:@"member_id"] context:context];
    if (object == nil)
    {
        object = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [User updateObject:object withDict:dict context:context];
        [AppDelegateInstance saveContext];
    }
    else
    {
        [User updateObject:object withDict:dict context:context];
        [AppDelegateInstance saveContext];
    }
    
    return object;
    
}

+ (instancetype)getObjectById:(long long)id context:(NSManagedObjectContext*)context
{
    NSString* predicateStr = [NSString stringWithFormat:@"member_id = %lld", id];
    return (User*)[DBHelper fetchOneEntity:@"User" predicate:[NSPredicate predicateWithFormat:predicateStr] sorts:nil context:context];
}

+ (void)updateObject:(User*)object withDict:(NSDictionary*)dict context:(NSManagedObjectContext*)context
{
    if ([dict hasObjectForKey:@"user_id"]) {
        [object tryUpdateFromDict:dict forModelKey:@"user_id" forNetKey:@"user_id" propertyType:PropertyTypeLonglong];
    }
    else
    {
        [object tryUpdateFromDict:dict forModelKey:@"member_id" forNetKey:@"member_id" propertyType:PropertyTypeLonglong];
    }
    if ([dict safeStringForKey:@"member_avatar"].length > 0) {
        [object tryUpdateFromDict:dict forModelKey:@"member_avatar" forNetKey:@"member_avatar" propertyType:PropertyTypeString];
    }

    [object tryUpdateFromDict:dict forModelKey:@"push_id" forNetKey:@"push_id" propertyType:PropertyTypeString];

    [object tryUpdateFromDict:dict forModelKey:@"member_name" forNetKey:@"member_name" propertyType:PropertyTypeString];

    [object tryUpdateFromDict:dict forKey:@"chat_id" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forModelKey:@"chat_pwd" forNetKey:@"chat_pwd" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forModelKey:@"member_mobile" forNetKey:@"member_mobile" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forModelKey:@"age" forNetKey:@"age" propertyType:PropertyTypeString];
    
    [object tryUpdateFromDict:dict forModelKey:@"member_id" forNetKey:@"member_id" propertyType:PropertyTypeLonglong];
    
    [object tryUpdateFromDict:dict forKey:@"evolution_address" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forKey:@"evolution_city" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forKey:@"evolution_city_id" propertyType:PropertyTypeLonglong];
    [object tryUpdateFromDict:dict forKey:@"idcard" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forKey:@"is_approve" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"is_bank" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"is_inviter" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"is_kefu" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"is_paypwd" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"member_level" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"idcard" propertyType:PropertyTypeString];
    [object tryUpdateFromDict:dict forKey:@"member_points" propertyType:PropertyTypeLonglong];
    [object tryUpdateFromDict:dict forKey:@"sex" propertyType:PropertyTypeInt];
    [object tryUpdateFromDict:dict forKey:@"truename" propertyType:PropertyTypeString];
}
@end
