//
//  ContentView.swift
//  WeatherTest
//
//  Created by Ari Steinfeld (student LM) on 12/16/21.
//
func URlForm(_ address : String = "618 Schiller Ave", city : String = "Merion Station", state : String = "PA", zip : String = "19066") -> String{//function reads in an address and outputs a string url
    var finalURL  = "https://geocoding.geo.census.gov/geocoder/locations/onelineaddress?address="//static portion of the URL that holds the paramaters we dont need to change
    let URLEnd = "&benchmark=2020&format=json"//same as above but we stick it on the back
    finalURL = finalURL+address.replacingOccurrences(of: " ", with: "+")+"%2C+"+city.replacingOccurrences(of: " ", with: "+")+"%2C+"+state+"+"+zip+URLEnd//creates the URL replacing spaces with plus signs and adding other things in between that are nessecary for the link to function
    //print("In URLForm: "+finalURL)//prints for debug
    return finalURL//returns the url
}
import SwiftUI
import struct Kingfisher.KFImage


struct ContentView: View {
    @StateObject var g = Decoded()
    @StateObject var f = FetchData()
    //sam's branch
    //makes the back button invisible so I can add a custom one.
    init(){
        Theme.navigationBarColors(background: .clear, titleColor: .clear)
    }
    
    var body: some View {
        let allDaily = g.dForecast.properties.periods
        let allHourly = g.hForecast.properties.periods
        NavigationView{
            
            VStack{//Ask why this was a scrollview
                
                
                Group{
                    VStack{
                        //just the current stuff
                        Text("Current Forecast")
                        Text("condition: \(allHourly[0].shortForecast ?? "Loading...")")
                        Text("temp: \(allHourly[0].temperature) degrees fahrenheit")
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 120, alignment: .center)
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(20)
                    .foregroundColor(.black)
                    .font(.system(size: 18).bold())
                    .opacity(0.4)
                    
                    //iterates through the hours of the day
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(0..<f.responses.forecast.forecastday[0].hour.count){index in
                                NavigationLink(destination:
                                                detailedView(info: allHourly[index], icon: f.responses.forecast.forecastday[0].hour[index])
                                                .edgesIgnoringSafeArea(.all), //allows it to extend into the navigation bar area
                                               label:  {
                                                listView(h: f.responses.forecast.forecastday[0].hour[index])
                                                    .frame(width: 90, height: 100, alignment:  .center).background(Color.gray).opacity(0.4).cornerRadius(20)})
                                //frames it to look nice and modern rather than what the actual code is.
                                
                                
                                
                            }
                        }
                        //makes it look much nicer
                    }.navigationBarHidden(true)
                    
                }
                Spacer()
                
                
                //also needed here or else it gets angry, and sets a good background
            }.navigationBarHidden(true).background(
                Group{
                    //checks if it is night
                    if allHourly[0].isDaytime{
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
            
            
            
            
            
            
        } .background(
            Group{
                //checks if it is night
                if allHourly[0].isDaytime{
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
        //test

        
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
    @Binding var g: HPeriods
    var body: some View {
        HStack {
            VStack{
                //just the current stuff
                Text("Current Forecast")
                Text("condition: \(f.current.condition?.text ?? "Loading...")")
                Text("temp: \(g.temperature) degrees fahrenheit")
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 120, alignment: .center)
            .background(Color.gray.opacity(0.8))
            .cornerRadius(20)
            .foregroundColor(.black)
            .font(.system(size: 18).bold())
        }
    }
}


//alllows the status bar to be hidden. Copy and pasted from stackoverflow
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.shared.isStatusBarHidden = true // <== ADD THIS LINE
        return true
    }
}


//allows me to set the back button to invisible so I can add a custom image behind it. Also copy and pasted from stack overflow
class Theme {
    static func navigationBarColors(background : UIColor?,
                                    titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .black
        
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
//HOW TO STORE APPDATA: add @AppStorage(<string>) as a wrapper. its like the state wrapper except far cooler.
//IF GIT MERGE IS HAVING ISSUES:  git merge <branch name> -X rename-threshold=100%
//fix all issues, then run git commit -am 'Conflicts resolved'

//marked for merge
