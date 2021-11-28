//
//  extension.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Color {
    static var offWhite = Color(red: 0.97, green: 0.97, blue: 1)
    
    static var grayText = Color(red: 0.3, green: 0.3, blue: 0.3)
    
    static var lightGray = Color(red: 210/255, green: 210/255, blue: 210/255)
}

struct Extension: View {
    var body: some View {
        VStack {
            Color.offWhite
            
            Color.grayText
            
            Color.lightGray
        }
    }
}

struct Extension_Previews: PreviewProvider {
    static var previews: some View {
        Extension()
    }
}
