//
//  ObservableSubject.m
//  EndlessRunnerProject
//
//  Created by Craig Fortune on 26/02/2013.
//
//

#import "ObservableSubject.h"

@implementation ObserverData
@end

@implementation ObservationController

/**
 Class method initialisation
 **/
+ (id) initWithProtocol:(Protocol*)protocol andParent:(id<ObservationSubject>)parentObj
{
    ObservationController* obsController = [[[ObservationController alloc] initWithProtocol:protocol andParent:parentObj] autorelease];
    return obsController;
}

/**
 Simple initialisation to store the protocol and setup the array
 which stores the Observers
 **/
- (id) initWithProtocol:(Protocol*)protocol andParent:(id<ObservationSubject>)parentObj
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
 in the Subject that the subject decides to notify.
 The Observer must adhere to the protocol that the Subject specifies.
 **/
- (BOOL) registerAsObserver:(id<Observer>)obj
{
    // Object already Observer, ignore.
    if([self.observersArr containsObject:obj])
        return NO;
    
    // Object doesn't conform to the protocol, so isn't a valid Observer
	if(![obj conformsToProtocol:self.protocolToAdhereTo])
		return NO;
	
    // Everything checks out - add as an Observer
	ObserverData* obsData = [[[ObserverData alloc] init] autorelease];
	obsData.object = obj;
	
	[self.observersArr addObject:obsData];	
	return YES;
}

/**
 UnRegistering an object means it will no longer be aware of
 any changes in the Subject.
 **/
- (BOOL) unRegisterAsObserver:(id<Observer>)obj
{
    // Check if the object is in the Observer array
	for(ObserverData* obsData in self.observersArr)
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
 The ObserverController requests the Subject object to do the
 actual notifications and passes the Observer object within
 an ObserverData object.
 A subject must implement the "doNotification:" method.
 **/
- (void) notifyObservers
{
	for(ObserverData* obsData in self.observersArr)
	{
		[self.parent doNotification:obsData];
	}
}

@end
