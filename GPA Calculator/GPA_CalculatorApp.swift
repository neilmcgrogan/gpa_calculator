//
//  GPA_CalculatorApp.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

@main
struct GP_TestApp: App {
    var body: some Scene {
        WindowGroup {
            /*
            DataUsageView()
                .environmentObject(ViewRouter())
                .environmentObject(SharedData())
                .environmentObject(EditingData())
                .environmentObject(DataEdit())
                .environmentObject(ShareData())
            */
            
            ZStack {
                Color.offWhite.edgesIgnoringSafeArea(.all)
                
                ViewController()
                    .environmentObject(ViewRouter())
                    //.environmentObject(SharedData())
                    //.environmentObject(EditingData())
                    .environmentObject(DataEdit())
                    .environmentObject(ShareData())
            }
        }
    }
}

struct DataUsageView: View {
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    @State var semesterIndex = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            // Add Data
            Group {
                Button("Add Data") {
                    addJunkData()
                }
            }
            
            Divider()

            // View Data / select semester
            Group {
                if data.Semesters().count > 0 {
                    ForEach(0...data.Semesters().count - 1, id: \.self) { index in
                        Button(action: {
                            print("Index: \(semesterIndex)")
                            print("\(data.Semesters()[index])")
                            
                            semesterIndex = data.Semesters()[index]
                        }) {
                            Text("Semester: \(data.Semesters()[index])")
                        }
                    }
                }
            }
            
            Button(action: {
                print(Set(data.Semesters()))
                print(Set(data.Semesters()))
            }) {
                Text("show")
            }
            
            Divider()
            
            // View Data / select class
            Group {
                ForEach(data.courses) { course in
                    if semesterIndex == course.semesterName {
                        Button(action: {
                            dataEdit.coursePointer = course.id
                        }) {
                            Text("ID: \(course.id)... \(course.semesterName).").font(.footnote).padding(.trailing)
                        }
                    }
                }
            }
            
            Divider()
            
            // Find Course Point For Delete Data
            Group {
                ForEach(data.courses) { course in
                    if dataEdit.coursePointer == course.id {
                        Button(action: {
                            deleteCourseAtPoint()
                        }) {
                            Text("ID: \(course.id)... \(course.semesterName).").font(.footnote).padding(.trailing)
                        }
                    }
                }
            }
            
            
        }.padding()
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
    
    func addJunkData() {
        data.courses.append(CourseModel(id: 1, name: "scie 1", grade: "A", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 2, name: "math 1", grade: "B", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 3, name: "engl 1", grade: "C", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 4, name: "lite 1", grade: "D", credits: 4, semesterName: "Fall 2019"))
        
        
        data.courses.append(CourseModel(id: 5, name: "scie 2", grade: "A", credits: 4, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 6, name: "math 2", grade: "B", credits: 4, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 7, name: "engl 2", grade: "C", credits: 4, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 8, name: "lite 2", grade: "D", credits: 4, semesterName: "Spring 2020"))
        
        data.courses.append(CourseModel(id: 9, name: "scie 3", grade: "A", credits: 4, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 10, name: "math 3", grade: "B", credits: 4, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 11, name: "engl 3", grade: "C", credits: 4, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 12, name: "lite 3", grade: "D", credits: 4, semesterName: "Summer 2020"))
    }
}
