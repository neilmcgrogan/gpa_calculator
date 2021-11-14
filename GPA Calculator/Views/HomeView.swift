//
//  HomeView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 HomeView can access:
 
 SettingsView
 AddSemesterView
 SemesterView
 
 */

/*
 
 (DONE)Build out full data models
 - Fix indexing issues when adding and deleting courses
 - Place sem & cour into container views
 - Add method of saving user data
 
 FIX INDEXING ISSUES:
 Recreate a simulated model inside HomeView
 Attempt to add appending and deleting functions at particular two dimensional indexes...
 
 */

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var gpaModel: MasterModel
    @EnvironmentObject var editingData: EditingData
    
    var body: some View {
        VStack {
            Text("Home View")
                .font(.title)
                .foregroundColor(.grayText)
            
            Group {
                
                Button("SettingsView ->") {
                    withAnimation {
                        viewRouter.currentPage = .settingsView
                    }
                }.buttonStyle(ForwardButton())
                
                Button("AddSemesterView ->") {
                    withAnimation {
                        viewRouter.currentPage = .addSemesterView
                    }
                }.buttonStyle(ForwardButton())
                
                Button("SemesterView ->") {
                    withAnimation {
                        viewRouter.currentPage = .semesterView
                    }
                }.buttonStyle(ForwardButton())
            }
            
            VStack {
                
                Text("Select from the following semesters")
                
                ForEach(sharedData.semesters) { semester in
                    Button(action: {
                        editingData.editSemMode = true
                        editingData.editSemPointer = semester.id
                        viewRouter.currentPage = .semesterView
                    }) {
                        HStack {
                            Text("\(semester.semName), \(semester.semYear), \(semester.id)").bold()
                            
                            ForEach(semester.course) { course in
                                
                                Text("\(course.id): \(course.name), \(course.grade), \(course.credits)").font(.footnote)
                            }
                        }
                    }
                }
            }
        }.padding()
    }
}
