//
//  DataModel.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

class CourseModel: Identifiable, Codable {
    var id: Int
    var name: String
    var grade: String
    var credits: Int
    var semesterName: String
    
    init(id: Int, name: String, grade: String, credits: Int, semesterName: String) {
        self.id = id
        self.name = name
        self.grade = grade
        self.credits = credits
        self.semesterName = semesterName
    }
}

class DataEdit: ObservableObject {
    @Published var coursePointer: Int = 0
    
    @Published var semesterIndex = ""
    
    let uidKey = "saved_course_id"
    
    var courseUID = UserDefaults.standard.integer(forKey: "saved_course_id")
    
    func uniqueIDFunc() -> Int {
        self.courseUID += 1
        
        UserDefaults.standard.set(self.courseUID, forKey: uidKey)
        return courseUID
    }
}

class ShareData: ObservableObject {
    @Published var courses: [CourseModel] = [] {
        didSet {
            print("saveItems")
            saveItems()
        }
    }
    var currIndex = ""
    let itemsKey: String = "saved_courses"
    
    func Semesters() -> [String] {
        var semArr: [String] = []
        //var semTaken: [String] = ["Fall 2019"]
        
        for course in courses {
            semArr.append(course.semesterName)
        }
        
        let cleanedArray = Array(semArr).uniqued()
        
        return cleanedArray
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([CourseModel].self, from: data)
        else { return }
        
        self.courses = savedItems
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(courses) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func gpa() -> Float {
        return earnedCredits() / Float(totalCredits())
    }
    
    func totalCredits() -> Int {
        var credits = 0
        
        for course in self.courses {
            credits += course.credits
        }
        
        return credits
    }
    
    func earnedCredits() -> Float {
        var gpaArr: Float = 0.0000
        var earnedCredits: Float = 0.0000
        
        for course in self.courses {
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
    
    func letterGrade(gpa: Float) -> String {
        if gpa == 4.0000 {
            return "A"
        } else if gpa >= 3.6667 {
            return "A-"
        } else if gpa >= 3.3333 {
            return "B+"
        } else if gpa >= 3.0000 {
            return "B"
        } else if gpa >= 2.6667 {
            return "B-"
        } else if gpa >= 2.3333 {
            return "C+"
        } else if gpa >= 2.0000 {
            return "C"
        } else if gpa >= 1.6667 {
            return "C-"
        } else if gpa >= 1.3333 {
            return "D+"
        } else if gpa >= 1.0000 {
            return "D"
        } else if gpa >= 0.6667 {
            return "D-"
        } else {
            return "F"
        }
    }
    
    func nextLetterGrade() -> String {
        switch letterGrade(gpa: self.gpa()) {
        case "A":
            return "fail"
        case "A-":
            return "A"
        case "B+":
            return "A-"
        case "B":
            return "B+"
        case "B-":
            return "B"
        case "C+":
            return "B-"
        case "C":
            return "C+"
        case "C-":
            return "C"
        case "D+":
            return "C-"
        case "D":
            return "D+"
        case "D-":
            return "D"
        case "F":
            return "-"
        default:
            return "none"
        }
    }
    
    func nextCreditsTotal() -> Int {
        var addedCredits = 0
        
        for item in 1...1000 {
            if letterGrade(gpa: (earnedCredits() + Float((item * 4))) / Float((totalCredits() + item))) == nextLetterGrade() {
                addedCredits = item
                return addedCredits
            }
        }
        
        return addedCredits
    }
}
