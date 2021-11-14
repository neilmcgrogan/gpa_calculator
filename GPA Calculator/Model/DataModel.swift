//
//  DataModel.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

class SharedData: ObservableObject {
    
    @Published var course: [Course] = []
    @Published var semesters: [Semester] = []
    
    @Published var semName = "Fall"
    @Published var semYear = 2001
    
    @Published var courseUID = 0
    @Published var semesterUID = 0
}

class EditingData: ObservableObject {
    
    @Published var editSemMode = false
    @Published var editSemPointer = 0
    @Published var editCorPointer = 0
    @Published var editCorMode: Bool = false
}

struct Course: Identifiable {

    var id: Int
    var name: String
    var grade: Int
    var credits: Int

    init(id: Int, name: String, grade: Int, credits: Int) {
        self.id = id
        self.name = name
        self.grade = grade
        self.credits = credits
    }
}

struct Semester: Identifiable {
    
    var id: Int
    var course: [Course]
    var semName: String
    var semYear: Int
    
    init(id: Int, course: [Course], semName: String, semYear: Int) {
        self.id = id
        self.course = course
        self.semName = semName
        self.semYear = semYear
    }
}

class MasterModel: ObservableObject {
    
    @Published var gpa: Int = 0
}
