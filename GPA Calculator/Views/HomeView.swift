//
//  HomeView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    let homeViewName = "gpcld"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(homeViewName)
                    .font(.title)
                    .foregroundColor(.grayText)
                    .bold()
                
                Spacer()
                
                if gpa() >= 0  {
                    Text("\(gpa(), specifier: "%.4f")")
                        .font(.title)
                        .foregroundColor(.grayText)
                }
            }
            
            Divider()
            
            if data.courses.count == 0 {
                Button("AddJunkData") {
                    addJunkData()
                }.buttonStyle(ButtonUI())
            } else {
                VStack(alignment: .leading) {
                    Text("semesters")
                        .bold()
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<Int(data.Semesters().count), id: \.self) { index in
                                VStack {
                                    Button(action: {
                                        dataEdit.semesterIndex = data.Semesters()[index]
                                        
                                        withAnimation() {
                                            viewRouter.currentPage = .semesterView
                                        }
                                    }) {
                                        SemesterTile(GPA: filterGPA(filter: data.Semesters()[index]), semester: data.Semesters()[index], creditsTaken: (filterTotalCredits(filter: data.Semesters()[index])), creditsEarned: (filterEarnedCredits(filter: data.Semesters()[index])))
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("projections")
                        .bold()
                        .foregroundColor(.gray)
                    
                    HomeTile()
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button("Add a new semester") {
                    withAnimation {
                        viewRouter.currentPage = .addSemesterView
                    }
                }.buttonStyle(ForwardButton())
            }.padding()
        }.padding()
        .onAppear() {
            data.getItems()
        }
    }
    
    func gpa() -> Float {
        return earnedCredits() / Float(totalCredits())
    }
    
    func filterGPA(filter: String) -> Float {
        return filterEarnedCredits(filter: filter) / filterTotalCredits(filter: filter)
    }
    
    func filterTotalCredits(filter: String) -> Float {
        var credits: Float = 0
        
        for course in data.courses {
            if course.semesterName == filter {
                credits += Float(course.credits)
            }
        }
        
        return credits
    }
    
    func filterEarnedCredits(filter: String) -> Float {
        var gpaArr: Float = 0.0000
        var earnedCredits: Float = 0.0000
        
        for course in data.courses {
            if course.semesterName == filter {
                switch course.grade {
                case "A":
                    gpaArr = 4.0000
                case "A-":
                    gpaArr = 3.6667
                case "B+":
                    gpaArr = 3.3333
                case "B":
                    gpaArr = 3.0000
                case "B-":
                    gpaArr = 2.6667
                case "C+":
                    gpaArr = 2.3333
                case "C":
                    gpaArr = 2.0000
                case "C-":
                    gpaArr = 1.6667
                case "D+":
                    gpaArr = 1.3333
                case "D":
                    gpaArr = 1.0000
                case "D-":
                    gpaArr = 0.6667
                case "F":
                    gpaArr = 0.0000
                default:
                    gpaArr = 0.0000
                }
            }
            
            earnedCredits += (gpaArr * Float(course.credits))
            
            gpaArr = 0
        }
        
        return earnedCredits
    }
    
    func totalCredits() -> Int {
        var credits = 0
        
        for course in data.courses {
            credits += course.credits
        }
        
        return credits
    }
    
    func earnedCredits() -> Float {
        var gpaArr: Float = 0.0000
        var earnedCredits: Float = 0.0000
        
        for course in data.courses {
            switch course.grade {
            case "A":
                gpaArr = 4.0000
            case "A-":
                gpaArr = 3.6667
            case "B+":
                gpaArr = 3.3333
            case "B":
                gpaArr = 3.0000
            case "B-":
                gpaArr = 2.6667
            case "C+":
                gpaArr = 2.3333
            case "C":
                gpaArr = 2.0000
            case "C-":
                gpaArr = 1.6667
            case "D+":
                gpaArr = 1.3333
            case "D":
                gpaArr = 1.0000
            case "D-":
                gpaArr = 0.6667
            case "F":
                gpaArr = 0.0000
            default:
                gpaArr = 0.0000
            }
            
            earnedCredits += (gpaArr * Float(course.credits))
            
            gpaArr = 0
        }
        
        return earnedCredits
    }
    
    func addJunkData() {
        data.courses.append(CourseModel(id: 1001, name: "scie 1", grade: "A", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 1002, name: "math 1", grade: "A-", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 1003, name: "engl 1", grade: "B+", credits: 4, semesterName: "Fall 2019"))
        data.courses.append(CourseModel(id: 1004, name: "lite 1", grade: "B", credits: 4, semesterName: "Fall 2019"))
        
        
        data.courses.append(CourseModel(id: 1005, name: "scie 2", grade: "A-", credits: 5, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 1006, name: "math 2", grade: "B+", credits: 5, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 1007, name: "engl 2", grade: "B", credits: 5, semesterName: "Spring 2020"))
        data.courses.append(CourseModel(id: 1008, name: "lite 2", grade: "B-", credits: 5, semesterName: "Spring 2020"))
        
        data.courses.append(CourseModel(id: 1009, name: "scie 3", grade: "B+", credits: 6, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 1010, name: "math 3", grade: "B", credits: 6, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 1011, name: "engl 3", grade: "B-", credits: 6, semesterName: "Summer 2020"))
        data.courses.append(CourseModel(id: 1012, name: "lite 3", grade: "C+", credits: 6, semesterName: "Summer 2020"))
        
        data.courses.append(CourseModel(id: 1013, name: "cpp 4", grade: "A-", credits: 4, semesterName: "Fall 2021"))
        data.courses.append(CourseModel(id: 1014, name: "algorithms 4", grade: "A", credits: 3, semesterName: "Fall 2021"))
        
        dataEdit.semesterIndex = ""
    }
}


/*
 
 
 func gpa() -> Float {
     
     return 4.000
 }
 
 func totalCredits(semester: Semester) -> Int {
     var credits = 0
     
     for index in (0...semester.course.count - 1) {
         credits += semester.course[index].credits
     }
     
     return credits
 }
 
 func earnedCredits(semester: Semester) -> Float {
     var gpaArr: Float = 0.0000
     var earnedCredits: Float = 0.0000
     
     for index in (0...semester.course.count - 1) {
         switch semester.course[index].grade {
         case "A":
             gpaArr = 4.0000
         case "A-":
             gpaArr = 3.6667
         case "B+":
             gpaArr = 3.3333
         case "B":
             gpaArr = 3.0000
         case "B-":
             gpaArr = 2.6667
         case "C+":
             gpaArr = 2.3333
         case "C":
             gpaArr = 2.0000
         case "C-":
             gpaArr = 1.6667
         case "D+":
             gpaArr = 1.3333
         case "D":
             gpaArr = 1.0000
         case "D-":
             gpaArr = 0.6667
         case "F":
             gpaArr = 0.0000
         default:
             gpaArr = 0.0000
         }
         
         earnedCredits = earnedCredits + (gpaArr * Float(semester.course[index].credits))
         
         gpaArr = 0
     }
     
     return earnedCredits
 }
 
 
 
 */
