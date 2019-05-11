//
//  Forecast.swift
//  RainyShiny
//
//  Created by Seif Elmosalamy on 5/11/19.
//  Copyright © 2019 Seif Elmosalamy. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class Forecast {

    var _date: String!
    var _weatherType: String!
    var _Hightemp: String!
    var _Lowtemp: String!


    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

        var date:String {
            if _date == nil {
                _date = ""
            }
            return _date
    }
        var lowTemp:String {
            if _Lowtemp == nil {
                _Lowtemp = ""
            }
            return _Lowtemp
    }
            var highTemp:String {
            if _Hightemp == nil {
                _Hightemp = ""
            }
            return _Hightemp

    }

    init(weatherDict: Dictionary<String , AnyObject>) {

        if let temp = weatherDict["temp"] as? Dictionary<String , AnyObject>{

            if let min = temp["min"] as? Double {

               
                let celsius = round((min-273.15))


                    self._Lowtemp = "\(celsius)"
            }

             if let max = temp["max"] as? Double {

                let celsius = round((max-273.15))

                self._Hightemp = "\(celsius)"
            }
      }


        if let weather = weatherDict["weather"] as? [Dictionary<String , AnyObject>]{
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
