//
//  XML_ParserAppDelegate.h
//  XML Parser
//
//  Created by Evan Johnson on 4/27/11.
//  Copyright 2011 Boniface Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XML_ParserViewController;

@interface XML_ParserAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    XML_ParserViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet XML_ParserViewController *viewController;

@end

