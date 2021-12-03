//
//  SettingsView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Settings")
                    .bold()
                    .font(.title)
                    .foregroundColor(.grayText)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.buttonColor)
                }
            }
            
            Divider()
            
            Text("your data")
                .bold()
                .foregroundColor(.gray)
            
            LargeTile()
            
            Text("options")
                .bold()
                .foregroundColor(.gray)
            
            Button("Clear Data") {
                data.courses.removeAll()
            }.buttonStyle(ButtonUI())
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Version 3.1 Released in December, 2021")
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }.padding()
    }
}
