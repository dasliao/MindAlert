//
//  InfoAndDisclaimer.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct InfoAndDisclaimer: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("inprogress-0")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 15) {
                                    Image(systemName: "square.fill.text.grid.1x2")
                                        .foregroundColor(Color("MindGreen"))
                                        .font(.system(size: 36, weight: .regular))
                                    Text("Info and Disclaimer")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("MindBlack"))
                                    
                                }
                                Spacer()
                                ScrollView {
                                    Spacer(minLength: 40)
                                    VStack(alignment: .leading, spacing: 50) {
                                        HStack(alignment: .top, spacing: 15) {
                                            Image(systemName: "1.circle")
                                                .foregroundColor(Color("MindPeach"))
                                                .font(.system(size: 32, weight: .regular))
                                            Text("You can complete this plan entirely on your own, with someone you trust, or your doctor / mental health provider.")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Color("MindBlack"))
                                        }
                                        HStack(alignment: .top, spacing: 15) {
                                            Image(systemName: "2.circle")
                                                .foregroundColor(Color("MindPeach"))
                                                .font(.system(size: 32, weight: .regular))
                                            Text("This app can't replace professional treatment. You are deserving of help. This app includes a list of further resources you can view after setup. ")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Color("MindBlack"))
                                        }
                                        HStack(alignment: .top, spacing: 15) {
                                            Image(systemName: "3.circle")
                                                .foregroundColor(Color("MindPeach"))
                                                .font(.system(size: 32, weight: .regular))
                                            Text("Trigger Warning: Suicidal crisis is mentioned throughout the setup process. Please proceed with caution or with supervision from a professional.")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Color("MindBlack"))
                                        }
                                    }
                                    Spacer(minLength: 40)
                                }
                                
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: CopingStrategies(), tag: 1, selection: $selection) {
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
                        Text("Cancel")
                            .fontWeight(.bold)
                            .foregroundColor(Color("MindGreen"))
                            .padding(.all)
                        
                        
                    }
                    
                    
                }
                .padding(20)
            }
            .hiddenNavigationBarStyle()
        }
        .hiddenNavigationBarStyle()
    }
}

struct InfoAndDisclaimer_Previews: PreviewProvider {
    static var previews: some View {
        InfoAndDisclaimer()
    }
}
