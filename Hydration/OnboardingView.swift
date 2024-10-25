//
//  OnboardingView.swift
//  Hydration
//
//  Created by Mariya Niazi on 22/04/1446 AH.
//

import SwiftUI

struct OnboardingView: View {
    
    // State variable to hold the body weight input
    @State private var bodyWeight: String = ""
    @State private var isNextScreenActive = false  // To track navigation to next screen
    
    var body: some View {
        NavigationView {  // Use NavigationView for earlier iOS versions
            VStack(spacing: 20) {
                
                // Hydration Icon
                Image(systemName: "drop.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.cyan)  // Icon color
                
                // Title
                Text("Hydrate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Description
                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .foregroundColor(.gray)
                
                // Input Field for Body Weight
                HStack {
                    Text("Body weight")
                        .font(.body)
                        .foregroundColor(.black)
                    TextField("Value", text: $bodyWeight)
                        .keyboardType(.decimalPad)
                        .padding(.leading, 10)
                        .frame(height: 44)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    // Clear button
                    Button(action: {
                        bodyWeight = "" // Clear the input
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 40)
                
                // Next Button with Navigation
                NavigationLink(destination: NotificationPreferencesView(), isActive: $isNextScreenActive) {
                    EmptyView()  // Use this to trigger the NavigationLink programmatically
                }
                Button(action: {
                    saveBodyWeight(bodyWeight)
                    isNextScreenActive = true  // Activate navigation to NotificationPreferencesView
                }) {
                    Text("Next")
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
            .padding(.top, 60) // Adjust to ensure it matches your design
        }
    }
    
    // Function to handle saving the body weight (backend-like functionality)
    func saveBodyWeight(_ weight: String) {
        // Backend logic - save to UserDefaults for now (simple local storage)
        UserDefaults.standard.set(weight, forKey: "bodyWeight")
        print("Body weight saved: \(weight)")
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
