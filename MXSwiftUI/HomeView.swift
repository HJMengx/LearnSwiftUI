//
//  HomeView.swift
//  MXSwiftUI
//
//  Created by 贺靖 on 2020/3/10.
//  Copyright © 2020 贺靖. All rights reserved.
//

import SwiftUI

let screen = UIScreen.main.bounds.size

struct HomeView: View {
    
    @State var showProfile = false
    
    @State var movePosition = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HomeTopView(showProfile: $showProfile)
                    .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .clipShape(RoundedRectangle.init(cornerRadius: 20.0, style: RoundedCornerStyle.continuous))
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: self.showProfile ? -400 : 0)
                    .scaleEffect(self.showProfile ? 0.9 : 1)
                    .rotation3DEffect(Angle.init(degrees: self.showProfile ? Double(self.movePosition.height / 10) - 10.0 : 0), axis: (x: 10, y: 0, z: 0))
                    .animation(.linear)
                
                
            }
            
            
            
            MenuView()
                .offset(y: self.showProfile ? 0 : screen.height)
                .offset(y: self.movePosition.height)
                .animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged({
                            (value) in
                            self.movePosition = value.translation
                        })
                        .onEnded({ (value) in
                            if self.movePosition.height > 50 {
                                // 关闭
                                self.showProfile = false
                            }
                            self.movePosition = .zero
                        })
                )
        }
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Image("Avatar")
            .renderingMode(.original)
            .resizable()
            .frame(width: 32, height: 32)
            .clipShape(Circle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeTopView: View {
    @Binding var showProfile: Bool
    @State var showContent: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    HStack {
                        Text("Mengx")
                            .font(.title)
                            .fontWeight(Font.Weight.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            self.showProfile.toggle()
                        }) {
                            AvatarView(showProfile: $showProfile)
                        }
                        
                        Button(action: {
                            self.showContent.toggle()
                        }) {
                            Image(systemName: "bell")
                                .renderingMode(Image.TemplateRenderingMode.original)
                                .font(.system(size: 16, weight: Font.Weight.medium))
                                .frame(width: 36, height: 36)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        }
    //                    .sheet(isPresented: $showContent) {
    //                        Navigation()
    //                    }
                        
                    }
                    .padding(.top, 44)
                    .padding(.horizontal, 20)
                    
                    ProgressInfoView(show: .constant(true), progress: progress)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(sectionData) {item in
                                // 读取包含控件的坐标系(Frame, Bounds, Size, Position, Center)等值
                                GeometryReader { gemotry in
                                    SectionView(section: item)
                                        .rotation3DEffect(Angle(degrees: Double((gemotry.frame(in: .global).minX - 20) / -20)), axis: (x: 0, y: 10, z: 0))
                                }
                                .frame(width: 275, height: 275)
                            }
                        }
                    }
                    .padding()
                    
                    // Complete Bottom Part
                    HStack {
                        Text("Courses")
                            .font(.title).bold()
                        Spacer()
                    }
                    .padding(.leading, 30)
                    
                    SectionView(section: sectionData[2], width: 200)
                    
                    Spacer()
                }
                
                if self.showContent {
                    Color.white.edgesIgnoringSafeArea(Edge.Set.all)
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                               
                        }
                        Spacer()
                    }
                    .offset(x: -16, y: 44)
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                    .onTapGesture {
                        self.showContent = false
                    }
                    
                    ContentView()
                        .offset(x: 0, y: self.showContent ? 44 : UIScreen.main.bounds.height)
                        .animation(.linear)
                }
                
            }
        }
    }
}

struct SectionView: View {
    var section: Section
    
    var width: CGFloat = 160
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack {
                Text(section.title)
                    .frame(width: width, alignment: .leading)
                    .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.content.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.1), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    
    var title: String
    var content: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Do Something Without thinking about the result", content: "36 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "Do Something Without thinking about the result", content: "36 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card3")),
    Section(title: "Do Something Without thinking about the result", content: "36 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card2"))
]


//#imageLiteral(resourceName: <#T##String#>)
//#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
