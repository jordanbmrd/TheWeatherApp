//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 05/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var isConnected: Bool
    @State var showView: Bool = false
    @State var isMapSheetOpen: Bool = false
    @ObservedObject var forecastViewModel: ForecastViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    
    init() {
        self.forecastViewModel = ForecastViewModel()
        self.locationViewModel = LocationViewModel()
        self.isConnected = Connectivity.isConnectedToInternet()
    }
    
    var body: some View {
        
        
        ZStack(){
            ZStack(alignment: .bottom){
                ScrollView(.vertical, showsIndicators: false){
                    ZStack(alignment: .bottom){
                        BackSplash(colorTop: self.forecastViewModel.cityColorTop, colorBottom: self.forecastViewModel.cityColorBottom).edgesIgnoringSafeArea(.all)
                        
                        VStack{
                            TopView(showField: self.showView, forecastViewModel: self.forecastViewModel, locationViewModel: locationViewModel)
                                .padding(.top, 50)
                            
                            MidView(isMapSheetOpen: self.$isMapSheetOpen, forecastViewModel: forecastViewModel, locationViewModel: locationViewModel)
                            
                            BottomView(forecastViewModel: forecastViewModel)
                            
                            Spacer()
                        }
                    }
                }.edgesIgnoringSafeArea(.all)
                    .animation(.spring())
                
                // Bottom Sheet Map
                BottomSheetModal(forecastViewModel: self.forecastViewModel, display: self.$isMapSheetOpen){
                    MapView(city: "\(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)", latitude: self.forecastViewModel.coordinates[0], longitude: self.forecastViewModel.coordinates[1])
                }
                .animation(.spring())
            }.opacity(isConnected ? 1 : 0)
            
            NoInternetView(colorTop: self.forecastViewModel.cityColorTop, colorBottom: self.forecastViewModel.cityColorBottom)
                .opacity(isConnected ? 0 : 1)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
