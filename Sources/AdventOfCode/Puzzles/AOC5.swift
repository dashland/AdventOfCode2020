//  AOC5.swift
//  AdventOfCode
//
//  Created by Dash on 12/4/20.
//

import Foundation

struct AOC5: Puzzle {
    func solve1(input: String) -> Int {
        input.lines.reduceMaximum { $0.seatID }
    }
    
    func solve2(input: String) -> Int {
        IndexSet(indexes: input.lines.map { $0.seatID }).rangeView.last!.first! - 1
    }
}

extension String {
    private var binaryString: String {
        self.replacingOccurrences(of: "F", with: "0").replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "L", with: "0").replacingOccurrences(of: "R", with: "1")
    }
    
    var seatID: Int {
        Int(binaryString, radix: 2)!
    }
}
