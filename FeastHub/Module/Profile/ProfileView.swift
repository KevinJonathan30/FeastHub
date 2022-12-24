//
//  ProfileView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 14/12/22.
//

import SwiftUI
import Core

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
                    
                    Text("job_position".localized())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("about_me".localized())
                        .font(.title2)
                    
                    Text("about_description".localized())
                }
            }
            .padding()
        }
        .navigationTitle("my_profile".localized())
    }
}
