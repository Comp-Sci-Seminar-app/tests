import Foundation
import UserNotifications
import CoreLocation

enum NotificationManagerConstants {
  static let timeBasedNotificationThreadId =
    "TimeBasedNotificationThreadId"
  static let calendarBasedNotificationThreadId =
    "CalendarBasedNotificationThreadId"
  static let locationBasedNotificationThreadId =
    "LocationBasedNotificationThreadId"
}

class NotificationManager: ObservableObject {
  static let shared = NotificationManager()
  @Published var settings: UNNotificationSettings?
  
  func requestAuthorization(completion: @escaping  (Bool) -> Void) {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
        // TODO: Fetch notification settings
        completion(granted)
      }
  }
  
  func fetchNotificationSettings() {
    // 1
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      // 2
      DispatchQueue.main.async {
        self.settings = settings
      }
    }
  }
  
  // 1
  func scheduleNotification(task: Task) {
    // 2
    let content = UNMutableNotificationContent()
    content.title = task.name
    content.body = "Gentle reminder for your task!"
    
    content.categoryIdentifier = "OrganizerPlusCategory"
    let taskData = try? JSONEncoder().encode(task)
    if let taskData = taskData {
      content.userInfo = ["Task": taskData]
    }
    
    // 3
    var trigger: UNNotificationTrigger?
    
    //Sets each type of notification and gives them a tyoe based on what they are being set with or for.
    switch task.reminder.reminderType {
    case .time:
      content.threadIdentifier = NotificationManagerConstants.timeBasedNotificationThreadId
      if let timeInterval = task.reminder.timeInterval {
        trigger = UNTimeIntervalNotificationTrigger(
          timeInterval: timeInterval,
          repeats: task.reminder.repeats)
      }
    
    case .calendar:
      content.threadIdentifier = NotificationManagerConstants.timeBasedNotificationThreadId
      if let date = task.reminder.date {
        trigger = UNCalendarNotificationTrigger(
          dateMatching: Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute],
            from: date),
          repeats: task.reminder.repeats)
      }
    
    case .location:
      content.threadIdentifier = NotificationManagerConstants.timeBasedNotificationThreadId
      // 1
      guard CLLocationManager().authorizationStatus == .authorizedWhenInUse else {
        return
      }
      // 2
      if let location = task.reminder.location {
        // 3
        let center = CLLocationCoordinate2D(
          latitude: location.latitude,
          longitude: location.longitude)
        let region = CLCircularRegion(
          center: center,
          radius: location.radius,
          identifier: task.id)
        trigger = UNLocationNotificationTrigger(
          region: region,
          repeats: task.reminder.repeats)
      }
    }
    
    // 4
    if let trigger = trigger {
      let request = UNNotificationRequest(
        identifier: task.id,
        content: content,
        trigger: trigger)
      // 5
      UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
          print(error)
        }
      }
    }
  }
  
  //Removes a notification that you have scheduled
  func removeScheduledNotification(task: Task) {
    UNUserNotificationCenter.current()
      .removePendingNotificationRequests(withIdentifiers: [task.id])
  }
}
