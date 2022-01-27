//
//  dataParsing.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//

import Foundation

class FetchData : ObservableObject{
    @Published var responses = Response()
    //this part is copy and pasted from another JSON file, I just changed the url.
    init(){
        
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=c6a8b99c194944a5bf0162452211612&q=19066&days=3&aqi=yes&alerts=no")!
        
        URLSession.shared.dataTask(with: url) { (data, response, errors) in
            
            guard let data = data else {return}
            
            
            
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responses = response
                }
            }
            
            
        }.resume()
        
        //kinda just shows if the code is running. I'm leaving this in because I'm used to it
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
    var forecastday: [Forecastday] = [Forecastday(), Forecastday(), Forecastday()]
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

//structs for geocoding
struct Recived : Codable{
    var result : Result = Result()
}
struct Result : Codable{
    var addressMatches : [AddressMatches] = [AddressMatches()]
}
struct AddressMatches : Codable{
    var coordinates : Coordinates = Coordinates()
}
struct Coordinates : Codable{
    var x : Float = 0
    var y : Float = 0
}
//end of geocoding structs
//structs for weather decoding
struct WResponse : Codable {
    var properties : Properties = Properties()
}
struct Properties: Codable{
    var forecast : String = "link"
    var forecastHourly : String = "link"
}
//end of weather structs
//structs for daily forecast decoding
struct DForecast : Codable {
    var properties : FDProperties = FDProperties()
    
}
struct FDProperties: Codable{
    var periods = Array(repeating: DPeriods(), count : 14)//intiilizes with the count it will have post decode
}
struct DPeriods : Codable{
    var number : Int = 0
    var name : String = ""
    var startTime : String = ""
    var endTime : String = ""
    var isDaytime : Bool?
    var temperature : Int = 0
    var temperatureUnit : String = ""
    var windSpeed : String = ""
    var windDirection : String = ""
    var icon : String = ""
    var shortForecast : String = ""
    var detailedForecast : String = ""
}
//end of daily forecast structs
//structs for hourly forecast decoding
struct HForecast : Codable {
    var properties : FHProperties = FHProperties()
    
}
struct FHProperties: Codable{
    var periods  = Array(repeating: HPeriods(), count : 156)//intiilizes with the count it will have post decode
}
struct HPeriods : Codable{
    var number : Int = 0
    var name : String = ""
    var startTime : String = ""
    var endTime : String = ""
    var isDaytime : Bool = true
    var temperature : Int = 0
    var temperatureUnit : String = ""
    var windSpeed : String = ""
    var windDirection : String = ""
    var icon : String = ""
    var shortForecast : String?
    var detailedForecast : String = ""
}
//end of daily forecast structs

//marked for merge

