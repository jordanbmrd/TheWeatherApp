//
//  UrlImageView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 06/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    var width: Float
    
    init(urlString: String?, width: Float?) {
        urlImageModel = UrlImageModel(urlString: urlString)
        self.width = width ?? 150
    }
    var body: some View{
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
        	.scaledToFit()
            .frame(width: CGFloat(self.width))
    }
    
    static var defaultImage = UIImage(named: "defaultImage")
}
