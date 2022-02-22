//
//  BottomView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct BottomView: View {
    @ObservedObject var forecastViewModel: ForecastViewModel
    let miScreenWidth = UIScreen.main.bounds.width / 3
    
    var body: some View {
        VStack{
        	Text("Prévisions météo")
            	.foregroundColor(.white)
        		.bold()
            	.padding(.top, 40)
                .padding(.bottom, 20)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .center, spacing: 30){
                    ForEach(forecastViewModel.getForecastList(), id: \.dt){ forecast in
                        
                        GeometryReader{ geometry in
                        	ForecastCell(forecastData: forecast)
                                .animation(.spring())
                                .rotation3DEffect(Angle(degrees:
                                    (Double(geometry.frame(in: .global).minX) - Double(self.miScreenWidth))/(-20)
                                    ), axis: (x: 0, y: 10, z: 0))
                        }.frame(width: 140, height: 240)
                        
                    }
                }
            }.padding(.all, 25)
            Spacer()
            
            VStack{
                Text("Les informations personnelles (localisation) utilisées sur l'application ne sont pas collectées ni revendues.")
                .foregroundColor(hexColor(0xeeeeee))
                .opacity(0.8)
                .font(.subheadline)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .lineLimit(nil)
                .frame(height: 100)
            }
        }
    }
}
