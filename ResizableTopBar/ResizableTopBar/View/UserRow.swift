//
//  UserRow.swift
//  ResizableTopBar
//
//  Created by 中筋淳朗 on 2020/11/26.
//

import SwiftUI

struct UserRow: View {
    
    // MARK: - Property
    
    var screenWidth = UIScreen.main.bounds.width
    
    var imageName: String
    var userName: String
    var userId: String
    var bio: String
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 16) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                
                VStack (alignment: .leading, spacing: 10) {
                    HStack {
                        VStack (alignment: .leading, spacing: 6) {
                            Text(userName)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text(userId)
                                .foregroundColor(Color.black.opacity(0.6))
                        } //: VStack
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("フォロー中")
                                .foregroundColor(.white)
                                .padding(.vertical, 9)
                                .padding(.horizontal, 28)
                                .background(
                                    Color.blue
                                        .clipShape(Capsule())
                                )
                        }) //: Button
                    } //: HStack
                    Text(bio)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                } //: VStack
            } //: HStack
            .padding()
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: screenWidth, height: 0.5)
        } //: VStack
    }
}

// MARK: - Preview

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
