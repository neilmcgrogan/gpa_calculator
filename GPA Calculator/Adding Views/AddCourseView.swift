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
                    TextField("Enter your name", text: $name)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color(UIColor.secondarySystemFill))
                        .cornerRadius(4)
                    
                    Button("Skip") {
                        name = "course #" + String(dataEdit.courseUID + 1)
                    }.buttonStyle(ButtonUI())
                    .padding(.horizontal)
                    
                    Button("Done") {
                        
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
                            Text("\(gradeArr[selectedGrade] + symbolArr[selectedSymbol])").font(.title2).bold()
                            
                            Text(self.name).bold().foregroundColor(Color.grayText)
                            
                            Text("\(self.credits) credits").font(.footnote).foregroundColor(.gray)
                            
                            Spacer()
                        }
                        
                        Text("Finalize course")
                        
                        Spacer()
                    }.padding(5)
                    .frame(height: 125, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(15)
                }
            }
        }
    }
    

    
    func addCourse() {
        data.courses.append(CourseModel(id: dataEdit.uniqueIDFunc(), name: self.name, grade: gradeArr[selectedGrade] + symbolArr[selectedSymbol], credits: self.credits, semesterName: dataEdit.semesterIndex))
    }
}
