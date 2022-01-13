//
//  Subview.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 1/13/22.
//

import SwiftUI

struct Subview: View {
    
    var imageString: String
    
    var body: some View {
        Image(imageString)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
    }
}
