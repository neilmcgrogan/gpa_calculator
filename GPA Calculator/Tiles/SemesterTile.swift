//
//  SemesterTile.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/14/21.
//

import SwiftUI

struct SemesterTile: View {
    let GPA: Float
    let semName: String
    let semYear: Int
    let creditsTaken: Int
    let creditsEarned: Float
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(GPA)").font(.title2).bold()
                
                Text("\(semName), \(semYear)").foregroundColor(Color.grayText)
                
                Text("\(creditsEarned)/\(creditsTaken) credits").font(.footnote).foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(width: 125, height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
    }
}
