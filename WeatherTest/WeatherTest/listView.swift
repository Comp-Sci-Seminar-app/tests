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
    
    //sorry for bad language but its true!
    
    var body: some View {
        
        //for some reason the overlords at weatherapi.com forgot to add https to their image links. this is why the link looks so weird
        let img = "https:" + (h.condition?.icon ?? "//www.siue.edu/~itoberm/Images/RedX.gif")
        
        
        let rawTime = h.time
        VStack{
            Text("\(String(rawTime[rawTime.lastIndex(of: " ")!...]))").foregroundColor(.black)
            KFImage(URL(string: img))
        }
        
        
    }
}






