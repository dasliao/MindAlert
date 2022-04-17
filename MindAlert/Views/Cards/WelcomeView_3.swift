//
//  WelcomeView_3.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct WelcomeView_3: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ScrollView {
                                    Spacer(minLength: 30)
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("After creating your \(Text("Safety Plan").foregroundColor(Color("MindGreen"))), a panic button will become available.")
                                            .font(.system(size: 32, weight: .semibold))
                                            .foregroundColor(Color("MindBlack"))
                                        Spacer(minLength: 30)
                                        HStack {
                                            Spacer()
                                            Image("TheButton")
                                            Spacer()
                                        }
                                        Spacer(minLength: 30)
                                        Text("Press and hold this button for 3 seconds during a suicidal crisis to activate all features of the \(Text("Safety Plan").foregroundColor(Color("MindGreen"))) immediately.  ")
                                            .font(.system(size: 32, weight: .semibold))
                                            .foregroundColor(Color("MindBlack"))
                                        Spacer(minLength: 30)
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: InfoAndDisclaimer(), tag: 1, selection: $selection) {
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

struct WelcomeView_3_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView_3()
    }
}
