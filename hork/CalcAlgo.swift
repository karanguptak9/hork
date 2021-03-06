//
//  calcAlgo.swift
//  hork
//
//  Created by Karan Gupta on 5/20/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import Foundation

struct CalcAlgo {
    
    var accumulator: Double?
    private var currentPendingBinaryOperation: PendingBinaryOperation?
    
    enum Operation {
        case constant(Double)
        case unaryOperation( (Double) -> Double )
        case binareOperation( (Double,Double) -> Double )
        case equals
    }
    //initiating each operation algo
    var operations: [String: Operation] = [
        "+": Operation.binareOperation({ $0 + $1 }),
        "-": Operation.binareOperation({ $0 - $1 }),
        "*": Operation.binareOperation({ $0 * $1 }),
        "/": Operation.binareOperation({ $0 / $1 }),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ mathematicalSymbol: String) {
        if let operation = operations[mathematicalSymbol] {
            switch operation {
            case Operation.constant(let value):
                accumulator = value
                
            case Operation.unaryOperation(let function):
                if let value = accumulator {
                    accumulator = function(value)
                }
                
            case .binareOperation(let function):
                if let firstOperand = accumulator {
                    currentPendingBinaryOperation = PendingBinaryOperation(firstOperand: firstOperand, function: function)
                    accumulator = nil
                }
        
            case .equals:
                perfomrBinaryOperation()
                
            }
        }
    }
    
    mutating func perfomrBinaryOperation() {
        if let operation = currentPendingBinaryOperation, let secondOperand = accumulator {
            accumulator = operation.perform(secondOperand: secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let function: (Double, Double) -> Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func reset () {
        accumulator = 0.0
    }
    
}


