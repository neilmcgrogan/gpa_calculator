//
//  OnboardingView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 1/13/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var currentPageIndex = 0
    
    var subviews = [
            UIHostingController(rootView: Subview(imageString: "logging")),
            UIHostingController(rootView: Subview(imageString: "tracking")),
            UIHostingController(rootView: Subview(imageString: "projecting")),
            UIHostingController(rootView: Subview(imageString: "personalization"))
        ]
    
    var titles = ["Log your GPA", "Track your progress over time", "Project your GPA", "Lets get started"]
    var captions =  ["Log your semesters over time to create a cumulative GPA", "Look back on past semesters to see your progress", "Know what your GPA will be before the semester ends", "To begin, tell us about yourself"]
    
    @State private var name = UserDefaults.standard.string(forKey: "Name") ?? ""
    @State private var schoolType = UserDefaults.standard.string(forKey: "SchoolType") ?? ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(titles[currentPageIndex])
                    .font(.largeTitle)
                Text(captions[currentPageIndex])
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 300, height: 50, alignment: .leading)
                .lineLimit(nil)
            }.padding(.top)
            
            if currentPageIndex == 3 {
                Text("What should we call you?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField("enter your name", text: $name)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(UIColor.secondarySystemFill))
                    .cornerRadius(4)
                
                Text("Are you in high school or college?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Button("high school") {
                        self.schoolType = "HighSchool"
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(schoolType == "HighSchool" ? Color.primaryColor : Color.gray)
                    .font(.headline)
                    .cornerRadius(15)
                    
                    Button("college") {
                        self.schoolType = "College"
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(schoolType == "College" ? Color.primaryColor : Color.gray)
                    .font(.headline)
                    .cornerRadius(15)
                }
            }
            
            Spacer()
            
            HStack {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                
                Spacer()
                
                if currentPageIndex == 3 {
                    Button(action: {
                        UserDefaults.standard.set(self.name, forKey: "Name")
                        UserDefaults.standard.set(self.schoolType, forKey: "SchoolType")
                        withAnimation {
                            self.viewRouter.currentPage = .homeView
                        }
                    }) {
                        ButtonContent()
                    }
                } else {
                    Button(action: {
                        if self.currentPageIndex+1 == self.subviews.count {
                            self.currentPageIndex = 0
                        } else {
                            self.currentPageIndex += 1
                        }
                    }) {
                        ButtonContent()
                    }
                }
            }.padding()
        }.padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding()
            .background(Color.primaryColor)
            .cornerRadius(30)
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(Color.primaryColor)
            .font(.headline)
            .cornerRadius(15)
    }
}
