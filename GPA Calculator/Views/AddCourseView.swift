//
//  AddCourseView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 AddCourseView can access:
 
 <- AddSemesterView
 
 */

struct AddCourseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var editingData: EditingData
    
    @State private var name = ""
    @State private var grade = ""
    @State private var credits = 0
    
    var body: some View {
        VStack {
            Text("AddCourseView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- AddSemesterView") {
                withAnimation {
                    viewRouter.currentPage = .addSemesterView
                }
            }.buttonStyle(BackButton())
            
            Divider()
            
            Text("you are on \(sharedData.semName), \(sharedData.semYear)").font(.title).foregroundColor(.black)
            
            HStack {
                if self.name != "" && self.grade != "" && self.credits != 0 {
                    CourseTile(grade: self.grade, name: self.name, credits: self.credits)
                    
                    Button("Finalize course") {
                        addCourse()
                        
                        withAnimation {
                            viewRouter.currentPage = .addSemesterView
                        }
                    }.buttonStyle(BackButton())
                } else {
                    Button("add calc") {
                        self.name = "calc"
                        self.grade = "A"
                        self.credits = 4
                    }
                    
                    Button("add engl") {
                        self.name = "engl"
                        self.grade = "B"
                        self.credits = 3
                    }
                    
                    Button("add scie") {
                        self.name = "scie"
                        self.grade = "C"
                        self.credits = 2
                    }
                }
            }
        }
    }
    
    func uniqueIDFunc() -> Int {
        sharedData.courseUID += 1
        return sharedData.courseUID
    }
    
    func addCourse() {
        sharedData.course.append(Course(id: uniqueIDFunc(), name: self.name, grade: self.grade, credits: self.credits))
    }
}

