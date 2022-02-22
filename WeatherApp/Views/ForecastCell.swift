//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct ForecastCell: View {
    let forecastData: MainForecastParams
    
    var minTemp: String{
        if let minTemp = forecastData.main?.temp_min {
            return "\(minTemp)°"
        } else {
            return ""
        }
    }
    
    var maxTemp: String{
        if let maxTemp = forecastData.main?.temp_max {
            return "\(maxTemp)°"
        } else {
            return ""
        }
    }
    
    var humidity: String{
        if let humidity = forecastData.main?.humidity {
            return "\(humidity)%"
        } else {
            return ""
        }
    }
    
    var wind: String{
        if let wind = forecastData.wind?.speed {
            return "\(wind)m/s"
        } else {
            return ""
        }
    }
    
    var icon: String{
        if let icon = forecastData.weather?.first?.icon {
            return icon
        } else {
            return ""
        }
    }
    
    var formattedHour: String{
        let hour = Helper().hourFormatter(timeStamp: Int(forecastData.dt!))
        
        switch hour {
        case "00:00":
            return "Minuit"
        case "12:00":
            return "Midi"
        default:
            return hour
        }
    }
    
    var ressenti: String{
        if let ressenti = forecastData.main?.feels_like {
            return "\(ressenti)°"
        } else {
            return ""
        }
    }
    
    var body: some View {
        Group{
            VStack{
                HStack{
                    UrlImageView(urlString: "http://openweathermap.org/img/wn/\(self.icon)@2x.png", width: 80)
                    .frame(width: 50, height: 50)
                    
                    VStack{
                        Text(formattedHour)
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(Helper().dateFormatter(timeStamp: Int(forecastData.dt!)))
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }.frame(width: 60)
                }
                
                VStack{
                    VStack(spacing: 3){
                        Text("Ressenti:")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        HStack{
                            Image(systemName: "thermometer")
                                .foregroundColor(.black)
                            Text(ressenti)
                                .foregroundColor(.black)
                                .lineLimit(0)
                        }
                    }
                    
                    VStack{
                        Text("Hum:")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Text(humidity)
                            .foregroundColor(.black)
                    }
                    
                    VStack{
                        Text("Vent:")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Text(wind)
                            .foregroundColor(.black)
                    }
                }
            }
        }.padding(.all, 20)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 8)
    }
}
