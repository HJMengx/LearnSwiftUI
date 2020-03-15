//
//  ContentView.swift
//  DesignCode
//
//  Created by Meng To on 12/16/19.
//  Copyright © 2019 Meng To. All rights reserved.
//

import SwiftUI

// 一定要注意先后顺序
struct ContentView: View {
    
    @State var show = false
    
    @State var movePosition = CGSize.zero
    
    @State var showCard = false
    
    @State var fullText = false
    
    @State var bottomTranslation = CGSize.zero
    
    var body: some View {
        
        ZStack {
            // Top BackView
            TitleView()
                .blur(radius: self.show ? 20 : 0)
                .offset(x: 0, y: self.showCard ? -100 : 0)
                .animation(
                    Animation.default
                        .delay(0.1)
                        .speed(1.2)
                )
            
            // BackGround1
            BackGroundView()
                //
                .background(Color("card4"))
                .cornerRadius(20)
                .offset(x: 0, y: self.show ? -400 : -40)
                .offset(x: self.movePosition.width, y: self.movePosition.height)
                .scaleEffect(0.98)
                .rotationEffect(Angle.init(degrees: self.show ? 0 : 10))
                .rotation3DEffect(Angle.init(degrees: 10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.spring())
            
            // BackGround2
            BackGroundView()
                //
                .background(Color("card3"))
                .cornerRadius(20)
                .offset(x: 0, y: self.show ? -200 : -20)
                .offset(x: self.movePosition.width, y: self.movePosition.height)
                .scaleEffect(0.98)
                .rotationEffect(Angle.init(degrees: self.show ? 0 : 5))
                .rotation3DEffect(Angle.init(degrees: 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.spring())
            
            // Card
            CardView()
            .onTapGesture {
                self.show.toggle()
                self.showCard.toggle()
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black, radius: CGFloat(20))
//            .cornerRadius(20)
                // Through the offset move the card.
            .offset(x: self.movePosition.width, y: self.movePosition.height)
            .gesture(DragGesture.init()
                .onChanged({ (value) in
                    self.movePosition = value.translation
                })
                .onEnded({ (value) in
                    self.movePosition = CGSize.zero
                })
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
            
            // Bottom
            BottomView(show: $showCard)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            // 判断移动距离
                            self.bottomTranslation = value.translation
                            
                            if self.fullText {
                                self.bottomTranslation.height += -300
                            }
                            
                            if self.bottomTranslation.height < -300 {
                                self.bottomTranslation.height = -300
                            }
                        })
                        .onEnded({ (value) in
                            if self.bottomTranslation.height > 50 {
                                // 恢复到底下
                                self.showCard = false
                                self.bottomTranslation = .zero
                            }
                            
                            if (self.bottomTranslation.height < -100 && !self.fullText) || (self.bottomTranslation.height < -250 && self.fullText) {
                                self.bottomTranslation.height = -300
                                self.fullText = true
                                self.showCard = true
                            } else {
                                self.bottomTranslation = .zero
                                self.fullText = false
                            }
                        })
                )
//                .blur(radius: self.show ? 20 : 0)
                .offset(x: 0, y: self.showCard ? UIScreen.main.bounds.height - 400 : UIScreen.main.bounds.height - 300)
                .offset(y: self.bottomTranslation.height)
//                .opacity(self.showCard ? 0.9 : 1)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.3))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackGroundView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 320, height: 200)
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Button")
                    }.frame(width: 100, height: 20, alignment: Alignment.topLeading)
                    Text("Hello, World!").foregroundColor(Color.white)
                }
                .padding(.horizontal, 10)
                .padding(.top, 3)
                Spacer()
                Image("Logo1")
                    .padding()
            }
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill).frame(width: 320, height: 160, alignment: Alignment.top)
        }
        .frame(width: 340, height: 220, alignment: Alignment.center)
        .background(Color.black)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("mengx")
                    .font(.largeTitle)
                    .fontWeight(Font.Weight.bold)
                Spacer()
            }
            .padding(.leading, 10)
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("I am the first batch data, using TCP protocol\n Current Netowrk Status: Fast")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            // RingView
            ProgressInfoView(show: $show, progress: progress)
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)// This height need modify with
    }
}

struct ProgressInfo: Identifiable {
    var id = UUID()
    
    var title: String
    var content: String
}

let progress = ProgressInfo(title: "SwiftUI", content: "12 of 20 sections completed\n10 hours spent so far")

struct ProgressInfoView: View {
    
    @Binding var show: Bool
    
    var progress: ProgressInfo
    
    var body: some View {
        HStack {
            RingView(color1: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), height: 44, width: 44, percent: 60, show: $show)
                .animation(Animation.easeInOut.delay(0.3))
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(progress.title).fontWeight(.bold)
                Text(progress.content)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineSpacing(4)
                    .lineLimit(2)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
    }
}
