//
//  CFObserver.m
//
//  Created by Craig Fortune on 26/02/2013.
//

#import "CFObserver.h"

@implementation CFObserverData
@end

@implementation CFObservationController

/**
 Class method initialisation
 **/
+ (id) initWithProtocol:(Protocol*)protocol andParent:(id<CFObservationSubject>)parentObj
{
    CFObservationController* obsController = [[[CFObservationController alloc] initWithProtocol:protocol andParent:parentObj] autorelease];
    return obsController;
}

/**
 Simple initialisation to store the protocol and setup the array
 which stores the CFObservers
 **/
- (id) initWithProtocol:(Protocol*)protocol andParent:(id<CFObservationSubject>)parentObj
{
	if((self = [super init]))
	{
        self.protocolToAdhereTo = protocol;
        self.parent = parentObj;
		self.observersArr = [NSMutableArray arrayWithCapacity:3];
	}
	
	return self;
}

/**
 Registering an object causes it to be made aware of any changes
 in the CFObservationSubject that the subject decides to notify.
 The CFObserver must adhere to the protocol that the CFObservationSubject specifies.
 **/
- (BOOL) registerAsObserver:(id<CFObserver>)obj
{
    // Object already Observer, ignore.
    if([self.observersArr containsObject:obj])
        return NO;
    
    // Object doesn't conform to the protocol, so isn't a valid Observer
	if(![obj conformsToProtocol:self.protocolToAdhereTo])
		return NO;
	
    // Everything checks out - add as an Observer
	CFObserverData* obsData = [[[CFObserverData alloc] init] autorelease];
	obsData.object = obj;
	
	[self.observersArr addObject:obsData];	
	return YES;
}

/**
 UnRegistering an object means it will no longer be aware of
 any changes in the CFObservationSubject.
 **/
- (BOOL) unRegisterAsObserver:(id<CFObserver>)obj
{
    // Check if the object is in the Observer array
	for(CFObserverData* obsData in self.observersArr)
	{
        // Object found. Remove it.
		if(obsData.object == obj)
		{
			[self.observersArr removeObject:obsData];
			return YES;
		}
	}
	
    // Couldn't find it...
	return NO;
}

/**
 The CFObserverController requests the CFObservationSubject object to do the
 actual notifications and passes the CFObserver object within
 an CFbserverData object.
 A subject must implement the "doNotification:" method.
 **/
- (void) notifyObservers
{
	for(CFObserverData* obsData in self.observersArr)
	{
		[self.parent doNotification:obsData];
	}
}

@end
