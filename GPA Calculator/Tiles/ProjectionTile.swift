//
//  ProjectionTile.swift
//  GPA Calculator
//
//  Created by McGrogan, Neil on 11/29/21.
//

import SwiftUI

struct ProjectionTile: View {
    @EnvironmentObject var data: ShareData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text("\(data.nextLetterGrade())").font(.title2).bold()
                    
                    Text("goal gpa")
                    
                    Text("\(data.nextCreditsTotal())").font(.title2).bold()
                    
                    if data.nextCreditsTotal() == 1 {
                        Text(" credit needed")
                    } else  {
                        Text(" credits needed")
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                if data.nextCreditsTotal() == 1 {
                    Text("To reach a \(data.nextLetterGrade()) average, you need to maintain an A average over \(data.nextCreditsTotal()) credit")
                } else  {
                    Text("To reach a \(data.nextLetterGrade()) average, you need to maintain an A average over \(data.nextCreditsTotal()) credits")
                }
                
                Spacer()
            }.padding(5)
            
            Spacer()
        }.padding(5)
        .frame(height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(5)
    }
}
