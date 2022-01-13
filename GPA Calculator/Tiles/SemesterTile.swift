//
//  SemesterTile.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/14/21.
//

import SwiftUI

struct SemesterTile: View {
    let GPA: Float
    let semester: String
    let creditsTaken: Float
    let creditsEarned: Float
    
    let schoolType = UserDefaults.standard.string(forKey: "SchoolType")
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(GPA, specifier: "%.2f")").bold().font(.title3).foregroundColor(.primaryColor)
                
                Text("\(semester)").bold().foregroundColor(Color.grayText)
                
                if schoolType == "College" {
                    if creditsTaken == 1 {
                        Text("\(creditsEarned, specifier: "%.2f")/\(creditsTaken, specifier: "%.0f") credit").font(.footnote).foregroundColor(.gray)
                    } else {
                        Text("\(creditsEarned, specifier: "%.2f")/\(creditsTaken, specifier: "%.0f") credits").font(.footnote).foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }.padding(7)
        .frame(width: 125, height: 100, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(5)
    }
}
