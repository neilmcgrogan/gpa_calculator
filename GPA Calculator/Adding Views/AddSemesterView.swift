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
    
    @State private var year = 1

    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.primaryColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.primaryColor)], for: .normal)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if dataEdit.semesterIndex == "" {
                HStack {
                    Text("Add a semester")
                        .bold().font(.title)
                        .foregroundColor(.grayText)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .homeView
                        }
                        
                        dataEdit.semesterIndex = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(Color.primaryColor)
                    }
                }
                
                Divider()
                
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
                
                Picker("", selection: $year) {
                    ForEach(10...30, id: \.self) {
                        Text("'\($0)")
                            .foregroundColor(.black)
                    }
                }.pickerStyle(WheelPickerStyle())
                
                Spacer()
                
                if self.year != 0 {
                    HStack {
                        Spacer()
                        
                        Button("Next") {
                            withAnimation {
                                self.addCourseView = true
                            }
                            
                            dataEdit.semesterIndex = String(semName[selected]) + ", '" + String(self.year)
                        }.buttonStyle(ButtonUI())
                    }
                }
            } else {
                HStack {
                    Text("\(dataEdit.semesterIndex)")
                        .bold().font(.title)
                        .foregroundColor(.grayText)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .homeView
                        }
                        
                        dataEdit.semesterIndex = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(Color.primaryColor)
                    }
                }
                
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
                            Button(action: {
                                withAnimation {
                                    viewRouter.currentPage = .homeView
                                }
                                
                                dataEdit.semesterIndex = ""
                            }) {
                                HStack {
                                    Image(systemName: "checkmark")
                                    
                                    Text("Finalize semester")
                                }.font(.headline)
                            }.padding(5)
                            .foregroundColor(.white)
                            .frame(width: 125, height: 65, alignment: .center)
                            .background(Color.primaryColor)
                            .cornerRadius(15)
                            
                            ForEach(data.courses) { course in
                                if dataEdit.semesterIndex == course.semesterName {
                                    SmallCourseTile(grade: course.grade, name: course.name, credits: course.credits)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.addCourseView.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                
                                Text("Add a new course")
                            }.font(.headline)
                        }.buttonStyle(ButtonUI())
                    }.padding()
                }
            }
        }.padding()
    }
}
