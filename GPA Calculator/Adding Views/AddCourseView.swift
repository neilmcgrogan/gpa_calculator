//
//  AddCourseView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct AddCourseView: View {
    @EnvironmentObject var data: ShareData
    @EnvironmentObject var dataEdit: DataEdit
    
    @Binding var addCourseView: Bool
    
    @State private var name = ""
    @State private var credits = 1
    
    @State private var gradeArr = ["A", "B", "C", "D", "F"]
    @State private var symbolArr = ["+", "", "-"]
        
    @State var selectedGrade = 0
    @State var selectedSymbol = 1
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("name the course")
                    .bold()
                    .foregroundColor(.gray)
                
                HStack {
                    TextField("enter course name", text: $name)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color(UIColor.secondarySystemFill))
                        .cornerRadius(4)
                    
                    Button("Skip") {
                        name = "course #" + String(dataEdit.courseUID + 1)
                        print(dataEdit.courseUID)
                    }.buttonStyle(ButtonUI())
                    .padding(.horizontal)
                    
                    Button("Done") {
                        UIApplication.shared.endEditing()
                    }.buttonStyle(ButtonUI())
                }
                
                Text("grade for course")
                    .bold()
                    .foregroundColor(.gray)
                
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
                
                Text("credits in course")
                    .bold()
                    .foregroundColor(.gray)
                
                Picker(selection: $credits, label: Text(""), content: {
                    ForEach(1...5, id: \.self) { index in
                        Text("\(Int(index))")//.tag(grade)
                    }
                }).pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 15)
            }
            
            if self.name == "" {
                Text("Fill out all the prompts to log this course")
                    .bold()
                    .foregroundColor(.gray)
            } else {
                Button(action: {
                    addCourse()
                    
                    withAnimation {
                        self.addCourseView = false
                    }
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(gradeArr[selectedGrade] + symbolArr[selectedSymbol])").font(.title2).bold().foregroundColor(Color.white)
                            
                            Text(self.name).bold().foregroundColor(Color.white)
                            
                            if self.credits == 1 {
                                Text("\(self.credits) credit").font(.footnote).foregroundColor(Color.white)
                            } else {
                                Text("\(self.credits) credits").font(.footnote).foregroundColor(Color.white)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "checkmark")
                            
                            Text("Finalize course")
                                .bold()
                        }.font(.title3)
                    }.foregroundColor(Color.white)
                    .padding(8)
                    .background(Color.buttonColor)
                    .cornerRadius(12)
                    .frame(height: 65, alignment: .center)
                }
            }
        }
    }
    
    func addCourse() {
        print(dataEdit.courseUID)
        
        data.courses.append(CourseModel(id: dataEdit.uniqueIDFunc(), name: self.name, grade: gradeArr[selectedGrade] + symbolArr[selectedSymbol], credits: self.credits, semesterName: dataEdit.semesterIndex))
    }
}
