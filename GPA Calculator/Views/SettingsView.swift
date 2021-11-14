//
//  SettingsView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 SettingsView can access:
 
 <-HomeView
 
 */

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("SettingsView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- HomeView") {
                
                withAnimation {
                    viewRouter.currentPage = .homeView
                }
            }.buttonStyle(BackButton())
            
            Divider()
            
        }.padding()
    }
}
