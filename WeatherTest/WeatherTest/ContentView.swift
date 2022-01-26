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
    
    //controls which hours are visible
    @State var displayCurrentHours = false
    @State var displayTommorrowHours = false
    @State var displayDayAfter = false
    
    //makes the back button invisible so I can add a custom one.
    init(){
        Theme.navigationBarColors(background: .clear, titleColor: .clear)
    }
    //testing something
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                Group{
                    //current data
                    Button(action: {displayCurrentHours.toggle()}){
                        HStack{
                            VStack{
                                //just the current stuff
                                Text("Current Forecast")
                                Text("condition: \(f.responses.current.condition?.text ?? "Loading...")")
                                Text("temp: \(Int(Double.rounded(f.responses.current.temp_f)())) degrees fahrenheit")
                            }
                            if(displayCurrentHours){
                                Image("up").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }else{
                                Image("down").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 120, alignment: .center)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .font(.system(size: 18).bold())
                        .opacity(0.4)
                    }
                    //iterates through the hours of the day
                    if (displayCurrentHours){
                        ScrollView(.horizontal){
                            LazyHStack {
                                ForEach(0..<f.responses.forecast.forecastday[0].hour.count){index in
                                    NavigationLink(destination:
                                                    detailedView(info: f.responses.forecast.forecastday[0].hour[index])
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
                }
                Spacer()
                Group{
                    let imgT = "https:" + (f.responses.forecast.forecastday[1].day.condition?.icon ?? "//www.siue.edu/~itoberm/Images/RedX.gif")
                    Button(action: {displayTommorrowHours.toggle()}){
                        HStack{
                            //daily icon
                            KFImage(URL(string: imgT))
                            VStack{
                                //tomorrow's stuff
                                Text("Tomorrow:")
                                Text("condition: \(f.responses.forecast.forecastday[1].day.condition?.text ?? "Loading...")")
                                Text("Max temp: \n\(Int(Double.rounded(f.responses.forecast.forecastday[1].day.maxtemp_f)())) degrees fahrenheit")
                                Text("Min temp: \n\(Int(Double.rounded(f.responses.forecast.forecastday[1].day.mintemp_f)())) degrees fahrenheit")
                            }.font(.system(size: 16))
                            if(displayTommorrowHours){
                                Image("up").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }else{
                                Image("down").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 150, alignment: .center)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .font(.system(size: 18).bold())
                        .opacity(0.4)
                    }
                    //iterates through the hours of the day
                    if (displayTommorrowHours){
                        ScrollView(.horizontal){
                            LazyHStack {
                                ForEach(0..<f.responses.forecast.forecastday[1].hour.count){index in
                                    NavigationLink(destination:
                                                    detailedView(info: f.responses.forecast.forecastday[1].hour[index])
                                                    .edgesIgnoringSafeArea(.all), //allows it to extend into the navigation bar area
                                                   label:  {
                                                    listView(h: f.responses.forecast.forecastday[1].hour[index])
                                                        .frame(width: 90, height: 100, alignment:  .center).background(Color.gray).opacity(0.4).cornerRadius(20)})
                                    //frames it to look nice and modern rather than what the actual code is.
                                    
                                    
                                    
                                }
                            }
                            //makes it look much nicer
                        }.navigationBarHidden(true)
                    }
                }
                Spacer()
                Group{
                    let imgT = "https:" + (f.responses.forecast.forecastday[2].day.condition?.icon ?? "//www.siue.edu/~itoberm/Images/RedX.gif")
                    Button(action: {displayDayAfter.toggle()}){
                        HStack{
                            //daily icon
                            KFImage(URL(string: imgT))
                            VStack{
                                //the day after's stuff
                                Text("Day After Tomorrow:")
                                Text("condition: \(f.responses.forecast.forecastday[2].day.condition?.text ?? "Loading...")")
                                Text("Max temp: \n\(Int(Double.rounded(f.responses.forecast.forecastday[2].day.maxtemp_f)())) degrees fahrenheit")
                                Text("Min temp: \n\(Int(Double.rounded(f.responses.forecast.forecastday[2].day.mintemp_f)())) degrees fahrenheit")
                            }.font(.system(size: 16))
                            if(displayDayAfter){
                                Image("up").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }else{
                                Image("down").resizable().frame(width: 50, height: 50, alignment: .leading)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 150, alignment: .center)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .font(.system(size: 18).bold())
                        .opacity(0.4)
                    }
                    //iterates through the hours of the day
                    if (displayDayAfter){
                        ScrollView(.horizontal){
                            LazyHStack {
                                ForEach(0..<f.responses.forecast.forecastday[2].hour.count){index in
                                    NavigationLink(destination:
                                                    detailedView(info: f.responses.forecast.forecastday[2].hour[index])
                                                    .edgesIgnoringSafeArea(.all), //allows it to extend into the navigation bar area
                                                   label:  {
                                                    listView(h: f.responses.forecast.forecastday[2].hour[index])
                                                        .frame(width: 90, height: 100, alignment:  .center).background(Color.gray).opacity(0.4).cornerRadius(20)})
                                    //frames it to look nice and modern rather than what the actual code is.
                                    
                                    
                                    
                                }
                            }
                            //makes it look much nicer
                        }.navigationBarHidden(true)
                    }
                }
                
                
                
                //also needed here or else it gets angry, and sets a good background
            }.navigationBarHidden(true).background(
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
            
            
            
        } .background(
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
