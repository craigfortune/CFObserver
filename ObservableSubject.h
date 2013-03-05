//
//  ObservableSubject.h
//  EndlessRunnerProject
//
//  Created by Craig Fortune on 26/02/2013.
//
//

#import <Foundation/Foundation.h>

@class ObservationController;
@class ObserverData;

/**
 Provides a base protocol to treat all Observer objects by
 Any ObservationSubject classes you create will typically have
 a matching protocol that a derivation of Observer.
 This affords the opportunity to have custom messages for the
 notification call to Observer objects
 **/
@protocol Observer <NSObject>
@end

/**
 Any class that wants to be observable should adhere to this
 protocol. This is how we have a reliable interface to code against
 without artifical multiple inheritance or message forwarding
 **/
@protocol ObservationSubject <NSObject>
@property (retain) ObservationController* observationController;
- (void) doNotification:(ObserverData*)obsData;
@end

/**
 A simple class for encapsulating data about an Observer object.
 **/

@interface ObserverData : NSObject
@property (retain) id object;
@end

/**
 The ObservationController is the class that handles registering
 and unregistering of Observers as well as sending out 
 notifications from the Subject object.
 **/

@interface ObservationController : NSObject

@property (retain) NSMutableArray* observersArr;
@property (assign) id<ObservationSubject> parent;
@property (assign) Protocol* protocolToAdhereTo;

+ (id) initWithProtocol:(Protocol*)protocol andParent:(id<ObservationSubject>)parentObj;
- (id) initWithProtocol:(Protocol*)protocol andParent:(id<ObservationSubject>)parentObj;


- (BOOL) registerAsObserver:(id<Observer>)obj;
- (BOOL) unRegisterAsObserver:(id<Observer>)obj;
- (void) notifyObservers;

@end
