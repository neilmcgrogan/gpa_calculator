//
//  AddSemesterView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

/*
 
 AddSemesterView can access:
 
 <-HomeView
 AddCourseView
 
 */

struct AddSemesterView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("AddSemesterView")
                .font(.title)
                .foregroundColor(.grayText)
            
            Button("<- HomeView") {
                withAnimation {
                    viewRouter.currentPage = .homeView
                }
            }.buttonStyle(BackButton())
            
            Button("AddCourseView ->") {
                withAnimation {
                    viewRouter.currentPage = .addCourseView
                }
            }.buttonStyle(ForwardButton())
            
            Divider()
            
            Text("you are on \(sharedData.semName), \(Int(sharedData.semYear))").font(.title).foregroundColor(.black)
            
            
            if sharedData.course.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sharedData.course) { course in
                            CourseTile(grade: course.grade, name: course.name, credits: course.credits)
                        }
                    }
                }
                
                Divider()
                
                HStack {
                    SemesterTile(GPA: gpa(), semName: sharedData.semName, semYear: sharedData.semYear, creditsTaken: totalCredits(), creditsEarned: earnedCredits())
                    
                    if sharedData.semName == "" && sharedData.semYear == -1 {
                        Button("Declare semester as 'semYear' 'xxxx'") {
                            sharedData.semName = "Winter"
                            sharedData.semYear = Int.random(in: 2010..<2025)
                        }.foregroundColor(.blue)
                    } else {
                        Button("Finalize semester") {
                            finalizeSemester()
                            
                            withAnimation {
                                viewRouter.currentPage = .homeView
                            }
                        }.buttonStyle(BackButton())
                    }
                }
            }
        }
    }
    
    func finalizeSemester() {
        sharedData.semesterUID += 1
        
        sharedData.semesters.append(Semester(id: sharedData.semesterUID, course: sharedData.course, semName: sharedData.semName, semYear: sharedData.semYear))
        sharedData.course.removeAll()
        
        sharedData.semName = ""
        sharedData.semYear = 0
    }
    
    func totalCredits() -> Int {
        var credits = 0
        
        for index in (0...sharedData.course .count - 1) {
            credits += sharedData.course[index].credits
        }
        return credits
    }
    
    func earnedCredits() -> Float {
        var gpaArr: Float = 0.0000
        var earnedCredits: Float = 0.0000
        
        for index in (0...sharedData.course .count - 1) {
            switch sharedData.course[index].grade {
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
            
            earnedCredits = earnedCredits + (gpaArr * Float(sharedData.course[index].credits))
            
            gpaArr = 0
        }
        
        return earnedCredits
    }
    
    func gpa() -> Float {
        return earnedCredits() / Float(totalCredits())
    }
}
