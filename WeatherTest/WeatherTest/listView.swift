//
//  listView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI

struct listView: View {
    
    
    var h : Hour
  
    //basic view for when its in the list
    var body: some View {
        let rawTime = h.time
        HStack{
            Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
        }
        .opacity(0.8)
    }
}






