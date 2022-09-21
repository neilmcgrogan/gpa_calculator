//
//  Button.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 9/20/22.
//

import Foundation
import SwiftUI

struct NextButton: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.secondColor)
            .background(Color.primaryColor)
            .cornerRadius(30)
            .padding()
    }
}

struct AltNextButton: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.primaryColor)
            .background(Color.secondColor)
            .cornerRadius(30)
            .padding()
    }
}

struct GrayNextButton: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.lightGray)
            .cornerRadius(30)
            .padding()
    }
}

struct AddButton: View {
    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.secondColor)
            .background(Color.primaryColor)
            .cornerRadius(30)
            .padding()
    }
}

struct DoneButton: View {
    var body: some View {
        Image(systemName: "checkmark")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.secondColor)
            .background(Color.primaryColor)
            .cornerRadius(30)
            .padding()
    }
}

struct XButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .padding()
            .foregroundColor(Color.primaryColor)
            .background(Color.secondColor)
            .cornerRadius(30)
            .padding(.leading, 5)
    }
}

struct GrayDoneButton: View {
    var body: some View {
        Image(systemName: "checkmark")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.lightGray)
            .cornerRadius(30)
            .padding()
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NextButton()
            AltNextButton()
            GrayNextButton()
            AddButton()
            DoneButton()
            GrayDoneButton()
            XButton()
        }
    }
}
