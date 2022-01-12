//
//  ContentView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//

import SwiftUI
import struct Kingfisher.KFImage


struct ContentView: View {
    @StateObject var f = FetchData()
    //@Binding hoursTest = $f.responses.forecast.forecastday[0].hour
    
    var body: some View {
        
        //I think I need this ZStack for something. I'm not completely sure thogh
        ZStack{
            VStack{
                NavigationView{
                    List(){
                        //the section header is what allows the cool header to work
                        Section(header: ListHeader(f: $f.responses), content:{
                            Group{
                               
                                    
                                    //iterates through the hours of the day
                                    ForEach(0..<f.responses.forecast.forecastday[0].hour.count){index in
                                        NavigationLink(destination: detailedView(info: f.responses.forecast.forecastday[0].hour[index]), label: {
                                            listView(h: f.responses.forecast.forecastday[0].hour[index])
                                            
                                        })
                                    
                                }
                            }
                        })

                        
                        
                    }.listStyle(GroupedListStyle())
                    
                    
                }
                .opacity(0.4)
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


//making a header for the code
struct ListHeader: View {
    @Binding var f: Response
    var body: some View {
        HStack {
            VStack{
                //just the current stuff
                Text("Current Forecast")
                Text("condition: \(f.current.condition?.text ?? "Loading...")")
                Text("temp: \(Int(Double.rounded(f.current.temp_f)())) degrees fahrenheit")
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 120, alignment: .center)
            .background(Color.gray.opacity(0.8))
            .cornerRadius(20)
            .foregroundColor(.black)
            .font(.system(size: 18).bold())
        }
    }
}


//HOW TO STORE APPDATA: add @AppStorage(<string>) as a wrapper. its like the state wrapper except far cooler.
