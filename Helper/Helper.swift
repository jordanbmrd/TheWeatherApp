//
//  Helper.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation
import Alamofire

struct Helper {
    
    func timeConverter(timeStamp: Int, isDay: Bool) -> String {
        let unixTimestamp = timeStamp
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale(identifier: "FR_fr")
        dateFormatter.dateFormat = isDay ? "EEEE" : "EEEE d MMM, yyyy"
        
        return dateFormatter.string(from: date).capitalized(with: .current)
    }
    
    func hourFormatter(timeStamp: Int) -> String {
        let unixTimestamp = timeStamp
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func dateFormatter(timeStamp: Int) -> String {
        let unixTimestamp = timeStamp
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM"
        
        return dateFormatter.string(from: date)
    }
    
}

//MARK: Hex Color

prefix operator ⋮
prefix func ⋮(hex:UInt32) -> Color {
    return Color(hex)
}

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let hexColor:(UInt32) -> (Color) = {
    return Color($0)
}

//MARK: Internet Connectivity

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
