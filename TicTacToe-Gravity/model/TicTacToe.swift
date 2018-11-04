//
//  TicTacToe.swift
//  TicTacToe-Gravity
//
//  Created by Jasleen Arora Srivastava on 02/11/18.
//  Copyright © 2018 Jasleen Arora Srivastava. All rights reserved.
//

import Foundation
class TicTacToe {
    private var cells = [[Cell]]() //An Empty array of cells.
    var isGameOver: Bool { //Computed property.
        get {
            if numCells == 0 {
                return true
            }
            var result = false
            //Check all rows first if anything has completed.
            for row in 0..<rows {
                result = checkRow(row: row)
                if result {
                    return true
                }
            }
            
            //Then check all columns.
            for col in 0..<cols {
                result = checkCol(col: col)
                if result {
                    return true
                }
            }
            
            //If we get here, just check for diagonals.
            return checkRightDiagonal() || checkLeftDiagonal()
        }
    }
    
    private(set) var rows: Int
    private(set) var cols: Int
    
    private var numCells :Int
    
    public func getCardAt(_ row: Int, _ col: Int) -> Cell {
        return cells[row][col]
    }
    
    public func setCardIdentifierAt(_ row:Int, _ col: Int, identifier: String) {
        cells[row][col].identifier = identifier
        cells[row][col].isOccupied = true
        numCells -= 1
    }
    
    public func resetBoard() {
        for row in 0..<rows {
            for col in 0..<cols {
                cells[row][col].identifier = ""
                cells[row][col].isOccupied = false
            }
        }
        numCells = rows * cols
    }
    
    init(rows :Int){
        self.rows = rows
        self.cols = rows
        
        for r in 0..<rows {
            cells.append([])//First add an empty array
            for _ in 0..<cols {
                cells[r].append(Cell()) //Then add the actual cell.
            }
        }
        numCells = rows * cols
    }
    
    /*
     * This returns if the row contains all identifiers
     * of the same type.
     */
    public func checkRow(row :Int) -> Bool{
        let prevIdentifier = cells[row][0].identifier
        
        for cell in cells[row] {
            if cell.isOccupied {
                if prevIdentifier != cell.identifier {
                    return false
                }
            }
            else { //Cell is free, the row can't be filled.
                return false
            }
        }
        return true
    }
    
    public func checkCol(col :Int) -> Bool {
        let prevIdentifier = cells[0][col].identifier
        
        for row in 0..<rows {
            let cell = cells[row][col]
            if cell.isOccupied {
                if (prevIdentifier != cell.identifier) {
                    return false
                }
            }
            else {
                return false;
            }
        }
        return true
    }
    
    private func checkLeftDiagonal()->Bool {
        let prevIdentifier = cells[0][0].identifier
        for row in 0..<rows {
                if cells[row][row].isOccupied{
                    if (cells[row][row].identifier != prevIdentifier) {
                        return false
                    }
                }else { //When cell isn't occupied.
                    return false
                }
        }
        return true
    }
    
    private func checkRightDiagonal()->Bool {
        
        let prevIdentifier = cells[0][cols - 1].identifier
        
        for row in 0..<rows {
            let col = rows - 1 - row
                if cells[row][col].isOccupied{
                    if (cells[row][col].identifier != prevIdentifier) {
                        return false
                    }
                }else { //When cell isn't occupied.
                    return false
            }
        }
        return true
    }
}
