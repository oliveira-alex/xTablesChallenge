//
//  ContentView.swift
//  xTablesChallenge
//
//  Created by Alex Oliveira on 03/05/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Which tables do you want to practice?")

                HStack {
                    ForEach(1 ..< 5) {
                        Button("\($0)") {
                            //
                        }
                    }
                }

                HStack {
                    ForEach(5 ..< 9) {
                        Button("\($0)") {
                            //
                        }
                    }
                }

                HStack {
                    ForEach(9 ..< 13) {
                        Button("\($0)") {
                            //
                        }
                    }
                }
            }
            
            VStack {
                Text("How many questions do you want to anwer?")
                
                HStack {
                    ForEach(0 ..< 3) {
                        let buttonTitle = 5.0 * pow(2.0, Double($0))
                        Button("\(Int(buttonTitle))") {
                            //
                        }
                    }
                    
                    Button("All") {
                        //
                    }
                }
            }
        }
    }
}

struct GamingView: View {
    @State private var answerTxt = ""
    private var aswer: Int {
        return Int(answerTxt) ?? 0
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What is 7 x 8 ?")
                .font(.title)
            
            TextField("Answer", text: $answerTxt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 150)
        }
    }
}

struct ContentView: View {
    @State private var isGameActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                if isGameActive {
                    GamingView()
                        .transition(.slide)
                } else {
                    SettingsView()
                        .transition(.slide)
                }
                
                Spacer()
                
                Button(isGameActive ? "Submit" : "Start") {
                    withAnimation(.easeOut) {
                        self.isGameActive.toggle()
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("xTables")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        SettingsView()
//        GamingView()
    }
}
