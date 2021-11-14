//
//  AddSemesterView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 AddSemesterView can access:
 
 <-HomeView
 AddCourseView
 
 */

struct AddSemesterView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        // TODO: fix view
        
        Text("addSemesterView One")
        
        /*
        VStack {
            Text("AddSemesterView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- HomeView") {
                withAnimation {
                    viewRouter.currentPage = .homeView
                }
            }.buttonStyle(BackButton())
            
            Button("AddCourseView ->") {
                withAnimation {
                    viewRouter.currentPage = .addCourseView
                }
            }.buttonStyle(ForwardButton())
            
            Divider()
            
            Text("you are on \(sharedData.semName), \(sharedData.semYear)").font(.title).foregroundColor(.black)
            
            ForEach(sharedData.semesters) { semester in
                HStack {
                    Text("\(semester.semName), \(semester.semYear)").font(.headline)
                }
                
                ForEach(semester.course) { course in
                    Text("\(course.id): \(course.name), \(course.grade), \(course.credits)").font(.footnote)
                }
            }
            
            if sharedData.semName == "" && sharedData.semYear == 0 {
                Button("Declare semester as 'semYear' 'xxxx'") {
                    sharedData.semName = "Winter"
                    sharedData.semYear = Int.random(in: 2010..<2025)
                }.foregroundColor(.blue)
            }
            
            if sharedData.course.count > 0 {\
                //Text("Courses Declared To be finalized for semester")
                
                ForEach(sharedData.course) { course in
                    
                    HStack {
                        Text("\(course.id) \(course.name):").bold()
                        Text("\(course.grade), \(course.credits)")
                    }
                }
                Button("Finalize semester") {
                    finalizeSemester()
                }.buttonStyle(BackButton())
            }
        }*/
    }
    
    func finalizeSemester() {
        sharedData.semesterUID += 1
        
        sharedData.semesters.append(Semester(id: sharedData.semesterUID, course: sharedData.course, semName: sharedData.semName, semYear: sharedData.semYear))
        sharedData.course.removeAll()
    }
}
