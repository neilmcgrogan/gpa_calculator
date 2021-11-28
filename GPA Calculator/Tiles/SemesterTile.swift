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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(GPA, specifier: "%.2f")").bold().foregroundColor(.black)
                
                Text("\(semester)").bold().foregroundColor(Color.grayText)
                
                Text("\(creditsEarned, specifier: "%.2f")/\(creditsTaken, specifier: "%.2f") credits").font(.footnote).foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(width: 125, height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
    }
}
