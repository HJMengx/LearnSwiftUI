//
//  NavigationDetail.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/12.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI

struct NavigationDetail: View {
    
    var data: DetailData = detailDatas[0]
    
    var body: some View {
        
//        List {
            VStack {
                data.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(data.detail)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
//        }
//        .listStyle(DefaultListStyle())
//        .navigationBarTitle(data.title)
    }
}

struct NavigationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDetail()
    }
}
