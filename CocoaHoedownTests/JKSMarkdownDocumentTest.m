//
//  JKSHoedownRendererTest.m
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import "JKSMarkdownDocument.h"

@interface JKSMarkdownDocumentTest : XCTestCase

@end

@implementation JKSMarkdownDocumentTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testInitWithData
{
    NSData *data = [@"foo" dataUsingEncoding:NSUTF8StringEncoding];
    JKSMarkdownDocument *r2 = [[JKSMarkdownDocument alloc] initWithData:data];
    expect([r2 valueForKey:@"markdownData"]).to.equal(data);
}


- (void)testInitWithString
{
    JKSMarkdownDocument *r2 = [[JKSMarkdownDocument alloc] initWithString:@"foo"];
    expect([r2 valueForKey:@"markdownData"]).to.equal([@"foo" dataUsingEncoding:NSUTF8StringEncoding]);
}


#pragma mark HTML rendering

- (void)testRenderingEmptyString
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:nil];
    expect([renderer HTML]).to.beNil();

    renderer = [[JKSMarkdownDocument alloc] initWithString:@""];
    expect([renderer HTML]).to.beNil();
}


- (void)testSimpleRendering
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:@"foo _bar_ **baz**"];
    expect([renderer HTML]).to.equal(@"<p>foo <em>bar</em> <strong>baz</strong></p>\n");
}


- (void)testSmartyPants
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:@"\"clever -- pants\"..."];
    renderer.smartyPantsEnabled = YES;
    expect([renderer HTML]).to.equal(@"<p>&ldquo;clever &ndash; pants&rdquo;&hellip;</p>\n");
}


#pragma mark TOC rendering

- (void)testTOC
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:@"one\n===\n\nfoo\n\ntwo\n----\nbar\n"];
    NSString *output = @"<ul>\n<li>\n<a href=\"#toc_0\">one</a>\n<ul>\n"
                        "<li>\n<a href=\"#toc_1\">two</a>\n</li>\n</ul>"
                        "\n</li>\n</ul>\n";
    expect([renderer tableOfContentsHTML]).to.equal(output);
}


- (void)testTOCRenderingEmptyString
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:nil];
    expect([renderer tableOfContentsHTML]).to.beNil();

    renderer = [[JKSMarkdownDocument alloc] initWithString:@""];
    expect([renderer tableOfContentsHTML]).to.beNil();
}


#pragma mark Render options and extentions

- (void)testMarkdownExtentions
{
    JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:@"~~something~~ www.example.com"];
    renderer.markdownExtentions = (JKSMarkdownExtentionAutolink | JKSMarkdownExtentionStrikethrough);
    expect([renderer HTML]).to.equal(@"<p><del>something</del> <a href=\"http://www.example.com\">www.example.com</a></p>\n");
}

@end
