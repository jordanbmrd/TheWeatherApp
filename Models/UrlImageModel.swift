//
//  UrlImageModel.swift
//  WeatherApp
//
//  Created by Jordan Baumard on 05/05/2020.
//  Copyright © 2020 Jordan Baumard. All rights reserved.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject{
    @Published var image: UIImage?
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        loadImageFromUrl()
    }
    
    func loadImageFromUrl(){
        guard let urlString = urlString else{return}
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
        
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else{
            print("Error: \(error!)")
            return
        }
        guard let data = data else{
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else{
                return
            }
            
            self.image = loadedImage
        }
    }
}
