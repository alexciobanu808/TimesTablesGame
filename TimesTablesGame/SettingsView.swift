//
//  SettingsView.swift
//  TimesTablesGame
//
//  Created by Alex Ciobanu on 1/27/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var gameIsActive = false
    @State private var multiplicationTableMax = 2
    @State private var selectedNumberOfQuestions = 5
    
    let numberOfQuestions = [5, 10, 20]
    
    var body: some View {
        print(Self._printChanges())
        return NavigationView {
            Form {
                Section("Include numbers up to... : \(multiplicationTableMax)") {
                    Picker("", selection: $multiplicationTableMax) {
                        ForEach(2..<13) {
                            Text("\($0)")
                                .tag($0)
                        }
                    }
//                    .pickerStyle(.menu)
                }
                
                Section("Number of questions: \(selectedNumberOfQuestions)") {
                    Picker("", selection: $selectedNumberOfQuestions) {
                        ForEach(0..<3) {
                            Text("\(numberOfQuestions[$0])").tag(numberOfQuestions[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Button("Begin Game!") {
                    gameIsActive = true
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $gameIsActive) {
                GameView(questions: generateQuestions(multiplicationTableMax: multiplicationTableMax, numberOfQuestions: selectedNumberOfQuestions))
            }
        }
    }
    
    func generateQuestions(multiplicationTableMax: Int, numberOfQuestions: Int) -> [Question] {
        var questions: [Question] = []
        
        for _ in 0..<numberOfQuestions {
            let firstNumber = Int.random(in: 2...multiplicationTableMax)
            let secondNumber = Int.random(in: 2...multiplicationTableMax)
            
            let question = Question(text: "What is \(firstNumber) * \(secondNumber)", answer: firstNumber * secondNumber)
            questions.append(question)
        }
        
        return questions
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
