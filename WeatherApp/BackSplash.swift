//
//  BackSplash.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 05/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct BackSplash: View {
    var colorTop: String = "lightPink"
    var colorBottom: String = "lightBlue"
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color(self.colorTop), Color(self.colorBottom)]), startPoint: .top, endPoint: .bottom))
    }
}
