//
//  JKSHoedownRenderer.h
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKSMarkdownDocument : NSObject
/// Whether or not to preprocess with "smarty pants". Defaults to NO
@property (nonatomic, assign, getter = isSmartyPantsEnabled) BOOL smartyPantsEnabled;

- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithString:(NSString *)string;

- (NSString *)HTML;
//- (NSSTring *)HTMLWithOptions:(JKSMarkdownDocumentOptions)options;
- (NSString *)tableOfContents;

@end
