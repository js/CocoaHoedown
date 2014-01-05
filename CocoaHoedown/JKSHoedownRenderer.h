//
//  JKSHoedownRenderer.h
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKSHoedownRenderer : NSObject
/// Whether or not to preprocess with "smarty pants". Defaults to yes
@property (nonatomic, assign, getter = isSmartyPantsEnabled) BOOL smartyPantsEnabled;

- (instancetype)initWithString:(NSString *)string;

- (NSString *)renderedHTML;

@end
