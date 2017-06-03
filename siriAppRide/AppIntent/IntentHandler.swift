//
//  IntentHandler.swift
//  AppIntent
//
//  Created by Bhatt, Rushi on 5/31/17.
//  Copyright © 2017 rushi. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INRequestRideIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    func handle(requestRide intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        print("handle")
        
        let status = INRideStatus()
        status.rideIdentifier = "Unique ID generated by your ride App"
        status.estimatedPickupDate = Date()
        status.estimatedDropOffDate = Date(timeInterval: 5000, since: status.estimatedPickupDate!)
        status.driver = INRideDriver(phoneNumber: "9842029667", nameComponents: nil, displayName: "Rushi", image: nil, rating: "4.8")
        status.vehicle = INRideVehicle()
        status.phase = INRidePhase.approachingPickup
        
        let activity:NSUserActivity = NSUserActivity(activityType: "Ride")
        activity.userInfo  = ["driver": status.driver!.displayName,
                              "phone": status.driver!.phoneNumber!]
        
        
        let response = INRequestRideIntentResponse(code: .success, userActivity: activity)
        response.rideStatus = status
        completion(response)
        
    }
    
    func resolvePartySize(forRequestRide intent: INRequestRideIntent, with completion: @escaping (INIntegerResolutionResult) -> Void) {
        print("Resolve party size")
        completion(INIntegerResolutionResult.success(with: 1))
        
    }
    
    func resolvePickupLocation(forRequestRide intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        print("Resolve pick up location")
        if let pickup = intent.pickupLocation {
            completion(INPlacemarkResolutionResult.success(with: pickup))
        }
        else{
            completion(INPlacemarkResolutionResult.needsValue())
        }
        
    }
    
    func resolveDropOffLocation(forRequestRide intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        print("Resolve drop off location")
        if let dropoff = intent.dropOffLocation {
            completion(INPlacemarkResolutionResult.success(with: dropoff))
        }
        else{
            completion(INPlacemarkResolutionResult.needsValue())
        }
    }
}

