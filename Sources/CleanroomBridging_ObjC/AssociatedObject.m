//
//  AssociatedObject.m
//  Cleanroom Project
//
//  Created by Evan Maloney on 4/8/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

#import "AssociatedObject.h"

@implementation NSObject (CleanroomBridgingAssociatedObject)

- (void) setAssociatedObject:(nullable id)object
                      forKey:(nonnull NSString*)key
               storagePolicy:(ObjectStoragePolicy)policy
{
    objc_setAssociatedObject(self, (const void*)[key hash], object, (objc_AssociationPolicy)policy);
}

- (nullable id) associatedObjectForKey:(nonnull NSString*)key
{
    return objc_getAssociatedObject(self, (const void*)[key hash]);
}

@end
