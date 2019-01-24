//
//  User+CoreDataProperties.h
//  happy
//
//  Created by noodle on 16/9/19.
//  Copyright © 2016年 intexh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)
@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *member_avatar;
@property (nullable, nonatomic, retain) NSString *chat_id;
@property (nullable, nonatomic, retain) NSString *chat_pwd;
@property (nullable, nonatomic, retain) NSString *evolution_address;
@property (nullable, nonatomic, retain) NSString *evolution_city;
@property (nonatomic ) int64_t evolution_city_id;
@property (nullable, nonatomic, retain) NSString *idcard;
@property (nonatomic, assign) int16_t is_approve;
@property (nonatomic, assign) int16_t is_bank;
@property (nonatomic, assign) int16_t is_inviter;
@property (nonatomic, assign) int16_t is_kefu;
@property (nonatomic, assign) int16_t is_paypwd;
@property (nonatomic ) int64_t member_id;
@property (nonatomic, assign) int16_t member_level;
@property (nullable, nonatomic, retain) NSString *push_id;
@property (nullable, nonatomic, retain) NSString *member_mobile;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nonatomic, nullable,retain) NSString *member_name;
@property (nonatomic ) int64_t member_points;
@property (nonatomic, nullable,retain) NSString *truename;
@end

@interface User (CoreDataGeneratedAccessors)


@end

NS_ASSUME_NONNULL_END
