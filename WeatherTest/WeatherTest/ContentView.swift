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
        
      //  //List(f.responses.condition){c in
   //         Text(c.text)
   //     }
        Text("temp: \(f.responses.current.temp_f)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
