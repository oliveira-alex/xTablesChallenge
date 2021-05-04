//
//  ContentView.swift
//  xTablesChallenge
//
//  Created by Alex Oliveira on 03/05/2021.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedTables: [Int] = []
    @State private var questionsQuantity = ""
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Which tables do you want to practice?")

                HStack {
                    ForEach(1 ..< 5) { num in
                        Button(action:{
                            if let numIndex = selectedTables.firstIndex(of: num) {
                                // deactivated color button
                                selectedTables.remove(at: numIndex)
                            } else {
                                // activated color button
                                selectedTables.append(num)
                            }
                        }) {
                           Text("\(num)")
                            .foregroundColor(selectedTables.contains(num) ? .blue : .red)
                        }
                    }
                }

                HStack {
                    ForEach(5 ..< 9) { num in
                        Button(action:{
                            if let numIndex = selectedTables.firstIndex(of: num) {
                                // deactivated color button
                                selectedTables.remove(at: numIndex)
                            } else {
                                // activated color button
                                selectedTables.append(num)
                            }
                        }) {
                           Text("\(num)")
                            .foregroundColor(selectedTables.contains(num) ? .blue : .red)
                        }
                    }
                }

                HStack {
                    ForEach(9 ..< 13) { num in
                        Button(action:{
                            if let numIndex = selectedTables.firstIndex(of: num) {
                                // deactivated color button
                                selectedTables.remove(at: numIndex)
                            } else {
                                // activated color button
                                selectedTables.append(num)
                            }
                        }) {
                           Text("\(num)")
                            .foregroundColor(selectedTables.contains(num) ? .blue : .red)
                        }
                    }
                }
            }
            
            VStack {
                Text("How many questions do you want to anwer?")
                
                HStack {
                    ForEach(0 ..< 3) {
                        let buttonNumber = Int(5.0 * pow(2.0, Double($0)))
                        let buttonTitle = String(buttonNumber)
                        Button(buttonTitle) {
                            self.questionsQuantity = String(buttonTitle)
                        }
                        .foregroundColor(buttonTitle == questionsQuantity ? .blue : .red)
                    }
                    
                    Button("All") {
                        self.questionsQuantity = "All"
                    }
                    .foregroundColor(questionsQuantity == "All" ? .blue : .red)
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
