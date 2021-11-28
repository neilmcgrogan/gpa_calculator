//
//  CourseView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct CourseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    var body: some View {
        ForEach(data.courses) { course in
            if dataEdit.coursePointer == course.id {
                VStack {
                    CourseTile(grade: course.grade, name: course.name, credits: course.credits)
                    
                    Button(action: {
                        deleteCourseAtPoint()
                    }) {
                        Text("Delete course")
                    }.buttonStyle(ButtonUI())
                    
                    Button(action: {
                        editCourseAtPoint()
                    }) {
                        Text("Edit course")
                    }.buttonStyle(ButtonUI())
                }
            }
        }
    }
    
    func deleteCourseAtPoint() {
        print("should have deleted here")
        
        var courseIndex = 0
        
        for course in data.courses {
            if dataEdit.coursePointer == course.id {
                data.courses.remove(at: courseIndex)
            }
            
            courseIndex += 1
        }
        
        dataEdit.coursePointer = 0
    }
    
    func editCourseAtPoint() {
        print("should have deleted here")
        
        var courseIndex = 0
        
        for course in data.courses {
            if dataEdit.coursePointer == course.id {
                data.courses[courseIndex].credits = 100
                data.courses[courseIndex].name = "covid"
                data.courses[courseIndex].grade = "A"
            }
            
            courseIndex += 1
        }
        
        dataEdit.coursePointer = 0
    }
}
