//
//  WelcomeView-1.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct WelcomeView_1: View {
    @Environment(\.presentationMode) var presentation
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("Hello")
                            .font(.system(size: 40, weight: .bold))
                        HStack(spacing: 0) {
                            Text("Kim")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("MindGreen"))
                            Text("!")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("MindGreen"))
                        }
                    }
                    .padding(.horizontal)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 10) {
                                Spacer()
                                Text("\(Text("Mind").foregroundColor(Color("MindGreen"))) \(Text("Alert").foregroundColor(Color("MindPeach"))) helps you prepare a Safety Plan for suicidal crisis so you can stay safe. ")
                                    .font(.system(size: 32, weight: .semibold))
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: WelcomeView_2(), tag: 1, selection: $selection) {
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

struct WelcomeView_1_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView_1()
    }
}
