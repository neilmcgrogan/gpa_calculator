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
        var courseUID = UserDefaults.standard.integer(forKey: self.uidKey)
        
        courseUID += 1
        UserDefaults.standard.set(courseUID, forKey: uidKey)
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
}
