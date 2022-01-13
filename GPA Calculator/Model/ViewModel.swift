//
//  ViewModel.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .homeView
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = .onboardingView
        } else {
            currentPage = .homeView
        }
    }
}

enum Page {
    case onboardingView, homeView, settingsView, addSemesterView, semesterView
}
