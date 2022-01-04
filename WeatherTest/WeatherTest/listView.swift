//
//  listView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI

struct listView: View {
    
    
    var usable : makeItUsableLight
  
    
    var body: some View {
        let rawTime = usable.time
        HStack{
            Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
        }
    }
}






class makeItUsableLight{
    var time : String
    var temp_f : Double
    var condition : Condition?
    init(time: String = "2022-01-04 00:00", temp_f : Double = 0, condition : Condition?){
        self.time = time
        self.temp_f = temp_f
        self.condition = condition
    }
}
