//
//  XML_ParserViewController.h
//  XML Parser
//
//  Created by Evan Johnson on 4/27/11.
//  Copyright 2011 Boniface Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XML_ParserViewController : UIViewController <NSXMLParserDelegate> {
	
	NSMutableData *receivedData;
	IBOutlet UILabel *label;

}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) IBOutlet UILabel *label;

@end

