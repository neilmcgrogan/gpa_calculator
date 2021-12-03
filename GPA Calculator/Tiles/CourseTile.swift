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
                Text("\(grade)").bold().font(.title2).foregroundColor(.buttonColor)
                
                Text(name).bold().foregroundColor(Color.grayText)
                
                if credits == 1 {
                    Text("\(credits) credit").font(.footnote).foregroundColor(.gray)
                } else {
                    Text("\(credits) credits").font(.footnote).foregroundColor(.gray)
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
