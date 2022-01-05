

var rawTime : String = "2022-01-04 12:00"
var tTime0 : String = String(rawTime[rawTime.lastIndex(of: " ")!...])
var tTime : String = String(tTime0.dropFirst())
var tTime2 : String = String(tTime[...tTime.firstIndex(of: ":")!])
var tTime3 : String = String(tTime2.dropLast())
var time = Int(tTime3) ?? 0
print(tTime0)
print(tTime)
print(tTime2)
print(tTime3)
print("\(time)")
