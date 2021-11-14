//
//  SemesterView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 SemesterView can access:
 
 <- HomeView
 CourseView
 
 */

struct SemesterView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var editingData: EditingData
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("SemesterView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- HomeView") {
                
                withAnimation {
                    viewRouter.currentPage = .homeView
                }
            }.buttonStyle(BackButton())
            
            Button("CourseView ->") {
                
                withAnimation {
                    viewRouter.currentPage = .courseView
                }
            }.buttonStyle(ForwardButton())
            
            Divider()
            
            VStack {
                
                if editingData.editSemMode {
                    Text("Courses for this semseter\n tap one to edit")
                        .font(.title).foregroundColor(.black)
                    
                    ForEach(sharedData.semesters) { semester in
                        if semester.id == editingData.editSemPointer {
                            VStack {
                                HStack {
                                    Text("Semester: \(semester.id): \(semester.semName), \(semester.semYear)")
                                }
                                
                                ForEach(semester.course) { course in
                                    Button(action: {
                                        editingData.editCorMode.toggle()
                                        editingData.editCorPointer = course.id
                                        withAnimation {
                                            viewRouter.currentPage = .courseView
                                        }
                                    }) {
                                        HStack {
                                            Text("ID: \(course.id), ").bold()
                                            
                                            Text("\(course.name), \(course.grade), \(course.credits)").font(.footnote)
                                        }
                                    }
                                }
                                
                                HStack {
                                    Button("Edit Semester Name") {
                                        
                                        print("Rewriting data")
                                        sharedData.semesters[returnSemIndex()].semName = "dufus"
                                    }.padding()
                                    
                                    Button("Delete Semester") {
                                        print("Deleting data")
                                        sharedData.semesters.remove(at: returnSemIndex())
                                        editingData.editSemMode.toggle()
                                    }.padding()
                                }.foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            
        }.padding()
    }
    
    func returnSemIndex() -> Int {
        for index in (0...sharedData.semesters.count) {
            if sharedData.semesters[index].id == editingData.editSemPointer {
                return index
            }
        }
        return 9999
    }
    
    func returnCorIndex() -> Int {
        return 1
    }
}
