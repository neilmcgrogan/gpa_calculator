//
//  LargeTile.swift
//  GPA Calculator
//
//  Created by McGrogan, Neil on 11/26/21.
//

import SwiftUI

struct LargeTile: View {
    @EnvironmentObject var data: ShareData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text("\(data.letterGrade(gpa: data.gpa()))").font(.title2).bold()
                    
                    Text("average")
                }
                
                Divider()
                
                if data.totalCredits() == 1 {
                    Text("You have taken \(data.totalCredits()) credit")
                } else {
                    Text("You have taken \(data.totalCredits()) credits")
                }
                
                if data.earnedCredits() == 1 {
                    Text("You have earned \(data.earnedCredits(), specifier: "%.2f") credit")
                } else {
                    Text("You have earned \(data.earnedCredits(), specifier: "%.2f") credits")
                }
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(5)
    }
}
