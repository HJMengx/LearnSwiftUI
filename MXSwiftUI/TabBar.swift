//
//  TabBar.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/12.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Person")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 8")
            TabBar().previewDevice("iPhone 11 Max Pro")
        }
    }
}
