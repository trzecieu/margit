#import <Cocoa/Cocoa.h>

#import "MargitOpenGLView.h"

@interface MargitMacAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow* window;
  MargitOpenGLView* openGLView;
}

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet MargitOpenGLView* openGLView;

@end
