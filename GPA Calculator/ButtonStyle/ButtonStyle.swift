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
            .padding(.horizontal)
            .padding(.vertical, 8.5)
            .background(Color.secondColor)
            .foregroundColor(.primaryColor)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            //.shadow(radius: 1)
            .padding(.top, -10)
    }
}

struct SelectedButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 8.5)
            .background(Color.primaryColor)
            .foregroundColor(.secondColor)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            //.shadow(radius: 1)
            .padding(.top, -10)
    }
}

struct ButtonUIView: View {
    var body: some View {
        VStack {
            Button("hello") {
            
            }.buttonStyle(ButtonUI()).padding()
            Button("hello") {
                
            }.buttonStyle(SelectedButtonUI()).padding()
        }
    }
}

struct ButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonUIView()
    }
}
