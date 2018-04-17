//
//  CommandManager.swift
//  peak-canvas
//
//  Created by Tom Phelps on 18/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import Foundation
import UIKit

// Use typealias to add functions to list of commands
fileprivate typealias Commands = () -> Void
fileprivate var commands = [Commands]()
fileprivate var canvasView: UIView?

class CommandManager{

    func setCanvas(canvas: UIView){
        canvasView = canvas
    }
    
    func undo(){
        if !commands.isEmpty{
            let command = commands.removeLast()
            command()
        }else{
            print("COMMAND MANAGER: No commands to undo.")
        }
    }
}

class MoveShapeCommand: MoveCommand{
    let shape: Shape
    
    init(shape: Shape){
        self.shape = shape
    }
    
    func execute(moveTo point: CGPoint) {
        shape.move(to: point)
        commands.append(undo)
    }
    
    func undo() {
        shape.undoMove()
    }
}

class DeleteShapeCommand: Command{
    let shape: Shape
    
    init(shape: Shape){
        self.shape = shape
    }
    
    func execute() {
        shape.deleteShape()
        commands.append(undo)
    }
    
    func undo(){
        canvasView?.addSubview(shape)
        addShapeBackToList()
    }
    
    private func addShapeBackToList(){
        if let square = shape as? SquareView{
            squares.append(square)
        }
        if let circle = shape as? CircleView{
            circles.append(circle)
        }
        if let triangle = shape as? TriangleView{
            triangles.append(triangle)
        }
    }
}

class CreateShapeCommand: Command{
    let shape: Shape
    
    init(shape: Shape){
        self.shape = shape
    }
    
    func execute() {
        commands.append(undo)
    }
    
    func undo() {
        shape.deleteShape()
        removeShapeFromList()
    }
    
    private func removeShapeFromList(){
        if let square = shape as? SquareView{
            if let index = squares.index(of: square){
                squares.remove(at: index)
            }
        }
        if let circle = shape as? CircleView{
            if let index = circles.index(of: circle){
                circles.remove(at: index)
            }
        }
        if let triangle = shape as? TriangleView{
            if let index = triangles.index(of: triangle){
                triangles.remove(at: index)
            }
        }
    }
}

protocol MoveCommand{
    func execute(moveTo point: CGPoint)
    func undo()
}

protocol Command{
    func execute()
    func undo()
}
