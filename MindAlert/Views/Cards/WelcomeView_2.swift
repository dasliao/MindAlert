//
//  WelcomeView_2.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct WelcomeView_2: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    Spacer(minLength: 50)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Your \(Text("Safety Plan").foregroundColor(Color("MindGreen"))) will include")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundColor(Color("MindBlack"))
                                Spacer()
                                VStack(alignment: .leading, spacing: 40) {
                                    HStack(spacing: 20) {
                                        Image(systemName: "tray.full")
                                            .foregroundColor(Color("MindGreen"))
                                            .frame(width: 70.0)
                                            .font(.system(size: 36, weight: .regular))
                                        Text("Coping strategies")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(Color("MindBlack"))
                                    }
                                    HStack(spacing: 20) {
                                        Image(systemName: "person.2.wave.2")
                                            .foregroundColor(Color("MindGreen"))
                                            .frame(width: 70.0)
                                            .font(.system(size: 36, weight: .regular))
                                        Text("Alerting your emergency contact(s)")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(Color("MindBlack"))
                                    }
                                    HStack(spacing: 20) {
                                        Image(systemName: "cross.case")
                                            .foregroundColor(Color("MindGreen"))
                                            .frame(width: 70.0)
                                            .font(.system(size: 36, weight: .regular))
                                        Text("Alerting medical emergency services")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(Color("MindBlack"))
                                    }
                                    
                                }
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: WelcomeView_3(), tag: 1, selection: $selection) {
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

struct WelcomeView_2_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView_2()
    }
}
