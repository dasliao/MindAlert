//
//  GreenButton.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import Foundation
import SwiftUI

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .padding(.horizontal, 60)
            .background(configuration.isPressed ? Color("MindLightGreen") : Color("MindGreen"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.system(size: 20, weight: .semibold))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
            .frame(width:300, height: 60, alignment: .center)
    }
}
