//
//  CourseTile.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/14/21.
//

import SwiftUI

struct CourseTile: View {
    
    let grade: String
    let name: String
    let credits: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(grade)").font(.title2).bold()
                
                Text(name).foregroundColor(Color.grayText)
                
                Text("\(credits) credits").font(.footnote).foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(width: 125, height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
    }
}
