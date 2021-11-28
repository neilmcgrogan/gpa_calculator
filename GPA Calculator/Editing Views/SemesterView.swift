//
//  SemesterView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct SemesterView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(dataEdit.semesterIndex)")
                .font(.title)
                .bold()
                .foregroundColor(.grayText)
            
            HStack {
                Button("<- HomeView") {
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                    
                    dataEdit.semesterIndex = ""
                }.buttonStyle(BackButton())
                
                Spacer()
            }
            
            Divider()
            
            Text("courses")
                .bold()
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // View Data / select class
                    Group {
                        ForEach(data.courses) { course in
                            if dataEdit.semesterIndex == course.semesterName {
                                Button(action: {
                                    dataEdit.coursePointer = course.id
                                }) {
                                    CourseTile(grade: course.grade, name: course.name, credits: course.credits)
                                }
                            }
                        }
                    }
                }
            }
            
            Divider()
            
            CourseView()
            
            Spacer()
        }.padding()
    }
}
