//
//  CourseView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 CourseView can access:
 
 <- SemesterView
 
 */

struct CourseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var editingData: EditingData
    
    var body: some View {
        VStack {
            Text("CourseView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- SemesterView") {
                withAnimation {
                    viewRouter.currentPage = .semesterView
                }
            }.buttonStyle(BackButton())
            
            Divider()
            
            Text("Course pointer: \(editingData.editCorPointer)")
            
            ForEach(sharedData.semesters) { semester in
                ForEach(semester.course) { course in
                    if editingData.editCorPointer == course.id {
                        Text("Course: \(course.id), \(course.name), \(course.grade)")
                        
                        Button("Delete this semester") {
                            deleteCourse()
                            
                            withAnimation {
                                viewRouter.currentPage = .semesterView
                            }
                        }.padding()
                    }
                }
            }
        }.padding()
    }
    
    func returnCorIndex() -> Int {
        for index in (0...sharedData.semesters.count - 1) {
            for indexCour in (0...sharedData.semesters[index].course.count - 1) {
                if sharedData.semesters[index].course[indexCour].id == editingData.editCorPointer {
                    return indexCour
                }
            }
        }
        return 9999
    }
    
    func deleteCourse() {
        sharedData.semesters[editingData.editSemPointer - 1].course[returnCorIndex()].name = "[DLT]"
        sharedData.semesters[editingData.editSemPointer - 1].course[returnCorIndex()].grade = ""
        sharedData.semesters[editingData.editSemPointer - 1].course[returnCorIndex()].credits = 0
    }
}
