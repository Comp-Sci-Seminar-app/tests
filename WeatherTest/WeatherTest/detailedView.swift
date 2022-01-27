//
//  detailedView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI

struct detailedView: View {
    var info : Hour
    
    public var body: some View {
        let rawTime = info.time
        
        
        
        //rounding
        let displayTemp_F = Int(Double.rounded(info.temp_f)())
        let displayFeelslike_f = Int(Double.rounded(info.feelslike_f)())
        let displayWind_mph = Int(Double.rounded(info.wind_mph)())
        GeometryReader{geo in
            
            
            VStack{
                //a back image underneath the real invisible back button. MUCH EASIER THAN SWITCHING EVERYTHING TO "model"s
                HStack{
                    Image("back").resizable().frame(width: 50, height: 50, alignment: .leading)
                    Spacer()
                }
                Spacer()
                Group{
                    
                    //displaying all the data
                    Text(info.condition?.text ?? "API error")
                    Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
                    Text("Temperature: \(displayTemp_F) degrees fahrenheit")
                    Text("Feels like: \(displayFeelslike_f) degrees fahrenheit")
                    Text("Wind MPH: \(displayWind_mph)")
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 50, alignment: .center)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .foregroundColor(.black)
                .font(.system(size: 18).bold())
                //all of the . stuff are for making the text look nice
                
                
                Spacer()
                Spacer()
                Spacer()
            } //making things look nice
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
            .background(
                Group{
                    
                    if (timeToInt(info.time) < 19 && timeToInt(info.time) > 5){
                        Image("\(info.condition?.code ?? 1000)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                    }else{
                        Image("night")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                    }
                    
                }
                
            )
            //general spacing
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
    }
    
   
    
}
