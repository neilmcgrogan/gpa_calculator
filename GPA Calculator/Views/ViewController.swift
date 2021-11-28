//
//  ViewController.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct ViewController: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            switch viewRouter.currentPage {
            case .homeView:
                HomeView()
            case .settingsView:
                SettingsView()
            case .addSemesterView:
                AddSemesterView()
            case .semesterView:
                SemesterView()
            case .projections:
                ProjectionsView()
            }
            
            Spacer()
        }
    }
}

struct ProjectionsView: View {
    
    var body: some View {
        VStack {
            Text("Projections")
            
            Text("In this view we...")
        }
    }
}
