//
//  TabButton.swift
//  ResizableTopBar
//
//  Created by 中筋淳朗 on 2020/11/25.
//

import SwiftUI

struct TabButton: View {
    
    // MARK: - Property
    
    var title: String
    
    var index: Int
    
    @Binding var selected: Int
    
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) { 
                selected = index
            }
        }, label: {
            Text(title)
                .font(.system(size: 16, weight: .black))
                .foregroundColor(selected == index ? .blue : .gray)
        })
    }
}

// MARK: - Preview

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
