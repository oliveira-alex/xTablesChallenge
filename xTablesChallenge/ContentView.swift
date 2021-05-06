//
//  ContentView.swift
//  xTablesChallenge
//
//  Created by Alex Oliveira on 03/05/2021.
//

import SwiftUI

struct Questions {
    let selectedTables: [Int]
    let questionsQuantityString: String
    
    var questions: [(Int, Int)] {
        let questionsQuantity: Int
        switch questionsQuantityString {
        case "5", "10", "20":
            questionsQuantity = Int(questionsQuantityString)!
        default:
            questionsQuantity = 12 * selectedTables.count
        }
        
        var allPossibleQuestions: [[Int]] = []
        for _ in 0 ..< selectedTables.count {
            var completeTableRandomOrdered: [Int] = []
            for _ in 1 ..< 13 {
                var randomNum = -1
                repeat {
                    randomNum = Int.random(in: 1 ..< 13)
                } while completeTableRandomOrdered.contains(randomNum)
                completeTableRandomOrdered.append(randomNum)
            }

            allPossibleQuestions.append(completeTableRandomOrdered)
        }
        
        var questionsArray: [(Int, Int)] = []
        for _ in 0 ..< questionsQuantity {
            var tableIndex = -1
            repeat {
                tableIndex = Int.random(in: 0 ..< selectedTables.count)
            } while (allPossibleQuestions[tableIndex].isEmpty)
            let table = selectedTables[tableIndex]
            
            let multiplier = allPossibleQuestions[tableIndex].popLast()!
            
            questionsArray.append((table, multiplier))
        }
        
        return questionsArray
    }
}

struct GamingView: View {
    var questionTxt: String {
        if currentQuestionIndex < randomQuestions.count {
            let currentQuestion = randomQuestions[currentQuestionIndex]
            return "What is \(currentQuestion.0) x \(currentQuestion.1) ?"
        } else {
            return "Score"
        }
    }
    @State private var answerTxt = ""
    private var aswer: Int {
        return Int(answerTxt) ?? 0
    }
    
    let randomQuestions: [(Int, Int)]
    @State private var currentQuestionIndex = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(questionTxt)
                .font(.title)
            
            if currentQuestionIndex < randomQuestions.count {
                TextField("Answer", text: $answerTxt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 150)
                
                Button("Submit") {
                    currentQuestionIndex += 1
                }
                
                Text("Question \(currentQuestionIndex + 1) of \(randomQuestions.count)")
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedTables: [Int] = []
    @State private var questionsQuantity = ""
    var questions: Questions {
        Questions(selectedTables: selectedTables, questionsQuantityString: questionsQuantity)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // Tables VStack
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
                
                // Number of questions VStack
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
                
                Spacer()
                
                NavigationLink(destination: GamingView(randomQuestions: questions.questions)) {
                    Text("Start")
                }
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
