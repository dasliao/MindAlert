//
//  UserSetting.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import Foundation

final class UserSetting: ObservableObject {
    @Published var settings: [TheUser] = load("userdata.json")
}

