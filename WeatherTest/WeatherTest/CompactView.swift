//
//  CompactView.swift
//  WeatherTest
//
//  Created by Samuel Conry-Murray (student LM) on 1/24/22.
//

import SwiftUI

struct CompactView: View {
    var info : HPeriods
    public var body: some View {
        HStack{
            Text("Temp: "+String(info.temperature)+" F")
            Text("Wind: "+info.windSpeed+" "+info.windDirection)
        }
    }
}

//struct CompactView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompactView()
//    }
//}


//marked for merge
