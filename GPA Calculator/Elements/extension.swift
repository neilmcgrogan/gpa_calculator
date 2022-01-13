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
    static var grayText = Color(red: 0.2, green: 0.2, blue: 0.2)
    static var lightGray = Color(red: 210/255, green: 210/255, blue: 210/255)
    static var primaryColor = Color(red: 125/255, green: 100/255, blue: 250/255)
}

struct Extension: View {
    var body: some View {
        VStack {
            Color.primaryColor
            Color.grayText
            Color.lightGray
        }
    }
}

// Minimized keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct Extension_Previews: PreviewProvider {
    static var previews: some View {
        Extension()
    }
}
