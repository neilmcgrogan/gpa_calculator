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
    
    var body: some View {
        VStack {
            Text("AddSemesterView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- AddSemesterView") {
                withAnimation {
                    viewRouter.currentPage = .addSemesterView
                }
            }.buttonStyle(BackButton())
            
            Divider()
            
            Text("you are on \(sharedData.semName), \(sharedData.semYear)").font(.title).foregroundColor(.black)
            
            Button("Add Junk Data") {
                sharedData.course.append(Course(id: uniqueIDFunc(), name: "courseName", grade: Int.random(in: 80..<100), credits: Int.random(in: 1..<5)))
            }.foregroundColor(.blue)
            
            ForEach(sharedData.course) { item in
                HStack {
                    Text("\(item.id), \(item.name), \(item.grade), \(item.credits)")
                }
            }
            
            Button("Finalize this course for this semester?") {
                withAnimation {
                    viewRouter.currentPage = .addSemesterView
                }
            }.buttonStyle(BackButton())
        }
    }
    
    func uniqueIDFunc() -> Int {
        sharedData.courseUID += 1
        return sharedData.courseUID
    }
}

