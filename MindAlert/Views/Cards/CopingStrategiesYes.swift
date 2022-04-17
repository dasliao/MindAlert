//
//  CopingStrategiesYes.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct CopingStrategiesYes: View {
    @State var text = ""
    @State var text2 = ""
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
                                VStack(alignment:.leading) {
                                    Text("Sounds good, \nlet’s list your strategies ")
                                    VStack(alignment: .leading, spacing: 25) {
                                        VStack(alignment: .leading) {
                                            Text("Strategy 1")
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color("MindPeach"), lineWidth: 3)
                                                )
                                                .font(.system(size: 16, weight: .medium))
                                            TextField("Play Minecraft", text: $text)
                                                .font(.system(size: 20, weight: .semibold))
                                                .underlineTextField()
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Strategy 2")
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color("MindPeach"), lineWidth: 3)
                                                )
                                                .font(.system(size: 16, weight: .medium))
                                            TextField("Watch Eternals", text: $text2)
                                                .underlineTextField()
                                                .font(.system(size: 20, weight: .semibold))
                                        }
                                        Text("\(Image(systemName: "plus"))")
                                            .padding(10)
                                            .padding(.horizontal, 15)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color("MindPeach"), lineWidth: 3)
                                            )
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    
                                }
                                .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: EmergencyContacts(), tag: 1, selection: $selection) {
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

struct CopingStrategiesYes_Previews: PreviewProvider {
    static var previews: some View {
        CopingStrategiesYes()
    }
}
