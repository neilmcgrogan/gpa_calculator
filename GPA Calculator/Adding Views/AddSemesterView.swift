//
//  AddSemesterView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct AddSemesterView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    @State var selected = 0
    @State var semName = ["Fall", "Spring", "Summer"]
    
    @State private var addCourseView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if dataEdit.semesterIndex == "" {
                Text("Add a semester")
                    .bold().font(.title)
                    .foregroundColor(.grayText)
                
                Button("<- Cancel") {
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                    
                    dataEdit.semesterIndex = ""
                }.buttonStyle(BackButton())
                
                Divider()
                
                Spacer()
                
                Text("Pick a semester")
                    .bold()
                    .foregroundColor(.gray)
                
                Picker(selection: $selected, label: Text(""), content: {
                    Text("Fall").tag(0)
                    Text("Spring").tag(1)
                    Text("Summer").tag(2)
                }).pickerStyle(SegmentedPickerStyle())
                
                Text("Pick a year")
                    .bold()
                    .foregroundColor(.gray)
                
                ScrollView(showsIndicators: false) {
                    ForEach(2010...2030, id: \.self) { index in
                        Button("Semester year: \(String(index))") {
                            withAnimation {
                                self.addCourseView = true
                            }
                            
                            dataEdit.semesterIndex = String(semName[selected]) + ", " + String(index)
                        }.padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
            } else {
                Text("\(dataEdit.semesterIndex)")
                    .bold().font(.title)
                    .foregroundColor(.grayText)
                
                Button("<- Cancel") {
                    withAnimation {
                        viewRouter.currentPage = .homeView
                    }
                    
                    dataEdit.semesterIndex = ""
                }.buttonStyle(BackButton())
                
                Divider()
                
                if addCourseView {
                    Text("courses in semester")
                        .bold()
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Group {
                                ForEach(data.courses) { course in
                                    if dataEdit.semesterIndex == course.semesterName {
                                        SmallCourseTile(grade: course.grade, name: course.name, credits: course.credits)
                                    }
                                }
                            }
                        }
                    }
                    
                    AddCourseView(addCourseView: self.$addCourseView)
                } else {
                    Text("courses in semester")
                        .bold()
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button("Finalize semester") {
                                withAnimation {
                                    viewRouter.currentPage = .homeView
                                }
                                
                                dataEdit.semesterIndex = ""
                            }.padding(5)
                            .frame(width: 125, height: 125, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            ForEach(data.courses) { course in
                                if dataEdit.semesterIndex == course.semesterName {
                                    CourseTile(grade: course.grade, name: course.name, credits: course.credits)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button("Add a new course") {
                            withAnimation {
                                self.addCourseView.toggle()
                            }
                        }.buttonStyle(ForwardButton())
                    }.padding()
                }
                
                Spacer()
            }
        }.padding()
    }
}
