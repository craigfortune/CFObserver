CFObserver
==========

CFObserver is a collection of classes for implementing the Observer Pattern in Objective C. The classes are hinged around the CFObserverController which performs the main logic.

With CFObserver you are not limited to a simple update: method, you can define whatever method you wish to be called by the Subject of the observation on the Observers. This gives a much greater level of flexibility and usefulness to the pattern.

Classes that Observe need to adhere to the protocol CFObserver protocol (or more precisely, a derivation of it) and Subjects of observation need to adhere to the CFObservationSubject protocol and hold a member variable of a CFObservationControler object.

<b>No inheritance is required - everything is done via protocols and is very flexible!</b>
