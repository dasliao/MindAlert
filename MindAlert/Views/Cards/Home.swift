//
//  Home.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct Home: View {
    @State var selection: Int? = nil
    var numToSms = "+16503814878"
    var message = "Hello AL. I am not ok right now. I already contacted professional services, but you can help me by going through this process with me. Are you available to help me right now?"
    var phoneNumber = "999111"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Hello \(Text("Kim!").foregroundColor(Color("MindGreen")))")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 40)
                Text("Press the Button for 3 Second\nto activate your \(Text("Safety Plan").font(.system(size: 20, weight: .bold))).")
                    .font(.system(size: 20))
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        let tel = "tel://"
                        let telFormatted = tel + phoneNumber
                        guard let url = URL(string: telFormatted) else { return }
                        UIApplication.shared.open(url)
//                        let sms = "sms:\(numToSms)&body=\(message)"
//                        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//                        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
                    } label: {
                        Image("TheButtonLarge")
                    }
                    
                    Spacer()
                }
                
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(height: 90, alignment: .center)
                        
                    HStack {
                        Spacer()
                        Image(systemName: "tray.2")
                        Spacer()
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "person")
                        Spacer()
                    }
                    .foregroundColor(Color("MindWhite"))
                    .font(.system(size: 30))
                    
                }
            }
            .padding()
            .hiddenNavigationBarStyle()
        }
        .hiddenNavigationBarStyle()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
