//
//  ViewController.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct ViewController: View {
    @EnvironmentObject var viewRouter: ViewRouter
    let vm = ViewModel()
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            views
                .foregroundColor(.primaryColor)
        }
    }
}

extension ViewController {
    private var views: some View {
        VStack {
            switch viewRouter.currentPage {
            case .onboardingView:
                OnboardingView()
            case .homeView:
                HomeView()
            case .settingsView:
                SettingsView()
            case .addSemesterView:
                AddView()
            case .semesterView:
                SemesterView()
            }
        }
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
            .environmentObject(ViewRouter())
            .environmentObject(DataEdit())
            .environmentObject(ShareData())
            .environmentObject(Settings())
    }
}

