//
//  EmergencyServicesView.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct EmergencyServicesView: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("inprogress-3")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 15) {
                                    Image(systemName: "cross.case")
                                        .foregroundColor(Color("MindGreen"))
                                        .font(.system(size: 36, weight: .regular))
                                    Text("Emergency Services")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("MindBlack"))
                                        
                                }
                                Spacer()
                                VStack(alignment:.leading) {
                                    HStack(spacing: 0) {
                                        Text("Almost there ")
                                        Text("Kim")
                                        Text(",")
                                    }
                                    Text("let’s choose your emergency services")
                                }
                                .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                VStack(spacing: 20) {
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                        Text("Call 911")
                                    }
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color(.white))
                                    .padding(.leading, 20)
                                    .frame(width: 300, height: 60, alignment: .leading)
                                    .background(Color("MindPeach"))
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("MindPeach"), lineWidth: 2)
                                    )
                                    HStack {
                                        Image(systemName: "circle")
                                        Text("I have an alternative emergency service")
                                    }
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color("MindPeach"))
                                    .padding(.leading, 20)
                                    .frame(width: 300, height: 80, alignment: .leading)
                                    .background(Color(.white))
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("MindPeach"), lineWidth: 2)
                                    )

                                }
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: CompleteView(), tag: 1, selection: $selection) {
                                        Button("Confirm") {
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

struct EmergencyServicesView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyServicesView()
    }
}
