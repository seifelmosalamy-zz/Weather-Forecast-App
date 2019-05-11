//
//  Location.swift
//  RainyShiny
//
//  Created by Seif Elmosalamy on 5/11/19.
//  Copyright © 2019 Seif Elmosalamy. All rights reserved.
//

import CoreLocation

class location {

    static var sharedInstance = location()
    private init() {}

    var latitude:Double!
    var longitude:Double!
    
}
