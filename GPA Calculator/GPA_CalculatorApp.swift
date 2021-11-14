//
//  GPA_CalculatorApp.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

@main
struct GP_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.offWhite.edgesIgnoringSafeArea(.all)
                
                ViewController()
                    .environmentObject(ViewRouter())
                    .environmentObject(SharedData())
                    .environmentObject(EditingData())
            }
        }
    }
}
