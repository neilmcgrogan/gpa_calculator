//
//  ViewModel.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 9/19/22.
//

import Foundation
import SwiftUI

struct ViewModel {
    let content_width = UIScreen.main.bounds.width * 0.9
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    let semNames = ["Fall", "Spring", "Summer"]
    let subjects = ["Math", "Science", "English", "History"]
    let collegeGrades = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    let highschoolGrades = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
}
