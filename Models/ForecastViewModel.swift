//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import Combine
import SwiftUI

class ForecastViewModel: ObservableObject {
    var weatherService: Services!
    var cityName: String = "Le Mans"
    
    @Published var weatherForecast = ForecastWeatherResponse()
    
    init() {
        self.weatherService = Services()
    }
    
    var currentCity: String{
        if let city = self.weatherForecast.city?.name {
            return city
        } else {
            return ""
        }
    }
    
    var currentCountry: String{
        if let country = self.weatherForecast.city?.country {
            return country
        } else {
            return ""
        }
    }
    
    var currentIcon: String{
        if let icon = self.weatherForecast.list?.first?.weather?.first?.icon {
            return icon
        } else {
            return ""
        }
    }
    
    var weatherDay: String{
        if let day = self.weatherForecast.list?.first?.dt {
            let formattedDay = Helper().timeConverter(timeStamp: Int(day), isDay: false)
            
            return formattedDay
        } else {
            return ""
        }
    }
    
    var temperature: String{
        if let temp = self.weatherForecast.list?.first?.main?.temp {
            let formattedTemp = String(format: "%.0f", temp)
            return formattedTemp + "°"
        } else {
            return ""
        }
    }
    
    var weatherDescription: String{
        if let description = self.weatherForecast.list?.first?.weather?.first?.description {
            let formattedDesc = description.capitalized(with: .current)
            
            return formattedDesc
        } else {
            return ""
        }
    }
    
    var wind: String{
        if let wind = self.weatherForecast.list?.first?.wind?.speed {
            let formattedWind = "\(wind)m/s"
            
            return formattedWind
        } else {
            return ""
        }
    }
    
    var humidity: String{
        if let humidity = self.weatherForecast.list?.first?.main?.humidity {
            let formattedHumidity = "\(humidity)%"
            
            return formattedHumidity
        } else {
            return ""
        }
    }
    
    var maxTemperature: String{
        if let maxTemp = self.weatherForecast.list?.first?.main?.temp_max{
            let formattedTemperature = "\(maxTemp)°"
            
            return formattedTemperature
        } else {
            return ""
        }
    }
    
    var coordinates: [Double]{
        var toReturn: [Double] = []
        if let latitude = self.weatherForecast.city?.coord?.lat{
            toReturn.append(latitude)
        } else {
            toReturn.append(0)
        }
        if let longitude = self.weatherForecast.city?.coord?.lon{
            toReturn.append(longitude)
        } else {
            toReturn.append(0)
        }
        return toReturn
    }
    
    var cityColorTop: String{
        if Connectivity.isConnectedToInternet(){
        	if !self.currentIcon.hasSuffix("d") {
        		return "background2"
        	} else {
            	return "background7"
        	}
        } else {
            return "icons"
        }
    }
    
    var cityColorBottom: String{
        if Connectivity.isConnectedToInternet(){
        	if !self.currentIcon.hasSuffix("d") {
            	return "background3"
        	} else {
            	return "background6"
        	}
        } else {
            return "lightPurple"
        }
    }
    
    var sunrise: String{
        if let sunrise = self.weatherForecast.city?.sunrise {
            return Helper().hourFormatter(timeStamp: Int(sunrise))
        } else{
            return ""
        }
    }
    
    var sunset: String{
        if let sunset = self.weatherForecast.city?.sunset {
            return Helper().hourFormatter(timeStamp: Int(sunset))
        } else{
            return ""
        }
    }
    
    var pressure: String{
        if let pressure = self.weatherForecast.list?.first?.main?.pressure {
            return "\(pressure) hPa"
        } else {
            return ""
        }
    }
    
    var pop: String{
        if let pop = self.weatherForecast.list?.first?.pop {
            return "\(round(pop * 100))%"
        } else {
            return ""
        }
    }
    
    var opacity: String{
        if let opacity = self.weatherForecast.list?.first?.clouds?.all {
            return "\(opacity)%"
        } else {
            return ""
        }
    }
    
    
    //MARK: Functions
    
    func getForecastList() -> [MainForecastParams]{
        if let mList = self.weatherForecast.list {
            return mList
        } else {
            return []
        }
    }
    
    func searchCity(){
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            fetchWeatherForecast(by: city)
        }
    }
    
    func fetchWeatherForecast(by city: String){
        self.weatherService.getWeatherData(city: cityName){
            forecast in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    self.weatherForecast = forecast
                }
            }
        }
    }
}
