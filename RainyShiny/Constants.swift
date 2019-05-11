//
//  File.swift
//  RainyShiny
//
//  Created by Seif Elmosalamy on 5/9/19.
//  Copyright © 2019 Seif Elmosalamy. All rights reserved.
//

import Foundation
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "e39ea3e5aa61838115e557975194674b"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.sharedInstance.latitude!)&lon=\(location.sharedInstance.longitude!)&appid=42a1771a0b787bf12e734ada0cfc80cb"
let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.sharedInstance.latitude!)&lon=\(location.sharedInstance.longitude!)&cnt=10&appid=42a1771a0b787bf12e734ada0cfc80cb"
