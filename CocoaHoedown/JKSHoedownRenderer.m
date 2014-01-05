//
//  JKSHoedownRenderer.m
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import "JKSHoedownRenderer.h"
#import "markdown.h"
#import "html.h"

@interface JKSHoedownRenderer ()
@property (nonatomic, strong) NSData *markdownData;
@end

@implementation JKSHoedownRenderer

- (instancetype)initWithString:(NSString *)string {
    if ((self = [self init])) {
        _markdownData = [string dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}


- (id)init {
    if ((self = [super init])) {
        _smartyPantsEnabled = YES;
    }
    return self;
}


- (NSString *)renderedHTML {
    if ([self.markdownData length] == 0) {
        return nil;
    }

    hoedown_renderer *renderer = hoedown_html_renderer_new(0, 0);
    hoedown_markdown *markdown = hoedown_markdown_new(0, 16, renderer);

    hoedown_buffer *outputBuffer = hoedown_buffer_new(64);
    hoedown_markdown_render(outputBuffer, [self.markdownData bytes], [self.markdownData length], markdown);

    NSString *output = @(hoedown_buffer_cstr(outputBuffer));

    hoedown_buffer_free(outputBuffer);

    return output;
}

@end
