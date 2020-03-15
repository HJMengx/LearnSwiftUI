//
//  detailDataStore.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/12.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI
import Combine

class detailDataStore: ObservableObject {
    @Published var datas: [DetailData] = detailDatas
}

