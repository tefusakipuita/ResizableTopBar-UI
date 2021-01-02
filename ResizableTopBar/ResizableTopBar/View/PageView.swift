//
//  PageView.swift
//  ResizableTopBar
//
//  Created by 中筋淳朗 on 2020/11/26.
//

import SwiftUI

struct PageView: View {
    
    // MARK: - Property
    
    var screenWidth = UIScreen.main.bounds.width
    
    var imageName: String
    var userName: String
    var userId: String
    var bio: String
    
    @Binding var shouldShow: Bool
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 0) {
                
                // ※ ここでスクロールに応じて shouldShow を変更する
                GeometryReader(content: { geometry -> AnyView in
                    let minY = geometry.frame(in: .global).minY
                    
                    // 上スクロール
                    if minY < 70 {
                        // (Scrollで)Viewの更新中に@Stateの変数を変更することはできないので、非同期にして shouldShow を変更する
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                shouldShow = false
                            }
                        }
                    }
                    
                    // 下スクロール
                    if minY >= 70 {
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                shouldShow = true
                            }
                        }
                    }
                    
                    print("minY: \(minY)")
                    
                    return AnyView(
                        Text("")
                            .frame(width: 0, height: 0)
                    )
                })
                
                ForEach(0..<20) { _ in
                    UserRow(imageName: imageName, userName: userName, userId: userId, bio: bio)
                }
            } //: VStack
        } //: Scroll
        .frame(width: screenWidth)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
