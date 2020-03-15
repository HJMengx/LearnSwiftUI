//
//  Navigation.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/11.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI

struct Navigation: View {
    
    @ObservedObject var store = detailDataStore()
    
    func addData() {
        self.store.datas.append(DetailData.init(title: "New Item", detail: "Just Add it", image: Image("Card2"), date: "Now"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.store.datas) { item in
                    NavigationLink(destination: NavigationDetail(data: item).navigationBarTitle("I am title", displayMode: .inline)) {
                        HStack {
                            item.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                
                                Text(item.title)
                                    .font(.system(size: 16, weight: Font.Weight.bold, design: Font.Design.rounded))
                                
                                Text(item.detail)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                
                                
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onMove(perform: { (source: IndexSet, destination: Int) in
                    self.store.datas.move(fromOffsets: source, toOffset: destination)
                })
                .onDelete(perform: { index in
                    self.store.datas.remove(at: index.first!)
                })
            }
            .navigationBarTitle(Text("Selected"))
            .navigationBarItems(leading:  Button(action: addData) {
                Text("Add Data")
            }, trailing: EditButton())
        }
    }
}

struct DetailData: Identifiable {
    var id = UUID()
    var title: String
    var detail: String
    var image: Image
    var date: String
}
 
let detailDatas = [
    DetailData(title: "SwiftUI", detail: "That is very handsome framework. just use it, you will love it.", image: Image("Card1"), date: "2020-3-2"),
    DetailData(title: "SwiftUI", detail: "That is very handsome framework. just use it, you will love it.", image: Image("Card1"), date: "2020-3-2"),
    DetailData(title: "SwiftUI", detail: "That is very handsome framework. just use it, you will love it.", image: Image("Card1"), date: "2020-3-2"),
    DetailData(title: "SwiftUI", detail: "That is very handsome framework. just use it, you will love it.", image: Image("Card1"), date: "2020-3-2"),
    DetailData(title: "SwiftUI", detail: "That is very handsome framework. just use it, you will love it.", image: Image("Card1"), date: "2020-3-2")
]

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
