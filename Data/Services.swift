//
//  Services.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import Foundation

class Services {
    
    let apiID = "36e056e75c7119fe526a5094d8e15f11"
    var updatedCity: String = "Le Mans"
    
    //MARK: OpenWeatherMap API
    func getWeatherData(city: String, completion: @escaping (ForecastWeatherResponse?)->()){
        
        if city.contains(" ") {
        	updatedCity = city.replacingOccurrences(of: " ", with: "%20")
        } else {
            updatedCity = city
        }
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?appid=\(apiID)&q=\(updatedCity)&units=metric&lang=fr") else {
            completion(nil)
            print("Couldn't get access to link.")
            return
    	}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                print("Error with data : \(String(describing: error?.localizedDescription))")
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                completion(weatherResponse)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
