//
//  CustomEmptyView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import SwiftUI

struct CustomEmptyView: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)
            
            Text(title)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
