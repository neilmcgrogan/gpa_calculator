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
                        
                        Text("Checking that variables will line up...")
                        
                        Text("Pointer for : \(editingData.editCorPointer)")
                        Text("Course ID: \(course.id)")
                        
                        Text("Pointer: \(course.id)")
                        
                        Button("SHow adat") {
                            // problem: the two aren't equal
                            if sharedData.semesters[editingData.editSemPointer - 1].course.count >= editingData.editCorPointer - 1 {
                                print("deletion spot: \(sharedData.semesters[editingData.editSemPointer - 1].course[editingData.editCorPointer - 1])")
                                print("Full array: \(sharedData.semesters[editingData.editSemPointer - 1].course)")
                            }
                        }
                        
                        Button("Delete this semester") {
                            if sharedData.semesters[editingData.editSemPointer - 1].course.count > 0 {
                                // Not a prefered method
                                //sharedData.semesters[editingData.editSemPointer - 1].course.remove(at: editingData.editCorPointer - 1)
                                
                                // Do this instead
                                //print("Deleting data")
                                //sharedData.semesters.remove(at: returnSemIndex())
                                //editingData.editSemMode.toggle()
                                
                                // returnCorIndex()
                                
                                // Solution
                                sharedData.semesters[editingData.editSemPointer - 1].course.remove(at: returnCorIndex())
                                
                                withAnimation {
                                    viewRouter.currentPage = .semesterView
                                }
                            } else {
                                print("Out of index, cannot delete")
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
}
