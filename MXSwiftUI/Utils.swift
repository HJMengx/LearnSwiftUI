//
//  Utils.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/13.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI

//let screen = UIScreen.main.bounds

func getCardWidth() -> CGFloat {
    if UIScreen.main.bounds.size.width > 712 {
        return 712
    }
    return screen.width - 60
}

func getCardHeight() -> CGFloat {
    if UIScreen.main.bounds.size.width > 712 {
        return 80
    }
    return 280
}

func getAngleMultiplier() -> Double {
    if UIScreen.main.bounds.size.width > 500 {
        return 80
    } else {
        return 20
    }
}
