//
//  ButtonStyle.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 11/13/21.
//

import SwiftUI

struct ButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(7)
            .background(Color.primaryColor)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 2)
            .padding(.top, -10)
    }
}

struct ButtonUIView: View {
    var body: some View {
        Button("hello") {
        
        }.buttonStyle(ButtonUI())
    }
}

struct ButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonUIView()
    }
}
