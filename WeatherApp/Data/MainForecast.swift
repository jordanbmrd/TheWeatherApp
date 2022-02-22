//
//  MainForecast.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import Foundation
import SwiftUI

struct ForecastWeatherResponse: Decodable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [MainForecastParams]?
    var city: City?
}

struct MainForecastParams: Decodable {
    var dt: Double?
    var main: Main?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var pop: Float?
    var sys: Sys?
    var dt_txt: String?
}

struct Main: Decodable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Double?
    var sea_level: Double?
    var grnd_level: Double?
    var humidity: Int?
    var temp_kf: Float?
}

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Clouds: Decodable {
    var all: Int?
}

struct Wind: Decodable {
    var speed: Float?
    var deg: Int?
}

struct Sys: Decodable {
    var pod: String?
}

struct City: Decodable {
    var id: Double?
    var name: String?
    var coord: Coord?
    var country: String?
    var population: Double?
    var timezone: Double?
    var sunrise: Double?
    var sunset: Double?
}

struct Coord: Decodable {
    var lat: Double?
    var lon: Double?
}
