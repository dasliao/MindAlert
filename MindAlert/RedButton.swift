//
//  RedButton.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import Foundation
import SwiftUI

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .padding(.horizontal, 30)
            .background(configuration.isPressed ? Color("MindLightPeach") : Color("MindPeach"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.system(size: 20, weight: .semibold))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
            .frame(height: 60, alignment: .center)
    }
}

struct RedButton911: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .padding(.leading, 20)
            .padding(.trailing, 150)
            .background(configuration.isPressed ? Color("MindLightPeach") : Color("MindPeach"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.system(size: 20, weight: .semibold))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
            .frame(height: 60, alignment: .center)
    }
}

struct RedButtonOtherWay: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .padding(.leading, 20)
            .background(configuration.isPressed ? Color("MindPeach") : Color("MindLightPeach"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.system(size: 20, weight: .semibold))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
            .frame(height: 60, alignment: .center)
    }
}

