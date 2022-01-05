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
        
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=ADDYOURKEYHERE=no")!
        
        URLSession.shared.dataTask(with: url) { (data, response, errors) in
            
            guard let data = data else {return}
            
            
            
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responses = response
                }
            }
            
            
        }.resume()
        
        //print(responses.current.condition ?? "")
        print(responses.current.temp_f)
    }
}
struct Response: Codable{
    var current : Current = Current()
    var forecast: Forecast = Forecast()
}

struct Current: Codable{
    var temp_f : Float = 0
    var temp_c : Float = 0
    var condition : Condition?
}
struct Condition: Codable{
    var text : String
    var icon : String
}

struct Forecast: Codable{
    var forecastday: [Forecastday] = [Forecastday()]
}
struct Forecastday: Codable{
    var day : Day = Day()
    var hour : [Hour] = [Hour(), Hour()]
}

struct Day: Codable{
    var maxtemp_f : Float = 0
    var mintemp_f : Float = 0
    var avgtemp_f : Float = 0
    var condition : Condition?
}

struct Hour: Codable{
    var time : String = "2022-01-04 00:00"
    var temp_f : Float = 0
    var condition : Condition?
    var wind_mph : Float = 0
    var feelslike_f : Float = 0
}
extension Hour: Identifiable{
    var id: String {return time}
}
