//
//  CFObserver.h
//
//  Created by Craig Fortune on 26/02/2013.
//

#import <Foundation/Foundation.h>

@class CFObservationController;
@class CFObserverData;

/**
 Provides a base protocol to treat all CFObserver objects by
 Any CFObservationSubject classes you create will typically have
 a matching protocol that a derivation of CFObserver.
 This affords the opportunity to have custom messages for the
 notification call to CFObserver objects
 **/
@protocol CFObserver <NSObject>
@end

/**
 Any class that wants to be observable should adhere to this
 protocol. This is how we have a reliable interface to code against
 without artifical multiple inheritance or message forwarding
 **/
@protocol CFObservationSubject <NSObject>
@property (retain) CFObservationController* observationController;
- (void) doNotification:(CFObserverData*)obsData;
@end

/**
 A simple class for encapsulating data about an Observer object.
 **/

@interface CFObserverData : NSObject
@property (retain) id object;
@end

/**
 The CFObservationController is the class that handles registering
 and unregistering of Observers as well as sending out 
 notifications from the Subject object.
 **/

@interface CFObservationController : NSObject

@property (retain) NSMutableArray* observersArr;
@property (assign) id<CFObservationSubject> parent;
@property (assign) Protocol* protocolToAdhereTo;

+ (id) initWithProtocol:(Protocol*)protocol andParent:(id<CFObservationSubject>)parentObj;
- (id) initWithProtocol:(Protocol*)protocol andParent:(id<CFObservationSubject>)parentObj;


- (BOOL) registerAsObserver:(id<CFObserver>)obj;
- (BOOL) unRegisterAsObserver:(id<CFObserver>)obj;
- (void) notifyObservers;

@end
