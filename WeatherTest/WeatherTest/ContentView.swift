//
//  ContentView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//
import SwiftUI

struct ContentView: View {
    @StateObject var fetch = FetchData()
    
    var body: some View {
        VStack{
            //Shows the forcast for the day at the top of the screen on each screen
            VStack{
                //Text for forcast for the day
                Text("Forcast for the day")
                
                //Creates the condition using optional incase there is no condition where it shows nothing
                Text("condition: \(fetch.responses.current.condition?.text ?? "")")
                
                //Displays the temperature in fahrenheit
                Text("temp: \(fetch.responses.current.temp_f) fahrenheit")
            }
            .frame(width: 240, height: 120, alignment: .center)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            
        
            NavigationView{
                //Creates the list for displaying the temperature, condition and wind through the hours of the day
                List(fetch.responses.forecast.forecastday[0].hour){h in
                    NavigationLink(destination: detailedView(info: makeItUsable(time: h.time, temp_f: h.temp_f, condition: h.condition, wind_mph: h.wind_mph, feelslike_f: h.feelslike_f)), label: {
                        listView(usable: makeItUsableLight(time: h.time, temp_f: h.temp_f, condition: h.condition))
                        
                    })
                }
            }
        }
    }
}
