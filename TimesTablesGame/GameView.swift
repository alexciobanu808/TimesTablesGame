//
//  GameView.swift
//  TimesTablesGame
//
//  Created by Alex Ciobanu on 1/27/22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var usersInput: Int = 0
    @State private var questionNumber = 0
    @State private var score = 0
    @State private var questionsShown = 0
    @State private var showingAlert = false
    @State private var showingEndAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    let questions: [Question]
    
    var body: some View {
        Form {
            Section {
                Text(questions[questionNumber].text)
            }
            
            Section {
                TextField("Answer", value: $usersInput, formatter: NumberFormatter())
            }
            
            Section {
                Button("Check Answer") {
                    checkAnswer(usersInput)
                }
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue") {
                questionNumber += 1
            }
        } message: {
            Text(alertMessage)
        }
        .alert("Game Over", isPresented: $showingEndAlert) {
            Button("Finish") { dismiss() }
        } message: {
            Text("Your final score is \(score) out of \(questionsShown)")
        }
    }
    
    func checkAnswer(_ usersInput: Int) {
        questionsShown += 1
        
        if questionsShown < questions.count {
            if usersInput == questions[questionNumber].answer {
                score += 1
            }
            
            alertMessage = generateCorrectAlert(usersInput)
            showingAlert = true

        } else {
            showingEndAlert = true
        }
        
    }
    
    func generateCorrectAlert(_ usersInput: Int) -> String {
        if usersInput == questions[questionNumber].answer {
            alertTitle = "Correct!"
            return "Your score is \(score)"
        } else {
            alertTitle = "Wrong!"
            return "The correct answer was \(questions[questionNumber].answer)\nYour score is \(score)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(questions: [])
    }
}
