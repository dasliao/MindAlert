//
//  CompleteView.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct CompleteView: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("complete")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .center, spacing: 20) {
                                Spacer()
                                VStack(alignment:.center, spacing: 20) {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 70, weight:.light))
                                        .foregroundColor(Color("MindGreen"))
                                    
                                    HStack(spacing: 0) {
                                        Text("You did it ")
                                        Text("Kim")
                                        Text("!")
                                    }
                                }
                                .foregroundColor(Color("MindBlack"))
                                .font(.system(size: 32, weight: .semibold))
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: Home(), tag: 1, selection: $selection) {
                                        Button("Done") {
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

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
