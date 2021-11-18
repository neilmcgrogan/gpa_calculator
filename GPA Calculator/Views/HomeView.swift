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
 TODO
 - Build out container sem viewer tiles
 - Add method of saving user data
 - Implement math
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
            
            Button("AddCourseView -->") {
                
                withAnimation {
                    viewRouter.currentPage = .addCourseView
                }
            }.buttonStyle(ForwardButton())
            
            VStack {
                
                Text("Select from the following semesters")
                
                SemesterTile(GPA: 3.667, semName: "Winter", semYear: 2022, creditsTaken: 12, creditsEarned: 45.0000)
                
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
