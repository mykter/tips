/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "OverlayView.h"

static const CGFloat kPadding = 10;

@interface OverlayView()
@property (nonatomic,assign) UIButton *cancelButton;
@property (nonatomic,retain) UILabel *instructionsLabel;
@end


@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;
@synthesize cancelButton;
@synthesize cropRect;
@synthesize instructionsLabel;
@synthesize displayedMessage;



#pragma Flahes

- (void) flashLookingForUser
{
    NSLog(@"flashLookingForUser called...");
    additionLabel = @"Looking up...";
    
    if (showAdditionalFlash) showAdditionalFlash = NO;
    showLookingFlash = YES;
    
    [cancelButton setTitle:@"Done" forState:UIControlStateNormal];
    
    useRed = NO;
    
    [self performSelector:@selector(startUsingRed) 
               withObject:self 
               afterDelay:0.3];
}


- (void) startUsingRed
{
    useRed = YES;
}

- (void) flashGroupAddition: (NSString *) name isNew: (BOOL) newPerson
{
    NSLog(@"flashGroupAddition called...");
    additionLabel = [NSString stringWithFormat: @"Adding %@", name];
    
    if (showLookingFlash) showLookingFlash = NO;
    showAdditionalFlash = YES;

    [cancelButton setTitle:@"Done" forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
  self = [super initWithFrame:theFrame];
  if( self ) {

    useRed = YES;  
      
    CGFloat rectSize = self.frame.size.width - kPadding * 2;
    if (!oneDMode) {
      cropRect = CGRectMake(kPadding, (self.frame.size.height - rectSize) / 2, rectSize, rectSize);
    } else {
      CGFloat rectSize2 = self.frame.size.height - kPadding * 2;
      cropRect = CGRectMake(kPadding, kPadding, rectSize, rectSize2);		
    }

      showAdditionalFlash = NO;
      showLookingFlash = NO;
      
    self.backgroundColor = [UIColor clearColor];
    self.oneDMode = isOneDModeEnabled;
    if (isCancelEnabled) {
      UIButton *butt = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
      self.cancelButton = butt;
      [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
      if (oneDMode) {
        [cancelButton setTransform:CGAffineTransformMakeRotation(M_PI/2)];
        
        [cancelButton setFrame:CGRectMake(20, 175, 45, 130)];
      }
      else {
        CGSize theSize = CGSizeMake(100, 50);
        CGRect theRect = CGRectMake((theFrame.size.width - theSize.width) / 2, cropRect.origin.y + cropRect.size.height + 20, theSize.width, theSize.height);
        [cancelButton setFrame:theRect];
        
      }
      
      [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:cancelButton];
      [self addSubview:imageView];
    }
  }
  return self;
}

- (void)cancel:(id)sender {
	// call delegate to cancel this scanner
	if (delegate != nil) {
		[delegate cancelled];
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {

}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
	CGContextStrokePath(context);
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
    case 0:
        point.x = x;
        point.y = y;
        break;
    case 90:
        point.x = -y;
        point.y = x;
        break;
    case 180:
        point.x = -x;
        point.y = -y;
        break;
    case 270:
        point.x = y;
        point.y = -x;
        break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}

#define kTextMargin 10

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect 
{
    //NSLog(@" :::::: Experimental :::::: OverlayView drawRect has been called refresing the draw - animation would be keyed from here.");
    
	[super drawRect:rect];
  
    if (displayedMessage == nil) 
    {
        self.displayedMessage = @"Place a barcode inside the viewfinder rectangle to scan it.";
    }
	
    CGContextRef c = UIGraphicsGetCurrentContext();
  
	if (nil != _points) 
    {
        //Disabled in original.
        //imageView.image drawAtPoint:cropRect.origin];
	}
	
    //Setup the stroke and drawing...

    if (useRed)
    {
        CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(c, red);
        CGContextSetFillColor(c, red);
        CGContextSetLineWidth(c, 1.0);
    }
    else 
    {
        CGFloat green[4] = {0.0f, 1.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(c, green);
        CGContextSetFillColor(c, green);
        CGContextSetLineWidth(c, 2.0);
    }
    
    
	[self drawRect:cropRect inContext:c];
	
    
    //CGContextSetStrokeColor(c, white);
	//CGContextSetStrokeColor(c, white);
	CGContextSaveGState(c);
	
    // This is for drawing the top text.
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize constraint = CGSizeMake(rect.size.width  - 2 * kTextMargin, cropRect.origin.y);
    
    CGSize displaySize = [self.displayedMessage sizeWithFont:font constrainedToSize:constraint];
    CGRect displayRect = CGRectMake((rect.size.width - displaySize.width) / 2 , cropRect.origin.y - displaySize.height, displaySize.width, displaySize.height);

    //Don't display this image if the user has a popup.
    if (!showAdditionalFlash && !showLookingFlash)
    {    
        [self.displayedMessage drawInRect:displayRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    }
    
    if (showAdditionalFlash || showLookingFlash)
    {
        //Defines the location of anything flashy.
        CGRect flashBox = CGRectMake(10, 30, 300, 50);
        CGRect flashText = CGRectMake(70, 45, 240, 45);
        
        if (additionalStatus == nil)
        {
            NSLog(@"Creating additional status image...");
            
            additionalStatus = [[UIImageView alloc] initWithFrame:flashBox];
            additionalStatus.image = [UIImage imageNamed: @"AddUserFlash.png"];
        }
        
        [self addSubview:additionalStatus];
        
        CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
        CGContextSetStrokeColor(c, white);
        CGContextSetFillColor(c, white);

        //[self drawRect: flashBox inContext:c];

        
        //Rails style flash messages...
        //When we're looking for a user we're unsure of.
        if (showLookingFlash)
        {
            [additionLabel drawInRect:flashText withFont:font];
        }
        
        //This is for when we have an identified user to add
        if (showAdditionalFlash)
        {
            [additionLabel drawInRect:flashText withFont:font];
        }
    }
    
	CGContextRestoreGState(c);
	//int offset = rect.size.width / 2;
    
    /*
    if( nil != _points ) 
    {
		CGFloat blue[4] = {0.0f, 0.0f, 1.0f, 1.0f};
		CGContextSetStrokeColor(c, blue);
		CGContextSetFillColor(c, blue);

        
        CGRect smallSquare = CGRectMake(0, 0, 10, 10);

        for( NSValue* value in _points ) 
        {
            CGPoint point = [self map:[value CGPointValue]];
            smallSquare.origin = CGPointMake(
                                     cropRect.origin.x + point.x - smallSquare.size.width / 2,
                                     cropRect.origin.y + point.y - smallSquare.size.height / 2);
            
            [self drawRect:smallSquare inContext:c];
        }
	}
     */
}


////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 - (void) setImage:(UIImage*)image {
 //if( nil == imageView ) {
// imageView = [[UIImageView alloc] initWithImage:image];
// imageView.alpha = 0.5;
// } else {
 imageView.image = image;
 //}
 
 //CGRect frame = imageView.frame;
 //frame.origin.x = self.cropRect.origin.x;
 //frame.origin.y = self.cropRect.origin.y;
 //imageView.frame = CGRectMake(0,0, 30, 50);
 
 //[_points release];
 //_points = nil;
 //self.backgroundColor = [UIColor clearColor];
 
 //[self setNeedsDisplay];
 }
 */

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*) image {
	return imageView.image;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    _points = pnts;
	
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


@end
