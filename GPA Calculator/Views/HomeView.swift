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
    
    let homeViewName = "Fast GPA"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(homeViewName)
                    .font(.title)
                    .foregroundColor(.grayText)
                    .bold()
                
                Spacer()
                
                if data.gpa() >= 0  {
                    Text("\(data.gpa(), specifier: "%.4f")")
                        .font(.title)
                        .foregroundColor(.grayText)
                        .bold()
                }
            }
            
            Divider()
            
            if data.courses.count == 0 {
                Text("Press the '+' in the bottom right to start")
                    .foregroundColor(.black)
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
                    }.padding(-10)
                    
                    Text("summary")
                        .bold()
                        .foregroundColor(.gray)
                    
                    LargeTile()
                        .padding(-10)
                    
                    if data.gpa() < 3.6667 {
                        Text("projections")
                            .bold()
                            .foregroundColor(.gray)
                        
                        ProjectionTile()
                            .padding(-10)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .settingsView
                    }
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.buttonColor)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .addSemesterView
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.buttonColor)
                }
            }.padding()
        }.padding()
        .onAppear() {
            data.getItems()
        }
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
}
