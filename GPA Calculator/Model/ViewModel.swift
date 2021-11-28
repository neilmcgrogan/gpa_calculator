//
//  ViewModel.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .homeView
}

enum Page {
    case homeView, settingsView, addSemesterView, semesterView, projections
}
