//
//  dataParsing.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//

import Foundation

class FetchData : ObservableObject{
    @Published var responses = Response()
    
    init(){
        
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=c6a8b99c194944a5bf0162452211612&q=19066&days=1&aqi=no&alerts=no")!
        
        URLSession.shared.dataTask(with: url) { (data, response, errors) in
            
            guard let data = data else {return}
            
            
            
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responses = response
                }
            }
            
            
        }.resume()
        
        print(responses.current.condition)
        print(responses.current.temp_f)
    }
}
struct Response: Codable{
    var current : Current = Current()
}

struct Current: Codable{
    var temp_f : Float = 0
    var condition : [Condition] = [Condition]()
}

struct Condition: Codable{
    var text : String
    var icon : String
}

