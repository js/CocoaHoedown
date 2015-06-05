//
//  JKSHoedownRenderer.m
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import "JKSMarkdownDocument.h"
#import "document.h"
#import "html.h"

static const int kNestingLevel = 15;
static const size_t kBufferUnit = 64;

@interface JKSMarkdownDocument ()
@property (nonatomic, strong) NSData *markdownData;
@end

@implementation JKSMarkdownDocument

- (instancetype)initWithData:(NSData *)data
{
    if ((self = [super init])) {
        _markdownData = data;
    }
    return self;
}


- (instancetype)initWithString:(NSString *)string
{
    return [self initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}


#pragma mark API

- (NSString *)HTML
{
    if ([self.markdownData length] == 0) {
        return nil;
    }

    hoedown_renderer *renderer = hoedown_html_renderer_new((hoedown_html_flags)self.renderOptions, kNestingLevel);
    NSString *output = render(renderer, self);
    hoedown_html_renderer_free(renderer);

    return output;
}


- (NSString *)tableOfContentsHTML
{
    if ([self.markdownData length] == 0) {
        return nil;
    }

    hoedown_renderer *renderer = hoedown_html_toc_renderer_new(kNestingLevel);
    NSString *output = render(renderer, self);
    hoedown_html_renderer_free(renderer);

    return output;
}


#pragma mark Internal methods

static inline NSString* render(const hoedown_renderer *renderer, JKSMarkdownDocument *self)
{
    hoedown_document *markdown = hoedown_document_new(renderer, (hoedown_extensions)self.markdownExtentions, kNestingLevel);

    hoedown_buffer *outputBuffer = hoedown_buffer_new(kBufferUnit);
    hoedown_buffer *sourceBuffer = hoedown_buffer_new(kBufferUnit);

    if (self.isSmartyPantsEnabled) {
        hoedown_html_smartypants(sourceBuffer, [self.markdownData bytes], [self.markdownData length]);
    } else {
        hoedown_buffer_put(sourceBuffer, [self.markdownData bytes], [self.markdownData length]);
    }

    hoedown_document_render(markdown, outputBuffer, sourceBuffer->data, sourceBuffer->size);
    NSString *output = @(hoedown_buffer_cstr(outputBuffer));

    hoedown_document_free(markdown);
    hoedown_buffer_free(outputBuffer);

    return output;
}

@end
