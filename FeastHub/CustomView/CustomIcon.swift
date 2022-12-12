//
//  CustomIcon.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import SwiftUI

struct CustomIcon: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
        }
    }
}
