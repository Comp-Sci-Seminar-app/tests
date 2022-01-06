//
//  Detailed View.swift
//  WeatherTest
//
//  Created by Ari Bredbenner (student LM) on 1/5/22.
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
    var temp_f : Double
    var condition : Condition?
    var wind_mph : Double
    var feelslike_f : Double
    
    init(time: String = "2022-01-04 00:00", temp_f : Double = 0, condition : Condition?, wind_mph : Double  = 0, feelslike_f : Double = 0){
        self.time = time
        self.temp_f = temp_f
        self.condition = condition
        self.wind_mph = wind_mph
        self.feelslike_f = feelslike_f
    }
}
