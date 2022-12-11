// for mac support
#import <Cocoa/Cocoa.h>

void* getNSView(NSWindow* nsWindow)
{
    return (__bridge void*)([nsWindow contentView]);
}