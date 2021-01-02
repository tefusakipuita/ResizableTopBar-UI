//
//  ContentView.swift
//  ResizableTopBar
//
//  Created by 中筋淳朗 on 2020/11/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    
    var screenWidth = UIScreen.main.bounds.width
    var tabSapcerWidth = (UIScreen.main.bounds.width - 372) / 2
    
    @State var dragSwipe: CGFloat = 0
    @State var selected = 0
    
    @State var shouldShow = true
    
    
    // MARK: - Body
    
    var body: some View {
        VStack (spacing: 0) {
            
            if shouldShow {
                // MARK: - Top Title & Buttons
                HStack (spacing: 12) {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                    })
                    
                    Spacer()
                    
                    Text("めたもん")
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundColor(Color.black.opacity(0.9))
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 24))
                    })
                } //: HStack
                .padding()
                .padding(.bottom, 10)
                .frame(width: screenWidth)
            } //: if
            
            // MARK: - TabBar
            VStack {
                
                // MARK: - Title
                HStack {
                    TabButton(title: "知り合いのフォロワー", index: 0, selected: $selected)
                        .frame(width: 168)
                    Spacer()
                    TabButton(title: "フォロワー", index: 1, selected: $selected)
                        .frame(width: 88)
                    Spacer()
                    TabButton(title: "フォロー中", index: 2, selected: $selected)
                        .frame(width: 88)
                } //: HStack
                .padding(.horizontal, 14)
                
                ZStack (alignment: .leading) {
                    
                    // MARK: - Under Border
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: screenWidth, height: 0.5)
                    
                    // MARK: - Blue Bar
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: selected == 0 ? 168 : 88, height: 3)
                        .padding(.horizontal, 14)
                        .offset(x: -dragSwipe / 3)
                        .offset(x: selected == 0 ? 0 : selected == 1 ? 168 + tabSapcerWidth : 256 + tabSapcerWidth * 2)
                } //: ZStack
            } //: VStack
            .frame(width: screenWidth)
            .padding(.top, shouldShow ? 0 : 16)
            
            // MARK: - Contents
            HStack (spacing: 0) {
                PageView(imageName: "slowpoke", userName: "やどん", userId: "@Slowpoke", bio: "泳ぐのはあまり得意ではなく、水辺に尻尾を垂らして釣りをすることで餌をとっている。尻尾の先端からはうま味成分がにじみ出ており、これで獲物を食いつかせる。 稀にシェルダーが食いつく時があり、その際にはヤドランへと進化する。ヤドンの痛覚はとても鈍く、叩かれても5秒たってようやく痛みを感じるほど。 尻尾に至っては皆無に等しく、噛みつかれても痛みを感じない。", shouldShow: $shouldShow)
                PageView(imageName: "psyduck", userName: "こだっく", userId: "@Psyduck", bio: "ふしぎな ちからを もっているが つかったときの きおくが ないので いつも くびを かしげている。", shouldShow: $shouldShow)
                PageView(imageName: "snorlax", userName: "かびごん", userId: "@Snorlax", bio: "1にちに たべものを 400キロ たべないと きが すまない。たべおわると ねむってしまう。", shouldShow: $shouldShow)
            } //: HStack
            .offset(x: screenWidth)
            .offset(x: dragSwipe)
            .offset(x: -screenWidth * CGFloat(selected))
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onChanged({ value in
                        onChanged(swipeWidth: value.translation.width)
                    })
                    .onEnded({ value in
                        onEnded(swipeWidth: value.translation.width)
                        
                    })
            ) //: gesture
            
            
            // MARK: - 2. Scroll Pattern
            
            Spacer()
        } //: VStack
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    // MARK: - Function
    
    func onChanged(swipeWidth: CGFloat) {
        dragSwipe = swipeWidth
//        barSwipe = swipeWidth / 3
    }
    
    func onEnded(swipeWidth: CGFloat) {
        withAnimation(.spring()) {
            // 右スワイプ
            if swipeWidth <= -screenWidth * 0.4 {
                if selected == 2 {
                    dragSwipe = 0
                } else {
                    dragSwipe = 0
                    selected += 1
                }
            }
            
            // 左スワイプ
            if swipeWidth >= screenWidth * 0.4 {
                if selected == 0 {
                    dragSwipe = 0
                } else {
                    dragSwipe = 0
                    selected -= 1
                }
            }
            
            // 現状維持
            if swipeWidth > -screenWidth / 3 && screenWidth > swipeWidth {
                dragSwipe = 0
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
