//
//  listView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI
import struct Kingfisher.KFImage



struct listView: View {
    
    
    var h : Hour
  
    //right here is where the people on stack overflow were a**holes. they told me that my issue was related to an unrelated issue, and NOT because my code was simply in the wrong place. They also lowered my community score so now any time I want to post it has to get reviewed
    
    var body: some View {
        let rawTime = h.time
        let img = "https:" + (h.condition?.icon ?? "//www.siue.edu/~itoberm/Images/RedX.gif")
        HStack{
            Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
            KFImage(URL(string: img))
        }
        .opacity(0.8)
    }
}






