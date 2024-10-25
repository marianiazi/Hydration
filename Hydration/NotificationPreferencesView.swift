//
//  NotificationPreferencesView.swift
//  Hydration
//
//  Created by Mariya Niazi on 22/04/1446 AH.
//

import SwiftUI
import UserNotifications

struct NotificationPreferencesView: View {
    
    @State private var selectedInterval: String = "15 Mins"
    
    // Possible intervals
    let intervals = ["15 Mins", "30 Mins", "60 Mins", "90 Mins", "2 Hours", "3 Hours", "4 Hours", "5 Hours"]
    
    // Custom start and end hour picker views
    //@State private var startHour = Date()
    // @State private var endHour = Date()
    @State private var startHour = Calendar.current.date(byAdding: .minute, value: 1, to: Date())! // 1 minute from now
    @State private var endHour = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!  // 5 minutes from now
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Title and Subtitle
            Text("Notification Preferences")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("The start and End hour")
                .font(.headline)
                .foregroundColor(.black)
            
            Text("Specify the start and end date to receive the notifications")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            // Custom Time Picker for Start and End Hour
            VStack(spacing: 40) {
                HStack {
                    Text("Start hour")
                    TwelveHourPickerButtonView(startHour: $startHour)
                }
                HStack {
                    Text("End hour")
                    TwelveHourPickerButtonView(startHour: $endHour)
                }
            }
            .padding(.horizontal, 40)
            
            // Notification Interval Section
            Text("Notification interval")
                .font(.headline)
                .foregroundColor(.black)
            
            Text("How often would you like to receive notifications within the specified time interval")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            // Grid of interval buttons with different colors for numbers and text
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(intervals, id: \.self) { interval in
                    Button(action: {
                        selectedInterval = interval
                    }) {
                        let parts = interval.components(separatedBy: " ")
                        if parts.count == 2 {
                            HStack(spacing: 2) {
                                Text(parts[0])  // The number part (e.g., 15)
                                    .font(.headline)
                                    .foregroundColor(selectedInterval == interval ? .white : .blue2)
                                Text(parts[1])  // The unit part (e.g., Mins)
                                    .font(.subheadline)
                                    .foregroundColor(selectedInterval == interval ? .white : .gray)
                            }
                            .frame(width: 90, height: 44)
                            .background(selectedInterval == interval ? Color.blue2 : Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            
            // Start Button
            Button(action: {
                saveNotificationPreferences()
                scheduleNotifications()
            }) {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue2)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            
            Spacer() // To push content up
        }
        .padding(.top, 40)
    }
    
    // Function to save the notification preferences (backend-like functionality)
    func saveNotificationPreferences() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let startHourString = formatter.string(from: startHour)
        let endHourString = formatter.string(from: endHour)
        
        // Saving preferences (you can modify this to save in UserDefaults or backend API)
        print("Start Hour: \(startHourString)")
        print("End Hour: \(endHourString)")
        print("Selected Interval: \(selectedInterval)")
        
        // Simulate saving to UserDefaults (or backend)
        UserDefaults.standard.set(startHourString, forKey: "startHour")
        UserDefaults.standard.set(endHourString, forKey: "endHour")
        UserDefaults.standard.set(selectedInterval, forKey: "notificationInterval")
    }
    
    // Function to schedule notifications based on selected preferences
   /* func scheduleNotifications() {
     // Request permission for notifications
     UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
     if granted {
     // Remove any previously scheduled notifications
     UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
     
     let calendar = Calendar.current
     
     // Calculate interval in minutes from the selected interval string
     let intervalMinutes: Int = {
     let parts = selectedInterval.components(separatedBy: " ")
     if let value = Int(parts[0]) {
     return parts[1].lowercased().contains("hour") ? value * 60 : value
     }
     return 15
     }()
     
     var currentDate = startHour
     
     while currentDate < endHour {
     let components = calendar.dateComponents([.hour, .minute], from: currentDate)
     
     let content = UNMutableNotificationContent()
     content.title = "Stay Hydrated!"
     content.body = "Remember to drink water and stay hydrated."
     content.sound = UNNotificationSound.default
     
     // Schedule the notification for the current time
     let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
     let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
     UNUserNotificationCenter.current().add(request)
     
     // Increment the currentDate by the interval chosen by the user
     currentDate = calendar.date(byAdding: .minute, value: intervalMinutes, to: currentDate) ?? currentDate
     }
     } else if let error = error {
     print("Notification permission denied: \(error.localizedDescription)")
     }
     }
     }
    */ }
     
    //--------------------------------------------------------------------
    // TESTING 5 SEC
func scheduleNotifications() {
    // Request permission for notifications
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
        if granted {
            // Remove any previously scheduled notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            // Set the interval to 5 seconds for testing purposes
            let intervalSeconds = 5
            
            // For testing, schedule 10 notifications with a 5-second interval
            let numberOfNotifications = 10
            
            for i in 0..<numberOfNotifications {
                let content = UNMutableNotificationContent()
                content.title = "Stay Hydrated!"
                content.body = "Remember to drink water and stay hydrated."
                content.sound = UNNotificationSound.default
                
                // Use UNTimeIntervalNotificationTrigger, making sure the timeInterval is greater than 0
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((i + 1) * intervalSeconds), repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Scheduled notification \(i + 1)")
                    }
                }
            }
        } else if let error = error {
            print("Notification permission denied: \(error.localizedDescription)")
        }
    }
}

    ///------------------------------------------------------------------------------------------------
    
    // Custom view for selecting 12-hour time with AM/PM
    struct TwelveHourPickerButtonView: View {
        @Binding var startHour: Date // Binds to startHour from parent view
        @State private var selectedHour = 1
        @State private var selectedMinute = 0
        @State private var selectedPeriod = "AM"
        @State private var showTimePicker = false
        
        // Data arrays for hours, minutes, and periods (AM/PM)
        let hours = Array(1...12)
        let minutes = Array(0..<60)
        let periods = ["AM", "PM"]
        
        // Main body for displaying the button and time picker
        var body: some View {
            VStack {
                timePickerButton()
            }
        }
        
        // Button that shows the time picker in a sheet
        func timePickerButton() -> some View {
            HStack {
                Button(action: {
                    // Toggles time picker sheet
                    showTimePicker.toggle()
                }) {
                    Text(formattedTime()) // Displays the selected time
                        .font(.system(size: 17, weight: .medium))
                        .padding()
                        .frame(maxWidth: 74, maxHeight: 34, alignment: .trailing)
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(.black)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showTimePicker) {
                    // Shows the time picker in a modal sheet (Removed presentationDetents for iOS 15 or lower)
                    timePickerSheet()
                }
                
                Picker("AM/PM", selection: $selectedPeriod) {
                    ForEach(periods, id: \.self) { period in
                        Text(period).tag(period)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 100, minHeight: 34)
                .cornerRadius(10)
            }
        }
        
        // Time picker sheet with wheel-style pickers for hours and minutes
        func timePickerSheet() -> some View {
            VStack {
                HStack {
                    Picker("Select Hour", selection: $selectedHour) {
                        ForEach(hours, id: \.self) { hour in
                            Text("\(hour)").tag(hour)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minWidth: 28, minHeight: 28, alignment: .trailing)
                    .clipped()
                    
                    Picker("Select Minute", selection: $selectedMinute) {
                        ForEach(minutes, id: \.self) { minute in
                            Text(String(format: "%02d", minute)).tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minWidth: 28, minHeight: 28, alignment: .trailing)
                    .clipped()
                }
                .padding()
                
                // Done button to save selected time and close the picker
                Button("Done") {
                    convertTo24HourFormat()
                    showTimePicker.toggle()
                }
                .padding()
            }
        }
        
        // Converts selected time into 24-hour format and updates the binding
        func convertTo24HourFormat() {
            var hourIn24Format = selectedHour
            if selectedPeriod == "PM" && selectedHour != 12 {
                hourIn24Format += 12
            } else if selectedPeriod == "AM" && selectedHour == 12 {
                hourIn24Format = 0
            }
            
            var components = Calendar.current.dateComponents([.year, .month, .day], from: startHour)
            components.hour = hourIn24Format
            components.minute = selectedMinute
            
            if let newDate = Calendar.current.date(from: components) {
                startHour = newDate
            }
        }
        
        // Formats the selected time in 12-hour format
        func formattedTime() -> String {
            let components = Calendar.current.dateComponents([.hour, .minute], from: startHour)
            
            let hour = components.hour! % 12 == 0 ? 12 : components.hour! % 12
            let minute = String(format: "%02d", components.minute!)
            
            return "\(hour):\(minute)"
        }
    }
    
    struct NotificationPreferencesView_Previews: PreviewProvider {
        static var previews: some View {
            NotificationPreferencesView()
        }
    }

