//
//  CopingStrategiesYes.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct CopingStrategiesYes: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var newStrategy = ""
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("inprogress-1")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 15) {
                                    Image(systemName: "tray.full")
                                        .foregroundColor(Color("MindGreen"))
                                        .font(.system(size: 36, weight: .regular))
                                    Text("Coping Strategies")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("MindBlack"))
                                }
                                Spacer()
                                
                                ScrollView {
                                    VStack(alignment:.leading) {
                                        Text("Sounds good, \nlet's list your strategies ")
                                            .foregroundColor(Color("MindBlack"))
                                            .font(.system(size: 32, weight: .semibold))
                                        
                                        // List existing strategies
                                        ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                            VStack(alignment: .leading, spacing: 5) {
                                                HStack {
                                                    Text("Strategy \(index + 1)")
                                                        .padding(10)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 15)
                                                                .stroke(Color("MindPeach"), lineWidth: 3)
                                                        )
                                                        .font(.system(size: 16, weight: .medium))
                                                    
                                                    Spacer()
                                                    
                                                    Button(action: {
                                                        viewModel.removeStrategy(at: index)
                                                    }) {
                                                        Image(systemName: "minus.circle.fill")
                                                            .foregroundColor(Color("MindPeach"))
                                                    }
                                                }
                                                
                                                Text(viewModel.safetyPlan.strategies[index])
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .padding(.bottom, 10)
                                            }
                                            .padding(.top, 10)
                                        }
                                        
                                        // Add new strategy section
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Add New Strategy")
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color("MindPeach"), lineWidth: 3)
                                                )
                                                .font(.system(size: 16, weight: .medium))
                                            
                                            HStack {
                                                TextField("Ex: Play Minecraft", text: $newStrategy)
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .underlineTextField()
                                                
                                                Button(action: {
                                                    if !newStrategy.isEmpty {
                                                        viewModel.addStrategy(newStrategy)
                                                        newStrategy = ""
                                                    }
                                                }) {
                                                    Image(systemName: "plus.circle.fill")
                                                        .foregroundColor(Color("MindGreen"))
                                                        .font(.system(size: 24))
                                                }
                                            }
                                        }
                                        .padding(.top, 20)
                                    }
                                }
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: EmergencyContacts(viewModel: viewModel), tag: 1, selection: $selection) {
                                        Button("Next") {
                                            self.selection = 1
                                        }
                                        .buttonStyle(GreenButton())
                                    }
                                    Spacer()
                                }
                            }
                            .padding(25)
                        }
                    }
                }
                .padding(20)
            }
            .hiddenNavigationBarStyle()
        }
        .hiddenNavigationBarStyle()
    }
}