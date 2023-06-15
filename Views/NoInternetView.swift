//
//  NoInternetView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 14/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct NoInternetView: View {
    @State var colorTop: String
    @State var colorBottom: String
    
    var body: some View {
        ZStack(){
            BackSplash(colorTop: self.colorTop, colorBottom: self.colorBottom)
        	VStack(){
            	Image(systemName: "wifi.exclamationmark")
                	.resizable()
                    .foregroundColor(Color.gray)
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(.bottom, 20)
            	Text("Vous ne semblez pas connecté à Internet...")
        	}
        }.edgesIgnoringSafeArea(.all)
    }
}
