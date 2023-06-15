//
//  MidView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct MidView: View {
    @State var actualPage = 1
    @Binding var isMapSheetOpen: Bool
    @ObservedObject var forecastViewModel: ForecastViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack{
            ZStack{
                UrlImageView(urlString: "http://openweathermap.org/img/wn/\(self.forecastViewModel.currentIcon)@2x.png", width: 150)
                
                HStack{
                    Text(self.forecastViewModel.temperature)
                        .bold()
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                    
                    Text(self.forecastViewModel.weatherDescription)
                        .foregroundColor(hexColor(0xeeeeee))
                        .opacity(0.8)
                }.padding(.top, 160)
                    .frame(width: UIScreen.main.bounds.width)
            }
            
            Button(action: {
                self.isMapSheetOpen = true
                print(ContentView().isMapSheetOpen)
            }){
                Text("📍 \(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)")
                    .font(.headline)
                    .foregroundColor(hexColor(0xeeeeee))
            }
            
            VStack(alignment: .center, spacing: 20){
                
                ZStack {
                    // First Page
                    VStack(alignment: .center, spacing: 20){
                        HStack(alignment: .center, spacing: 30){
                            
                            VStack{
                                Image(systemName: "wind")
                                Text("Vent")
                                    .bold()
                                Text(self.forecastViewModel.wind)
                            }
                            VStack{
                                Image(systemName: "cloud.drizzle")
                                Text("Humidité")
                                    .bold()
                                Text(self.forecastViewModel.humidity)
                            }
                            VStack{
                                Image(systemName: "thermometer")
                                Text("Max")
                                    .bold()
                                Text(self.forecastViewModel.maxTemperature)
                            }
                            
                        }
                        HStack(alignment: .center, spacing: 30){
                            VStack{
                                Image(systemName: "sunrise")
                                Text("Lever")
                                    .bold()
                                Text(self.forecastViewModel.sunrise)
                            }
                            VStack{
                                Image(systemName: "sunset")
                                Text("Coucher")
                                    .bold()
                                Text(self.forecastViewModel.sunset)
                            }
                        }
                        
                    }.padding(.top, 60)
                        .padding(.bottom, 10)
                        .foregroundColor(hexColor(0xeeeeee))
                        .opacity((self.actualPage == 1) ? 0.8 : 0)
                        .animation(.spring())
                    
                    // Second Page
                    VStack(alignment: .center, spacing: 25){
                        HStack(alignment: .center, spacing: 45){
                            
                            VStack{
                                Image(systemName: "gauge")
                                Text("Pression")
                                    .bold()
                                Text(self.forecastViewModel.pressure)
                            }
                            
                            VStack{
                                Image(systemName: "cloud")
                                Text("Opacité")
                                    .bold()
                                Text(self.forecastViewModel.opacity)
                            }
                            
                        }
                        
                        HStack(alignment: .center, spacing: 30){
                            
                            VStack{
                                Image(systemName: "cloud.heavyrain")
                                Text("Probabilité de")
                                    .bold()
                                Text("précipitation")
                                    .bold()
                                Text(self.forecastViewModel.pop)
                            }
                            
                        }
                        
                    }.padding(.top, 60)
                        .padding(.bottom, 10)
                        .foregroundColor(hexColor(0xeeeeee))
                        .opacity((self.actualPage == 2) ? 0.8 : 0)
                        .animation(.spring())
                    
                }.gesture(DragGesture()
                
                    .onChanged({ (value) in
                        
                        if self.actualPage == 2 {
                            if value.translation.width > 0 && value.translation.width > 30 {
                                self.actualPage = 1
                            }
                        } else if self.actualPage == 1 {
                            if value.translation.width < 0 && value.translation.width < -30 {
                                self.actualPage = 2
                            }
                        }
                        
                    })
                    
                )
                
                // Page Indication
                HStack(alignment: .center, spacing: 15) {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: (self.actualPage == 1) ? 15 : 10, height: (self.actualPage == 1) ? 15 : 10)
                        .foregroundColor((self.actualPage == 1) ? hexColor(0x22a7f0) : hexColor(0xe4e9ed))
                        .shadow(radius: 0.5)
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: (self.actualPage == 2) ? 15 : 10, height: (self.actualPage == 2) ? 15 : 10)
                        .foregroundColor((self.actualPage == 2) ? hexColor(0x22a7f0) : hexColor(0xe4e9ed))
                        .shadow(radius: 0.5)
                }
            }
            
            Spacer()
        }
    }
}
