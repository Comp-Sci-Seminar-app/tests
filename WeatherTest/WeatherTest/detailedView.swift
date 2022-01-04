//
//  detailedView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI

struct detailedView: View {
    var info : makeItUsable
    
    
    var body: some View {
        let rawTime = info.time
        VStack{
            Text(info.condition?.text ?? "API error")
            Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
            Text("Temperature: \(info.temp_f) fahrenheit")
            Text("Feels like: \(info.feelslike_f) fahrenheit")
            Text("Wind MPH: \(info.wind_mph)")
        }
    }
}

class makeItUsable{
    var time : String
    var temp_f : Float
    var condition : Condition?
    var wind_mph : Float
    var feelslike_f : Float
    
    init(time: String = "2022-01-04 00:00", temp_f : Float = 0, condition : Condition?, wind_mph : Float  = 0, feelslike_f : Float = 0){
        self.time = time
        self.temp_f = temp_f
        self.condition = condition
        self.wind_mph = wind_mph
        self.feelslike_f = feelslike_f
    }
}
