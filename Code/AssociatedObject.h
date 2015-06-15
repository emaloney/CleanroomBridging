//
//  AssociatedObject.h
//  Cleanroom Project
//
//  Created by Evan Maloney on 4/8/15.
//  Copyright (c) 2015 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (CleanroomBaseAssociatedObject)

- (void) setAssociatedObject:(nullable id)object
                      forKey:(nonnull const void*)key
               storagePolicy:(objc_AssociationPolicy)policy;

- (nullable id) associatedObjectForKey:(nonnull const void*)key;

@end

