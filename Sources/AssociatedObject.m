//
//  AssociatedObject.m
//  Cleanroom Project
//
//  Created by Evan Maloney on 4/8/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

#import "AssociatedObject.h"

@implementation NSObject (CleanroomBaseAssociatedObject)

- (void) setAssociatedObject:(nullable id)object
                      forKey:(nonnull NSString*)key
               storagePolicy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject(self, (__bridge const void*)key, object, policy);
}

- (nullable id) associatedObjectForKey:(nonnull NSString*)key
{
    return objc_getAssociatedObject(self, (__bridge const void*)key);
}

@end
