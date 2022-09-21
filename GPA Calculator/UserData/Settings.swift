//
//  Settings.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 9/20/22.
//

import Foundation
import Combine
import SwiftUI

class Settings: ObservableObject {
    let defaults = UserDefaults.standard

    /// Showing and hiding on the basis of wether the keyboard is shown or not
    @Published var keyboardShown = false
    
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    @Published var schoolType: String {
        didSet {
            UserDefaults.standard.set(schoolType, forKey: "school_type")
        }
    }
    
    init() {
        /// Sign Up Questions
        self.name = defaults.object(forKey: "name") as? String ?? ""
        self.schoolType = defaults.object(forKey: "accepts_terms") as? String ?? ""
    }
}
