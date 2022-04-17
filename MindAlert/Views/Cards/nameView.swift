//
//  nameView.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 3).padding(.top, 50))
            .foregroundColor(Color(red: 0.929 , green: 0.682, blue:0.580))
    }
}

struct nameView: View {
    @State var text = ""
    @State var selection: Int? = nil
    
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
                                TextField("Kim", text: $text)
                                    .underlineTextField()
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: WelcomeView_1(), tag: 1, selection: $selection) {
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
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                    
                    
                }
                .padding(20)
            }
            .hiddenNavigationBarStyle()
        }
            
    }
}

struct nameView_Previews: PreviewProvider {
    static var previews: some View {
        nameView()
    }
}
