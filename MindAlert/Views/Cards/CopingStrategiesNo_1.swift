//
//  CopingStrategiesNo_1.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct CopingStrategiesNo_1: View {
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
                                    VStack(alignment: .leading) {
                                        Text("Okay, no worries!\nCoping stategies are activities that help distract you until help arrives.")
                                        Spacer(minLength: 60)
                                        VStack(alignment:.leading) {
                                            Text("For Example")
                                            Spacer(minLength: 30)
                                            VStack(alignment: .leading, spacing: 50) {
                                                HStack(alignment: .top, spacing: 15) {
                                                    Image(systemName: "play.tv")
                                                        .foregroundColor(Color("MindGreen"))
                                                        .frame(width: 40.0)
                                                        .font(.system(size: 32, weight: .regular))
                                                    Text("Paste the links of your favorite video, playlist or website.")
                                                        
                                                }
                                                HStack(alignment: .top, spacing: 15) {
                                                    Image(systemName: "books.vertical")
                                                        .foregroundColor(Color("MindGreen"))
                                                        .frame(width: 40.0)
                                                        .font(.system(size: 32, weight: .regular))
                                                    Text("List your favorite hobbies: video games, reading, painting, etc.")
                                                }
                                                HStack(alignment: .top, spacing: 15) {
                                                    Image(systemName: "pawprint")
                                                        .foregroundColor(Color("MindGreen"))
                                                        .frame(width: 40.0)
                                                        .font(.system(size: 32, weight: .regular))
                                                    Text("You can also do chores, play with a pet, wash your face, and more!")
                                                }
                                            }
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(Color("MindBlack"))
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                    .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                }
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: CopingStrategiesYes(), tag: 1, selection: $selection) {
                                        Button("Understood") {
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

struct CopingStrategiesNo_1_Previews: PreviewProvider {
    static var previews: some View {
        CopingStrategiesNo_1()
    }
}
