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
    @EnvironmentObject var settings: Settings
    @FocusState private var focused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Settings")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.grayText)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.primaryColor)
                }
            }
            
            dataSection
            
            optionsSection
            
            nameSchoolSection
            
            Spacer()
            
            if !focused {
                HStack {
                    Spacer()
                    
                    Text("Version 4.1 September, 2022")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }.padding()
            }
        }.padding()
    }
}

extension SettingsView {
    private var dataSection: some View {
        Group {
            LargeTile()
                .padding(.bottom)
        }
    }
    
    private var optionsSection: some View {
        Group {
            Text("options")
                .bold()
                .foregroundColor(.gray)
            
            Button(action: {
                data.courses.removeAll()
            }) {
                Text("Remove all data")
                    .foregroundColor(Color.primaryColor)
                    .bold()
            }.padding(.bottom)
        }
    }
    
    private var nameSchoolSection: some View {
        Group {
            Group {
                Text("Name")
                    .bold()
                    .foregroundColor(.gray)
                
                TextField("enter your name", text: $settings.name)
                    .focused($focused)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(UIColor.secondarySystemFill))
                    .cornerRadius(10)
                
                if !focused {
                    Text("School type")
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack {
                        Button("high school") {
                            settings.schoolType = "HighSchool"
                        }
                        .foregroundColor(settings.schoolType == "HighSchool" ? Color.white : Color.primaryColor)
                        .padding()
                        .background(settings.schoolType == "HighSchool" ? Color.primaryColor : Color.lightGray)
                        .font(.headline)
                        .cornerRadius(15)
                        
                        Button("college") {
                            settings.schoolType = "College"
                        }
                        .foregroundColor(settings.schoolType == "College" ? Color.white : Color.primaryColor)
                        .padding()
                        .background(settings.schoolType == "College" ? Color.primaryColor : Color.lightGray)
                        .font(.headline)
                        .cornerRadius(15)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewRouter())
            .environmentObject(DataEdit())
            .environmentObject(ShareData())
            .environmentObject(Settings())
    }
}
