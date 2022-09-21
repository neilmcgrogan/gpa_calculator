//
//  OnboardingView.swift
//  GPA Calculator
//
//  Created by Neil McGrogan on 1/13/22.
//

import SwiftUI

/*

 3 tiered onboarding page with sections:
 log - pencil.circle
 track - waveform.path.ecg.rectangle menucard
 project - aqi.medium
 
 sf symbols for all, highlighting each differently
 
 */

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var settings: Settings
    @State var page: Int = 0
    @State var time: Double = 100
    @FocusState private var focused: Bool
    let vm = ViewModel()
    var body: some View {
        VStack {
            switch page {
            case 0:
                logSection
            case 1:
                trackSection
            case 2:
                forecastSection
            case 3:
                questionSection
            default:
                Text("error")
            }
            
            if !focused {
                Spacer()
                
                navSection
            }
        }
        .foregroundColor(
            page == 0 ? Color.secondColor : Color.primaryColor
        )
        .background(
            page == 0 ? Color.primaryColor : Color.secondColor
        )
    }
}

extension OnboardingView {
    private var logSection: some View {
        VStack {
            Spacer()
            Image(systemName: "character.book.closed")
                .resizable()
                .frame(width: 125, height: 125)
                .foregroundColor(Color.secondColor)
            Spacer()
            Text("Log your GPA")
                .font(.largeTitle)
            Text("Log your GPA over time")
                .font(.headline)
        }
        .frame(width: vm.content_width)
    }
    
    private var trackSection: some View {
        VStack {
            Spacer()
            Image(systemName: "menucard")
                .resizable()
                .frame(width: 125, height: 125)
                .foregroundColor(Color.primaryColor)
            Spacer()
            Text("Track your progress")
                .font(.largeTitle)
            Text("View graphs and data that shows your perfornce over time")
                .font(.headline)
        }
        .frame(width: vm.content_width)
    }
    
    private var forecastSection: some View {
        VStack {
            Spacer()
            Image(systemName: "waveform.path.ecg")
                .resizable()
                .frame(width: 125, height: 125)
                .foregroundColor(Color.primaryColor)
            Spacer()
            Text("Forecast your future GPA")
                .font(.largeTitle)
            Text("Use this application to estimate what your GPA will be in future semesters")
                .font(.headline)
        }
        .frame(width: vm.content_width)
    }
    
    private var questionSection: some View {
        VStack {
            Text("Before we begin")
                .font(.largeTitle)
            Text("Just a couple questions...")
                .font(.headline)
            Spacer()
            
            Text("What's your name?")
                .font(.subheadline)
                .foregroundColor(.gray)
                
            TextField("enter your name", text: $settings.name)
                .focused($focused)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color.lightGray)
                .cornerRadius(4)
                .padding()
            
            if !focused {
                Text("Are you in high school or college?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Button("high school") {
                        self.settings.schoolType = "HighSchool"
                    }
                    .foregroundColor(settings.schoolType == "HighSchool" ? Color.white : Color.primaryColor)
                    .padding()
                    .background(settings.schoolType == "HighSchool" ? Color.primaryColor : Color.lightGray)
                    .font(.headline)
                    .cornerRadius(15)
                    
                    Button("college") {
                        self.settings.schoolType = "College"
                    }
                    .foregroundColor(settings.schoolType == "College" ? Color.white : Color.primaryColor)
                    .padding()
                    .background(settings.schoolType == "College" ? Color.primaryColor : Color.lightGray)
                    .font(.headline)
                    .cornerRadius(15)
                }
            }
        }
        .onChange(of: focused) { focus in
            settings.keyboardShown = focus
        }
    }
    
    private var navSection: some View {
        ZStack {
            HStack {
                Spacer()
                
                if (settings.name != "" && settings.schoolType != "") || self.page != 3 {
                    Button(action: {
                        if self.page == 3 {
                            viewRouter.currentPage = .homeView
                        } else {
                            self.page += 1
                        }
                    }) {
                        if page == 0 {
                            AltNextButton()
                        } else {
                            NextButton()
                        }
                    }
                } else {
                    GrayNextButton()
                }
            }
            if self.page != 3 {
                HStack {
                    Spacer()
                    if self.page == 0 {
                        Capsule().frame(width: 10, height: 6).foregroundColor(Color.secondColor)
                        Capsule().frame(width: 6, height: 6).foregroundColor(Color.gray)
                        Capsule().frame(width: 6, height: 6).foregroundColor(Color.gray)
                    } else {
                        Capsule().frame(width: page == 0 ? 10 : 6, height: 6).foregroundColor(page == 2 ? Color.primaryColor : Color.gray)
                        Capsule().frame(width: page == 1 ? 10 : 6, height: 6).foregroundColor(page == 2 ? Color.primaryColor : Color.gray)
                        Capsule().frame(width: page == 2 ? 10 : 6, height: 6).foregroundColor(page == 2 ? Color.primaryColor : Color.gray)
                    }
                    Spacer()
                }
            }
        }
        .padding(.bottom)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ViewRouter())
            .environmentObject(DataEdit())
            .environmentObject(ShareData())
            .environmentObject(Settings())
    }
}
