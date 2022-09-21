//
//  AddView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 9/20/22.
//

import Foundation
import SwiftUI

struct AddView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    @EnvironmentObject var viewRouter: ViewRouter
    
    @FocusState private var focused: Bool
    @State private var semester = ""
    @State private var year = 0
    @State private var step = 0
    @State private var name = ""
    @State private var creditHours = 0
    @State private var grade = ""
    @State private var classAdded = false
    @State private var semesterComplete = false
    
    let vm = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            switch step {
            case 0:
                semesterSection
            case 1:
                if classAdded {
                    addedSection
                } else {
                    courseSection
                }
            default:
                Text("error")
            }
            Spacer()
            if !focused {
                navSection
            }
        }.padding(.horizontal)
    }
}

extension AddView {
    private var header: some View {
        HStack {
            Text(step == 0 ? "Course name" : "\(semester), \(String(year))")
                .bold().font(.largeTitle)
                .foregroundColor(.grayText)
            Spacer()
            Button(action: {
                withAnimation {
                    viewRouter.currentPage = .homeView
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(Color.primaryColor)
            }
        }
    }
    
    private var addedSection: some View {
        Group {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data.filteredCourses(semester: "\(self.semester) \(self.year)")) { item in
                        Button("\(item.name), \(item.grade)") {
                        }.buttonStyle(ButtonUI()).padding(.vertical)
                    }
                }
            }
            
            Text("What would you like to do next?")
                .bold()
                .foregroundColor(.gray)
            HStack {
                Button("Add a new class") {
                    self.classAdded = false
                }.buttonStyle(ButtonUI())
                if semesterComplete {
                    Button("Complete semester") {
                        withAnimation {
                            semesterComplete = false
                        }
                    }.buttonStyle(SelectedButtonUI())
                } else {
                    Button("Complete semester") {
                        withAnimation {
                            semesterComplete = true
                        }
                    }.buttonStyle(ButtonUI())
                }
                Spacer()
            }
        }
    }
    
    private var courseSection: some View {
        Group {
            Text(name == "" ? "Let's name this course..." : "Course name")
                .bold()
                .foregroundColor(.gray)
            
            VStack {
                HStack(spacing: 0) {
                    TextField("enter course name", text: $name)
                        .focused($focused)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color(UIColor.secondarySystemFill))
                        .cornerRadius(10)
                    
                    if name != "" {
                        Button(action: {
                            self.name = ""
                        }) {
                            XButton()
                        }
                    }
                }
                
                if name == "" {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .leading, spacing: 10) {
                        ForEach(vm.subjects, id: \.self) { subject in
                            if name == subject {
                                Button("\(String(subject))") { name = subject }
                                    .buttonStyle(SelectedButtonUI())
                                    .padding(4)
                            } else {
                                Button("\(String(subject))") { name = subject }
                                    .buttonStyle(ButtonUI())
                                    .padding(4)
                            }
                        }
                    }.padding(.top)
                }
            }
            
            if name != "" {
                if settings.schoolType == "College" {
                    Text("How many credit hours was this class?")
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack {
                        ForEach((1...5), id: \.self) { num in
                            if creditHours == num {
                                Button("\(String(num))") { creditHours = num }
                                    .buttonStyle(SelectedButtonUI())
                                    .padding(4)
                            } else {
                                Button("\(String(num))") { creditHours = num }
                                    .buttonStyle(ButtonUI())
                                    .padding(4)
                            }
                        }
                    }
                    .padding(.top)
                }
                
                if settings.schoolType != "College" || self.creditHours != 0 {
                    Text("Grade")
                        .bold()
                        .foregroundColor(.gray)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], alignment: .leading, spacing: 10) {
                        ForEach(settings.schoolType == "HighSchool" ? vm.highschoolGrades : vm.collegeGrades, id: \.self) { index in
                            if grade == index {
                                Button("\(String(index))") { grade = index }
                                    .buttonStyle(SelectedButtonUI())
                                    .padding(3)
                            } else {
                                Button("\(String(index))") { grade = index }
                                    .buttonStyle(ButtonUI())
                                    .padding(3)
                            }
                        }
                    }.padding(.top)
                    
                    if settings.schoolType == "College" {
                        if self.creditHours != 0 && self.grade != "" {
                            Text(settings.schoolType == "College" ? "You have an \(grade) in \(name) for \(creditHours) credits" : "You have an \(grade) in \(name)")
                                .bold()
                                .foregroundColor(.gray)
                            HStack {
                                Button("Add this class") {
                                    addCourse()
                                }.buttonStyle(ButtonUI())
                                Spacer()
                            }
                        }
                    } else {
                        if self.grade != "" {
                            Text(settings.schoolType == "College" ? "You have an \(grade) in \(name) for \(creditHours) credits" : "You have an \(grade) in \(name)")
                                .bold()
                                .foregroundColor(.gray)
                            HStack {
                                Button("Add this class") {
                                    addCourse()
                                }.buttonStyle(ButtonUI())
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var semesterSection: some View {
        Group {
            Text("Pick a semester")
                .bold()
                .foregroundColor(.gray)
            
            HStack {
                ForEach(vm.semNames, id: \.self) { name in
                    if semester == name {
                        Button(name) { semester = name }.buttonStyle(SelectedButtonUI())
                    } else {
                        Button(name) { semester = name }.buttonStyle(ButtonUI())
                    }
                }
            }
            
            Text("Pick a year")
                .bold()
                .foregroundColor(.gray)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading, spacing: 5) {
                ForEach((2017...2030), id: \.self) { num in
                    if num == year {
                        Button("\(String(num))") { year = num }
                            .buttonStyle(SelectedButtonUI())
                            .padding(7)
                    } else {
                        Button("\(String(num))") { year = num}
                            .buttonStyle(ButtonUI())
                            .padding(7)
                    }
                    
                }
            }
        }
    }
    
    private var navSection: some View {
        ZStack {
            HStack {
                if step == 1 {
                    Button(action: {
                        self.step -= 1
                    }) {
                        NextButton()
                            .rotationEffect(Angle(degrees: -180))
                    }
                }
                
                Spacer()
                
                if step == 0 {
                    if semester == "" || year == 0 {
                        GrayNextButton()
                    } else {
                        Button(action: {
                            self.step += 1
                        }) {
                            NextButton()
                        }
                    }
                } else if step == 1 {
                    if semesterComplete {
                        Button(action: {
                            viewRouter.currentPage = .homeView
                        }) {
                            DoneButton()
                        }
                    } else {
                        GrayDoneButton()
                    }
                }
            }
            HStack {
                Spacer()
                Capsule().frame(width: step == 0 ? 10 : 6, height: 6).foregroundColor(step == 0 ? Color.primaryColor : Color.gray)
                Capsule().frame(width: step == 1 ? 10 : 6, height: 6).foregroundColor(step == 1 ? Color.primaryColor : Color.gray)
                Spacer()
            }
        }
        .padding(.bottom)
    }
    
    func addCourse() {
        print(dataEdit.courseUID)
        print("add more here")
        data.courses.append(CourseModel(id: dataEdit.uniqueIDFunc(), name: self.name, grade: self.grade, credits: self.creditHours, semesterName: "\(self.semester) \(self.year)"))
        self.name = ""
        self.grade = ""
        self.creditHours = 0
        self.classAdded = true
    }
}

struct AddViewx_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ViewRouter())
            .environmentObject(DataEdit())
            .environmentObject(ShareData())
            .environmentObject(Settings())
    }
}
