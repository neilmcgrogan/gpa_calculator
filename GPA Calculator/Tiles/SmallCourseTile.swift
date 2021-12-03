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
                HStack(alignment: .center) {
                    Text("\(grade)").bold().font(.title2).foregroundColor(.buttonColor)
                    
                    if credits == 1 {
                        Text("/ \(credits) credit").font(.footnote).foregroundColor(.gray)
                    } else {
                        Text("/ \(credits) credits").font(.footnote).foregroundColor(.gray)
                    }
                }
                
                Text(name).bold().foregroundColor(Color.grayText)
                
                Spacer()
            }
            
            Spacer()
        }.padding(5)
        .frame(width: 125, height: 65, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(5)
    }
}
