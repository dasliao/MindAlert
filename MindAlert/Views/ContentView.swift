//
//  ContentView.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SafetyPlanViewModel()
    
    var body: some View {
        nameView(viewModel: viewModel)
    }
}

// Update nameView to accept viewModel
struct nameView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("Welcome to")
                            .font(.system(size: 40, weight: .bold))
                        HStack(spacing: 0) {
                            Text("Mind")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("MindGreen"))
                            Text("Alert")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("MindPeach"))
                        }
                    }
                    .padding(.horizontal)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 10) {
                                Spacer()
                                Image(systemName: "person")
                                    .font(.system(size: 40, weight: .regular))
                                    .foregroundColor(Color("MindGreen"))
                                Text("What Should we\ncall you?")
                                    .font(.system(size: 32, weight: .semibold))
                                TextField("Kim", text: Binding(
                                    get: { viewModel.safetyPlan.name },
                                    set: { viewModel.setName($0) }
                                ))
                                    .underlineTextField()
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: WelcomeView_1(viewModel: viewModel), tag: 1, selection: $selection) {
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
                        Text("Have an Account? Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(Color("MindGreen"))
                            .padding(.all)
                    }
                }
                .padding(20)
            }
            .hiddenNavigationBarStyle()
        }
    }
}
