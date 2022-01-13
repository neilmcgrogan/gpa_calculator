//
//  CourseView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct CourseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    @State private var name = ""
    @State private var credits = 1
    
    @State private var gradeArr = ["A", "B", "C", "D", "F"]
    @State private var symbolArr = ["+", "", "-"]
        
    @State var selectedGrade = 0
    @State var selectedSymbol = 1
    
    let schoolType = UserDefaults.standard.string(forKey: "SchoolType")
    
    var body: some View {
        ForEach(data.courses) { course in
            if dataEdit.coursePointer == course.id {
                Divider()
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    HStack {
                        TextField("enter course name", text: $name)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(UIColor.secondarySystemFill))
                            .cornerRadius(4)
                        
                        Button("Done") {
                            UIApplication.shared.endEditing()
                        }.buttonStyle(ButtonUI())
                    }
                    
                    Picker(selection: $selectedGrade, label: Text(""), content: {
                        ForEach(0...(self.gradeArr.count - 1), id: \.self) { index in
                            Text(gradeArr[index])//.tag(grade)
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                    
                    if selectedGrade == 0 {
                        Picker(selection: $selectedSymbol, label: Text(""), content: {
                            ForEach(1...2, id: \.self) { index in
                                Text("\(symbolArr[index])")
                            }
                        }).pickerStyle(SegmentedPickerStyle())
                    } else if selectedGrade != 4 {
                        Picker(selection: $selectedSymbol, label: Text(""), content: {
                            ForEach(0...2, id: \.self) { index in
                                Text("\(symbolArr[index])")
                            }
                        }).pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if schoolType == "College" {
                        Picker(selection: $credits, label: Text(""), content: {
                            ForEach(1...5, id: \.self) { index in
                                Text("\(Int(index))")//.tag(grade)
                            }
                        }).pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 15)
                    }
                    
                    if self.name != "" {
                        Button(action: {
                            editCourseAtPoint()
                            print("should have added course")
                        }) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(gradeArr[selectedGrade] + symbolArr[selectedSymbol])").font(.title2).bold().foregroundColor(Color.white)
                                    
                                    Text(self.name).bold().foregroundColor(Color.white)
                                    
                                    if schoolType == "College" {
                                        if self.credits == 1 {
                                            Text("\(self.credits) credit").font(.footnote).foregroundColor(Color.white)
                                        } else {
                                            Text("\(self.credits) credits").font(.footnote).foregroundColor(Color.white)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: "checkmark")
                                    
                                    Text("Finalize course")
                                        .bold()
                                }.font(.title3)
                            }.padding()
                                .foregroundColor(Color.white)
                                .frame(height: 100, alignment: .center)
                                .background(Color.primaryColor)
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            deleteCourseAtPoint()
                            print("should have added course")
                        }) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(gradeArr[selectedGrade] + symbolArr[selectedSymbol])").font(.title2).bold().foregroundColor(Color.white)
                                    
                                    Text(self.name).bold().foregroundColor(Color.white)
                                    
                                    if schoolType == "College" {
                                        if self.credits == 1 {
                                            Text("\(self.credits) credit").font(.footnote).foregroundColor(Color.white)
                                        } else {
                                            Text("\(self.credits) credits").font(.footnote).foregroundColor(Color.white)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: "trash")
                                    
                                    Text("Delete course")
                                        .bold()
                                }.font(.title3)
                            }.padding()
                            .foregroundColor(Color.white)
                            .frame(height: 100, alignment: .center)
                            .background(Color.primaryColor)
                            .cornerRadius(12)
                        }
                    }
                }.onAppear() {
                    var courseIndex = 0
                    
                    for course in data.courses {
                        if dataEdit.coursePointer == course.id {
                            self.credits = data.courses[courseIndex].credits
                            self.name = data.courses[courseIndex].name
                            //self.grade = data.courses[courseIndex].grade
                            returnSelectedGrade()
                        }
                        
                        courseIndex += 1
                    }
                }
            }
        }
    }
    
    func returnSelectedGrade() {
        var courseIndex = 0
        var gradeToken = ""
        
        for course in data.courses {
            if dataEdit.coursePointer == course.id {
                gradeToken = data.courses[courseIndex].grade
                
                switch gradeToken {
                case "A":
                    self.selectedGrade = 0
                    self.selectedSymbol = 1
                case "A-":
                    self.selectedGrade = 0
                    self.selectedSymbol = 2
                case "B+":
                    self.selectedGrade = 1
                    self.selectedSymbol = 0
                case "B":
                    self.selectedGrade = 1
                    self.selectedSymbol = 1
                case "B-":
                    self.selectedGrade = 1
                    self.selectedSymbol = 2
                case "C+":
                    self.selectedGrade = 2
                    self.selectedSymbol = 0
                case "C":
                    self.selectedGrade = 2
                    self.selectedSymbol = 1
                case "C-":
                    self.selectedGrade = 2
                    self.selectedSymbol = 2
                case "D+":
                    self.selectedGrade = 3
                    self.selectedSymbol = 0
                case "D":
                    self.selectedGrade = 3
                    self.selectedSymbol = 1
                case "D-":
                    self.selectedGrade = 3
                    self.selectedSymbol = 2
                case "F":
                    self.selectedGrade = 4
                    self.selectedSymbol = 1
                default:
                    print("none")
                }
            }
            
            courseIndex += 1
        }
    }
    
    func editCourseAtPoint() {
        print("should have edited here")
        
        var courseIndex = 0
        
        for course in data.courses {
            if dataEdit.coursePointer == course.id {
                data.courses[courseIndex].credits = self.credits
                data.courses[courseIndex].name = self.name
                data.courses[courseIndex].grade = gradeArr[selectedGrade] + symbolArr[selectedSymbol]
            }
            
            courseIndex += 1
        }
        
        data.saveItems()
        
        dataEdit.coursePointer = 0
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
        
        data.saveItems()
        
        dataEdit.coursePointer = 0
    }
}
