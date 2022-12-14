//
//  ProfileView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 14/12/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            Group {
                Image("Kevin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 3)
                    }
                    .shadow(radius: 7)
                    
                
                VStack(alignment: .leading) {
                    Text("Kevin Jonathan")
                        .font(.title)
                    
                    Text("iOS Engineer at Blibli.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("About Me")
                        .font(.title2)
                    
                    Text("I am Kevin Jonathan, an ambitious mobile development engineer proficient in iOS app development and Flutter. I have 4+ years of experience in mobile application engineering. I am an alumni from Petra Christian University and Apple Developer Academy.\nI am currently working as an iOS Engineer at Blibli.com!")
                }
            }
            .padding()
        }
        .navigationTitle("My Profile")
    }
}
