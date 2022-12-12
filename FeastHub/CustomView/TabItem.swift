//
//  TabItem.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import SwiftUI

struct TabItem: View {
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
}
