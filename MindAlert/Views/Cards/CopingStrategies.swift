//
//  CopingStrategies.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct CopingStrategies: View {
    @State var name = ""
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
                                    HStack(spacing: 0) {
                                        Text("Hey ")
                                        Text("Kim")
                                        Text(",")
                                    }
                                    Text("do you already have strategies that help you stay distracted in a crisis?")
                                }
                                .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: CopingStrategiesYes(), tag: 1, selection: $selection) {
                                        Button("Yes, I do") {
                                            self.selection = 1
                                        }
                                        .buttonStyle(GreenButton())
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: CopingStrategiesNo_1(), tag: 1, selection: $selection) {
                                        Button("No, I need help") {
                                            self.selection = 1
                                        }
                                        .buttonStyle(RedButton())
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

struct CopingStrategies_Previews: PreviewProvider {
    static var previews: some View {
        CopingStrategies()
    }
}
