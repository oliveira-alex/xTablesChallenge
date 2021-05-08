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
        guard selectedTables.count > 0 else { return [] }
        
        let questionsQuantity: Int
        switch questionsQuantityString {
        case "5", "10":
            questionsQuantity = Int(questionsQuantityString)!
        case "20" where selectedTables.count == 1: // max 12 questions if just one table is selected
            questionsQuantity = 12
        case "20":
            questionsQuantity = 20
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
        let currentQuestion = randomQuestions[currentQuestionIndex]
        return "What is \(currentQuestion.0) x \(currentQuestion.1) ?"
    }
    @State private var score = 0
    
    @State private var answerString = ""
    private var aswer: Int {
        return Int(answerString) ?? 0
    }
    
    let randomQuestions: [(Int, Int)]
    @State private var currentQuestionIndex = 0
    var isGameOver: Bool {
        currentQuestionIndex >= randomQuestions.count
    }
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if !isGameOver {
                Spacer()
                
                Text(questionTxt)
                    .font(.title)
                
                TextField("Answer", text: $answerString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 150)
                    .keyboardType(.numberPad)
                
                Spacer()
                
                Button("Submit") {
                    let answer = Int(answerString) ?? 0
                    let currentQuestion = randomQuestions[currentQuestionIndex]
                    let correctAnswer = currentQuestion.0 * currentQuestion.1
                    
                    if (answer == correctAnswer) {
                        alertTitle = "😃👍"
                        alertMsg = "Correct!"
                        score += 1
                    } else if (answer == 0) {
                        alertTitle = "😐"
                        alertMsg = "\(currentQuestion.0) x \(currentQuestion.1) = \(correctAnswer)"
                    } else if (answer != correctAnswer) {
                        alertTitle = "🥺"
                        alertMsg = "Actually \(currentQuestion.0) x \(currentQuestion.1) = \(correctAnswer)"
                    }
                    showingAlert = true
                }
                
                Spacer()
                
                Text("Question \(currentQuestionIndex + 1) of \(randomQuestions.count)")
            } else if isGameOver {
                Spacer()
                
                Text("Final Score: \(score)")
                    .font(.title)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMsg),
                  dismissButton: .default(Text("OK")) {
                    answerString = ""
                    currentQuestionIndex += 1
                  })
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
                    
                    // Three HStacks
                    ForEach(0 ..< 3) { line in
                        HStack {
                            // With four buttons in each HStack
                            let firstButtonNumber: Int = 4 * line + 1
                            let lastButtonNumber: Int = 4 * line + 4
                            
                            ForEach(firstButtonNumber ..< lastButtonNumber + 1) { buttonNumber in
                                Button(action:{
                                    if let numIndex = selectedTables.firstIndex(of: buttonNumber) {
                                        // deactivated color button if it was already selected
                                        selectedTables.remove(at: numIndex)
                                    } else {
                                        // activated color button if it wasn't already selected
                                        selectedTables.append(buttonNumber)
                                    }
                                }) {
                                   Text("\(buttonNumber)")
                                    .foregroundColor(selectedTables.contains(buttonNumber) ? .blue : .red)
                                }
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
            .onAppear(perform: {
                selectedTables = []
                questionsQuantity = ""
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
