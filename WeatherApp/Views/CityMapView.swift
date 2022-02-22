//
//  CityMapView.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 13/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

struct CityMapView: View {
    let city: String
    let latitude: Double
    let longitude: Double
    
    var body: some View {
        MapView(city: self.city, latitude: self.latitude, longitude: self.longitude)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView: UIViewRepresentable {
    var city: String
    var latitude: Double
    var longitude: Double
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Mark on the map
        let annotation = MKPointAnnotation()
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        
        annotation.coordinate = coordinates
        annotation.title = city
        
        uiView.addAnnotation(annotation)
        
    }
}

