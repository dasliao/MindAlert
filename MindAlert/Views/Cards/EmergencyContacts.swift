//
//  EmergencyContacts.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct EmergencyContacts: View {
    @State var selection: Int? = nil
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("inprogress-2")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 15) {
                                    Image(systemName: "person.2.wave.2")
                                        .foregroundColor(Color("MindGreen"))
                                        .font(.system(size: 36, weight: .regular))
                                    Text("Emergency Contacts")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("MindBlack"))
                                }
                                Spacer()
                                ScrollView {
                                    VStack(alignment:.leading) {
                                        Text("Well done Kim,\nlet's set up your emergency contacts")
                                        VStack(alignment: .leading, spacing: 25) {
                                            HStack(spacing: 35) {
                                                Text("AL")
                                                    .frame(width: 80, height: 80, alignment: .center)
                                                    .foregroundColor(Color("MindPeachWhite"))
                                                    .background(Color("MindPeach"))
                                                    .cornerRadius(40)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color("MindPeach"), lineWidth: 3)
                                                    )
                                                    .font(.system(size: 36, weight: .medium))
                                                Text("\(Image(systemName: "plus"))")
                                                    .frame(width: 80, height: 80, alignment: .center)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color("MindLightPeach"), lineWidth: 3)
                                                    )
                                                    .font(.system(size: 36, weight: .medium))
                                                Text("\(Image(systemName: "plus"))")
                                                    .frame(width: 80, height: 80, alignment: .center)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color("MindLightPeach"), lineWidth: 3)
                                                    )
                                                    .font(.system(size: 36, weight: .medium))
                                                
                                            }
                                            .foregroundColor(Color("MindLightPeach"))
                                            Divider()
                                            VStack(alignment: .leading) {
                                                Text("Emergency Message:")
                                                    .font(.system(size: 20, weight: .bold))
                                                TextEditor(text: .constant("Hello (name). I am not ok right now. I already contacted professional services, but you can help me by going through this process with me. Are you available to help me right now?"))
                                                    .font(.system(size: 20, weight: .regular))
                                                    .frame(width: 280, height: 280, alignment: .leading)
                                                    .lineSpacing(10)
                                                    .padding()
                                                    .border(Color("MindPeach"), width: 3)
                                            }
                                        }
                                        
                                    }
                                    .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                }
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: EmergencyServicesView(), tag: 1, selection: $selection) {
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

struct EmergencyContacts_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContacts()
    }
}
