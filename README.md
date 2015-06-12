CocoaHoedown
============

CocoaHoedown is an Objective-C wrapper for [hoedown](https://github.com/hoedown/hoedown), which renders HTML from Markdown.


Installation
------------

Right now it could be installed from a git repo, like:

`pod 'CocoaHoedown', :git => 'https://github.com/js/CocoaHoedown.git'`


Usage
------

```
JKSMarkdownDocument *renderer = [[JKSMarkdownDocument alloc] initWithString:@"\"clever -- pants\"..."];
renderer.smartyPantsEnabled = YES;
NSString *output = [renderer HTML]; // "<p>&ldquo;clever &ndash; pants&rdquo;&hellip;</p>\n"
```

Credits
-------

CocoaHoedown is just a simple wrapper around [hoedown](https://github.com/hoedown/hoedown), all credit for the actual markdown parsing and rendering goes to the authors of hoedown.

License
-------

Released under the [MIT License](LICENSE).
