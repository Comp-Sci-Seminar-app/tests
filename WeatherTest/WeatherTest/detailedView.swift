//
//  detailedView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 1/4/22.
//

import SwiftUI

struct detailedView: View {
    var info : Hour
    
    
    var body: some View {
        let rawTime = info.time
        let displayTemp_F = Int(Double.rounded(info.temp_f)())
        let displayFeelslike_f = Int(Double.rounded(info.feelslike_f)())
        let displayWind_mph = Int(Double.rounded(info.wind_mph)())
        GeometryReader{geo in
            
            
            VStack{
                Spacer()
                Group{
                    Text(info.condition?.text ?? "API error")
                    Text("Time: \(String(rawTime[rawTime.lastIndex(of: " ")!...]))")
                    Text("Temperature: \(displayTemp_F) degrees fahrenheit")
                    Text("Feels like: \(displayFeelslike_f) degrees fahrenheit")
                    Text("Wind MPH: \(displayWind_mph)")
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 50, alignment: .center)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .foregroundColor(.black)
                .font(.system(size: 18).bold())
                Spacer()
                Spacer()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
            .background(
                Group{
                    if (timeToInt(info.time) < 19 && timeToInt(info.time) > 5){
                        Image("\(info.condition?.code ?? 1000)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }else{
                        Image("night")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
            )
            .opacity(0.8)
        }
    }
    
}
