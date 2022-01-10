//
//  ContentView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var f = FetchData()
    
    var body: some View {
        VStack{
            VStack{
                Text("Forcast for the day")
                Text("condition: \(f.responses.current.condition?.text ?? "")")
                Text("temp: \(f.responses.current.temp_f)")
            }
            .frame(width: 240, height: 120, alignment: .center)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            NavigationView{
                List(f.responses.forecast.forecastday[0].hour){h in
                    NavigationLink(destination: detailedView(info: makeItUsable(time: h.time, temp_f: h.temp_f, condition: h.condition, wind_mph: h.wind_mph, feelslike_f: h.feelslike_f)), label: {
                        listView(usable: makeItUsableLight(time: h.time, temp_f: h.temp_f, condition: h.condition))
                        
                    })
                    
                    
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//anger
