//  AOC8.swift
//  AdventOfCode
//
//  Created by Dash on 12/7/20.
//

import Foundation

class Program {
    struct Instruction {
        enum Operation: String {
            case nop
            case acc
            case jmp
        }
        
        let operation: Operation
        let argument: Int
        
        init(text: String) {
            let textComponents = text.componentStrings
            guard textComponents.count == 2, let operation = Operation(rawValue: textComponents[0]), let value = Int(textComponents[1]) else {
                fatalError("Invalid instruction text: \(text)")
            }
            self.operation = operation
            self.argument = value
        }
        
        init(operation: Operation, argument: Int) {
            self.operation = operation
            self.argument = argument
        }
    }
    
    private let instructions: [Instruction]
    
    init(instructions: [Instruction]) {
        self.instructions = instructions
    }
    
    private(set) var accumulator = 0
    private var index = 0
    
    /// Runs the instructions and returns if the program successfully exited
    func run() -> Bool {
        accumulator = 0
        index = 0
        
        var visitedIndexex = Set<Int>()
        
        while !visitedIndexex.contains(index) && index < instructions.count {
            visitedIndexex.insert(index)
            apply(instruction: instructions[index])
        }
        
        return index == instructions.count
    }
    
    private func apply(instruction: Instruction) {
        switch instruction.operation {
        case .nop:
            index += 1
        case .acc:
            accumulator += instruction.argument
            index += 1
        case .jmp:
            index += instruction.argument
        }
    }
}

extension String {
    var instructions: [Program.Instruction] {
        lines.map { Program.Instruction(text: $0) }
    }
}

struct AOC8: Puzzle {
    func solve1(input: String) -> Int {
        let program = Program(instructions: input.instructions)
        _ = program.run()
        return program.accumulator
    }
    
    func solve2(input: String) -> Int {
        let instructions = input.instructions
        for (index, instruction) in instructions.enumerated() {
            var updatedInstructions = instructions
            switch instruction.operation {
            case .nop:
                updatedInstructions[index] = Program.Instruction(operation: .jmp, argument: instruction.argument)
            case .jmp:
                updatedInstructions[index] = Program.Instruction(operation: .nop, argument: instruction.argument)
            case .acc:
                continue
            }
            let program = Program(instructions: updatedInstructions)
            if program.run() {
                return program.accumulator
            }
        }
        fatalError("No programs completed successfully")
    }
}
