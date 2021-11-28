//
//  HomeTile.swift
//  GPA Calculator
//
//  Created by McGrogan, Neil on 11/26/21.
//

import SwiftUI

struct HomeTile: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("To reach a gpa of 3.2 you need...")
                
                Text("An A in a one credit hour class")
                
                //Text("\(grade)").font(.title2).bold()
                
                //Text(name).bold().foregroundColor(Color.grayText)
                
                //Text("\(credits) credits").font(.footnote).foregroundColor(.gray)
                
                Spacer()
            }.padding(5)
            
            Spacer()
        }.padding(5)
        .frame(height: 125, alignment: .center)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct HomeTile_Previews: PreviewProvider {
    static var previews: some View {
        HomeTile()
    }
}
