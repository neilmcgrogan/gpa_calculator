//
//  SmallCourseTile.swift
//  GPA Calculator
//
//  Created by McGrogan, Neil on 11/26/21.
//

import SwiftUI

struct SmallCourseTile: View {
    let grade: String
    let name: String
    let credits: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(grade)").font(.title2).bold()
                
                Text(name).bold().foregroundColor(Color.grayText)
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(width: 125, height: 65, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
    }
}
