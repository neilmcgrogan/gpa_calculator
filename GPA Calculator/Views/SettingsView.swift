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
    
    @State private var name = UserDefaults.standard.string(forKey: "Name") ?? ""
    @State private var schoolType = UserDefaults.standard.string(forKey: "SchoolType") ?? ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Settings")
                    .bold()
                    .font(.title)
                    .foregroundColor(.grayText)
                
                Spacer()
                
                Button(action: {
                    UserDefaults.standard.set(self.name, forKey: "Name")
                    
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.primaryColor)
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
            
            Group {
                Text("Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField("enter your name", text: $name)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(UIColor.secondarySystemFill))
                
                Text("School type")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Button("high school") {
                        self.schoolType = "HighSchool"
                        UserDefaults.standard.set(self.schoolType, forKey: "SchoolType")
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(schoolType == "HighSchool" ? Color.primaryColor : Color.gray)
                    .font(.headline)
                    .cornerRadius(15)
                    
                    Button("college") {
                        self.schoolType = "College"
                        UserDefaults.standard.set(self.schoolType, forKey: "SchoolType")
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(schoolType == "College" ? Color.primaryColor : Color.gray)
                    .font(.headline)
                    .cornerRadius(15)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Version 3.2 Released in January, 2022")
                    .foregroundColor(.gray)
                
                Spacer()
            }.padding()
        }.padding()
    }
}
