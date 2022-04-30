#import "MargitMacAppDelegate.h"

@implementation MargitMacAppDelegate

@synthesize window;
@synthesize openGLView;

- (void) applicationDidFinishLaunching: (NSNotification *) notification
{
  srandomdev ();
}

@end
