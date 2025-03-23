//
//  Home.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var activationProgress: CGFloat = 0
    @State private var isActivating = false
    @State private var showingActivatedPlan = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Hello \(Text(viewModel.safetyPlan.name).foregroundColor(Color("MindGreen")))")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 40)
                Spacer()
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Button {
                            isActivating = true
                            // Simulate holding button for 3 seconds
                            withAnimation(.linear(duration: 3)) {
                                activationProgress = 1.0
                            }
                            
                            // After 3 seconds, show the activated plan
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if activationProgress >= 0.99 {
                                    showingActivatedPlan = true
                                }
                                isActivating = false
                                activationProgress = 0
                            }
                        } label: {
                            ZStack {
                                Image("TheButtonLarge")
                                
                                // Overlay progress circle when activating
                                if isActivating {
                                    Circle()
                                        .trim(from: 0, to: activationProgress)
                                        .stroke(Color("MindGreen"), lineWidth: 4)
                                        .rotationEffect(.degrees(-90))
                                        .frame(width: 170, height: 170)
                                }
                            }
                        }
                        .disabled(isActivating)
                        Spacer()
                    }
                    Text("Press the Button for 3 Seconds\nto activate your \(Text("Safety Plan").font(.system(size: 20, weight: .bold))).")
                        .font(.system(size: 20))
                        .foregroundColor(Color("MindGreen"))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(height: 90, alignment: .center)
                        
                    HStack {
                        Spacer()
                        Image(systemName: "tray.2")
                        Spacer()
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "person")
                        Spacer()
                    }
                    .foregroundColor(Color("MindWhite"))
                    .font(.system(size: 30))
                }
            }
            .padding()
            .hiddenNavigationBarStyle()
            .sheet(isPresented: $showingActivatedPlan) {
                SafetyPlanActivatedView(viewModel: viewModel)
            }
        }
        .hiddenNavigationBarStyle()
    }
}

// New view to display the activated safety plan
struct SafetyPlanActivatedView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Safety Plan Activated")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color("MindGreen"))
                        .padding(.top)
                    
                    // Coping Strategies Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "tray.full")
                                .foregroundColor(Color("MindGreen"))
                                .font(.system(size: 24))
                            Text("Coping Strategies")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        
                        if viewModel.safetyPlan.strategies.isEmpty {
                            Text("No strategies added")
                                .foregroundColor(.gray)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                    Text(viewModel.safetyPlan.strategies[index])
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    
                    // Emergency Contacts Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.2.wave.2")
                                .foregroundColor(Color("MindGreen"))
                                .font(.system(size: 24))
                            Text("Emergency Contacts")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        
                        if viewModel.safetyPlan.contacts.isEmpty {
                            Text("No contacts added")
                                .foregroundColor(.gray)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { index in
                                let contact = viewModel.safetyPlan.contacts[index]
                                HStack {
                                    Text(contact.name)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Button(action: {
                                        guard let url = URL(string: "tel://\(contact.phoneNumber)") else { return }
                                        UIApplication.shared.open(url)
                                    }) {
                                        HStack {
                                            Text("Call")
                                            Image(systemName: "phone.fill")
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color("MindGreen"))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    
                    // Emergency Services Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "cross.case")
                                .foregroundColor(Color("MindGreen"))
                                .font(.system(size: 24))
                            Text("Emergency Services")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        
                        Button(action: {
                            guard let url = URL(string: "tel://\(viewModel.safetyPlan.emergencyService)") else { return }
                            UIApplication.shared.open(url)
                        }) {
                            HStack {
                                Text("Call \(viewModel.safetyPlan.emergencyService)")
                                Spacer()
                                Image(systemName: "phone.fill")
                            }
                            .padding()
                            .background(Color("MindPeach"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                }
                .padding()
            }
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .foregroundColor(Color("MindGreen"))
                }
            )
        }
    }
}
