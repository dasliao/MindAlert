//
//  LoadingView.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .ignoresSafeArea()
            VStack {
                Image("Logo_Color")
                HStack {
                    Text("Mind")
                        .font(.title .bold())
                        .foregroundColor(Color(red: 0.459, green: 0.604, blue: 0.42))
                    Text("Alert")
                        .font(.title .bold())
                        .foregroundColor(Color(red: 0.929 , green: 0.682, blue:0.580))
                }
                
            }
        }
        
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
