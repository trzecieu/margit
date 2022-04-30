#import "MargitOpenGLView.h"

@implementation MargitOpenGLView

// Callback for the CoreVideo display link that's set up in prepareOpenGL.
static CVReturn
display_link_cb (CVDisplayLinkRef displayLink,
                 const CVTimeStamp* now,
                 const CVTimeStamp* outputTime,
                 CVOptionFlags flagsIn,
                 CVOptionFlags* flagsOut,
                 void* displayLinkContext)
{
  MargitOpenGLView* view = (MargitOpenGLView*) displayLinkContext;
  return [view getFrameForTime: outputTime];
}

- (void) prepareOpenGL
{
  // Tell the GL context to swap buffers at vsync.
  GLint swap = 1;
  [[self openGLContext] setValues: &swap forParameter: NSOpenGLCPSwapInterval];
  
  // Set up a CoreVideo display link to drive the redraw loop perfectly.
  CVDisplayLinkCreateWithActiveCGDisplays (&displayLink);
  CVDisplayLinkSetOutputCallback (displayLink, display_link_cb, self);
  CGLContextObj cglContext =  (CGLContextObj) [[self openGLContext] CGLContextObj];
  CGLPixelFormatObj cglPixelFormat = (CGLPixelFormatObj) [[self pixelFormat] CGLPixelFormatObj];
  CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
  
  // Start the redraw loop.
  CVDisplayLinkStart (displayLink);
}

- (void) dealloc 
{
  CVDisplayLinkRelease (displayLink);
  [super dealloc];
}

- (CVReturn) getFrameForTime: (const CVTimeStamp *) outputTime
{
  return kCVReturnSuccess;
}

@end
