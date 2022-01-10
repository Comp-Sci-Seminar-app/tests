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
        
        //I think I need this ZStack for something. I'm not completely sure thogh
        ZStack{
            VStack{
                VStack{
                    //just the current stuff
                    Text("Current Forecast")
                    Text("condition: \(f.responses.current.condition?.text ?? "Loading...")")
                    Text("temp: \(Int(Double.rounded(f.responses.current.temp_f)())) degrees fahrenheit")
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 120, alignment: .center)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                .foregroundColor(.black)
                .font(.system(size: 18).bold())
                NavigationView{
                    List(f.responses.forecast.forecastday[0].hour){h in
                        NavigationLink(destination: detailedView(info: h), label: {
                            listView(h: h)
                            
                        })
                        
                        
                    }
                    
                }
                .opacity(0.8)
                .background(
                    Group{
                        //checks if it is night
                        if (timeToInt(f.responses.location.localtime) < 19 && timeToInt(f.responses.location.localtime) > 5){
                            Image("\(f.responses.current.condition?.code ?? 1000)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            //if it is night, uses a different image
                        }else{
                            Image("night")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    
                )
                
                
            }
            .background(
                
                Group{
                    
                    //checks if it is night
                    if (timeToInt(f.responses.location.localtime) < 19 && timeToInt(f.responses.location.localtime) > 5){
                        Image("\(f.responses.current.condition?.code ?? 1000)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        //if it is night, uses a different image
                    }else{
                        Image("night")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
            )
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//FAR from the best way to do it, but its how im gonna do it so fight me!
func timeToInt(_ rawTime : String) -> Int {
    let tTime0 : String = String(rawTime[rawTime.lastIndex(of: " ")!...])
    let tTime : String = String(tTime0.dropFirst())
    let tTime2 : String = String(tTime[...tTime.firstIndex(of: ":")!])
    let tTime3 : String = String(tTime2.dropLast())
    let time = Int(tTime3) ?? 0
    return time
}

