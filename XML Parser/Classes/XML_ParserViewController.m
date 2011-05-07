//
//  XML_ParserViewController.m
//  XML Parser
//
//  Created by Evan Johnson on 4/27/11.
//  Copyright 2011 Boniface Designs. All rights reserved.
//

#import "XML_ParserViewController.h"

@implementation XML_ParserViewController

@synthesize receivedData;
@synthesize label;
@synthesize parseData;

#pragma mark -
#pragma mark NSURLRequest

- (IBAction)parseData:(id)sender
{
	if (receivedData) {
		receivedData = nil;
	}
	label.text = @"Parsing data...";
	// Request data from URL
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.bonifacedesigns.com/tuts/xmltest.xml"]]
												cachePolicy:NSURLRequestUseProtocolCachePolicy
											timeoutInterval:60.0];
	
	// Start loading data
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) 
	{
		// Create the NSMutableData to hold the received data
		receivedData = [[NSMutableData data] retain];
	} else 
	{
		// Inform the user the connection failed.
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// Rest the data length if the server reloads
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if (receivedData) 
	{
		// Append the new data to receivedData
		[receivedData appendData:data];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Release the connection, and the data object
	[connection release];
	[receivedData release];
	
	// Inform the user
	NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
	
	label.text = @"Connection failed!";
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSLog(@"Succeeded! Received %d bytes of data", [receivedData length]);
	
	// Do something with the data
	// Send data to parser
	[self startParsingData];
	// Release the connection
	[connection release];
}

#pragma mark -
#pragma mark NSXMLParser

- (void)startParsingData
{
	NSLog(@"parser started");
	// allocate NSXMLParser
	NSXMLParser *dataParser = [[NSXMLParser alloc] initWithData:receivedData];
	// assign delegate to parser
	dataParser.delegate = self;
	// parse data
	[dataParser parse];
	// release parser
	[dataParser release];
	// release data
	[receivedData release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	NSLog(@"Parser was called");
	
	// only parse xml elements with the name element (optional)
	if ([elementName isEqualToString:@"element"])
	{
		NSLog(@"myData equals %@", [attributeDict objectForKey:@"myData"]);
		
		// grab xml variable myData using attributeDict and objectForKey
		NSString *myData = [NSString stringWithFormat:@"%@", [attributeDict objectForKey:@"myData"]];
		// You can now use the sring myData as you please =)
		// I assign the parsed data to my UILabel - label should change on screen.
		label.text = myData;
	}
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"Parsing error");
	label.text = @"Parsing error!";
	
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#pragma mark -
#pragma mark View Controller Methods

- (void)viewDidLoad {
	

	
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
