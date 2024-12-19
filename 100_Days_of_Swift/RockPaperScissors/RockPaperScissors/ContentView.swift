//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by James Clarke on 12/19/24.
//

import SwiftUI

enum Move : Int {
    case Rock
    case Paper
    case Scissors
    
    static func random() -> Move {
        let rand = Int.random(in: 0...2)
        return Move(rawValue: rand)!
    }
}

enum Player {
    case User
    case App
    case None
}

struct PlayerMove {
    var player: Player
    var playerMove: Move
}

struct ContentView: View {
    @State var appCurrentChoice: Move = Move.random()
    @State var playerWinsMove = Bool.random()
    @State var currentMove = 1
    @State var currentScore = 0
    
    var body: some View {
        VStack {
            Text("App's move for move \(currentMove) is \(appCurrentChoice)")
            Text("Select your move so that you \(playerWinsMove ? "Win" : "lose")")
            HStack {
                Button("Rock") {
                    PerformTurn(userMove: PlayerMove(player:.User, playerMove: .Rock))
                }
                Button("Paper") {
                    PerformTurn(userMove: PlayerMove(player:.User, playerMove: .Paper))
                }
                Button("Scissors") {
                    PerformTurn(userMove: PlayerMove(player:.User, playerMove: .Scissors))
                }
            }
            .font(.system(size: 40))
            Text("Current score \(currentScore)")
        }
        .font(.system(size: 20))
        .padding()
    }
    
    func ResultOfMove(player1Move: PlayerMove, player2Move: PlayerMove) -> Player  {
        // Rock beats Scissors
        // Paper beats Rock
        // Scissors beats Paper
        switch (player1Move.playerMove, player2Move.playerMove) {
        case (.Rock, .Scissors):
            return player1Move.player
        case (.Scissors, .Rock):
            return player2Move.player
        case (.Paper, .Rock):
            return player1Move.player
        case (.Rock, .Paper):
            return player2Move.player
        case (.Scissors, .Paper):
            return player1Move.player
        case (.Paper, .Scissors):
            return player2Move.player
        case (.Paper, .Paper):
            return .None
        case (.Scissors, .Scissors):
            return .None
        case (.Rock, .Rock):
            return .None
        }
    }
    
    func UserDidWinTurn(player1Move: PlayerMove, player2Move: PlayerMove, userShouldWin: Bool) -> Bool {
        if playerWinsMove {
            return ResultOfMove(player1Move: player1Move, player2Move: player2Move) == .User
        } else {
            return ResultOfMove(player1Move: player1Move, player2Move: player2Move) == .App
        }
    }
    
    func PerformTurn(userMove: PlayerMove) {
        let turnResult = UserDidWinTurn(player1Move: PlayerMove(player: .App, playerMove: appCurrentChoice), player2Move: userMove, userShouldWin: playerWinsMove)
        if turnResult {
            //TODO check that the user won or lost based on playerWinsMove
            currentScore+=1
        }
        appCurrentChoice = Move.random()
        playerWinsMove = Bool.random()
        currentMove += 1
        if currentMove==10 {
            currentScore = 0
            currentMove = 1
            // TODO alert the user that game is over
        }
    }
    
}

#Preview {
    ContentView()
}
