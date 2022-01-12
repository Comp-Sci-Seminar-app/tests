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
        
        //kinda just shows if the code is runnign
        print(responses.current.temp_f)
    }
}

//ALL THE PARSING!!!!!!!!
struct Response: Codable{
    var current : Current = Current()
    var forecast: Forecast = Forecast()
    var location: Location = Location()
}

struct Location: Codable{
    var localtime : String = "2022-01-04 7:58"
}

struct Current: Codable{
    var temp_f : Double = 0
    var temp_c : Double = 0
    var condition : Condition?
}
struct Condition: Codable{
    var text : String
    var icon : String
    var code : Int
}

struct Forecast: Codable{
    var forecastday: [Forecastday] = [Forecastday()]
}

//If I don't have a default of 24 hours the forEach gets angry and only displays 1 hour even when it gets api data.
struct Forecastday: Codable{
    var day : Day = Day()
    var hour : [Hour] = [Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour(), Hour()]
}

struct Day: Codable{
    var maxtemp_f : Double = 0
    var mintemp_f : Double = 0
    var avgtemp_f : Double = 0
    var condition : Condition?
}

struct Hour: Codable{
    var time : String = "2022-01-04 00:00"
    var temp_f : Double = 0
    var condition : Condition?
    var wind_mph : Double = 0
    var feelslike_f : Double = 0
}
extension Hour: Identifiable{
    var id: String {return time}
}
//new branch
