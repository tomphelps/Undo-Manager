//
//  Shape.swift
//  peak-canvas
//
//  Created by Tom Phelps on 17/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import UIKit

class Shape: UIView, ShapeManagerProtocol {

    var path: UIBezierPath!

    // MARK:- Create shapes
    func createSquare(){
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
    
    func createCircle(){
        self.path = UIBezierPath(ovalIn:CGRect(
                x: self.frame.size.width/2 - self.frame.size.height/2,
                y: 0.0,
                width: self.frame.size.height,
                height: self.frame.size.height)
        )
    }
    
    // MARK:- Protocol methods
    // These need to be overriden by each subclass of shape,
    // App will fail if subclass hasn't overriden all methods
    func move(to point: CGPoint){
        assert(false, "This method must be overriden by the subclass")
    }
    
    func undoMove(){
        assert(false, "This method must be overriden by the subclass")
    }
    
    func deleteShape(){
       assert(false, "This method must be overriden by the subclass")
    }
    
    func undoDeleteShape(){
        assert(false, "This method must be overriden by the subclass")
    }
    
    // MARK:-
    static func getRandomXandY(in canvas: UIView) -> (randomX: UInt32, randomY: UInt32){
        // Using the canvas as the frame, -100 which is the size of the shape
        // To avoid random shapes appearing off screen
        let width = UInt32(canvas.frame.size.width-100)
        let height = UInt32(canvas.frame.size.height-100)
        let randomX = arc4random_uniform(width);
        let randomY = arc4random_uniform(height);
        return (randomX, randomY)
    }

}

protocol ShapeManagerProtocol{
    func move(to point: CGPoint)
    func undoMove()
    func deleteShape()
    func undoDeleteShape()
}
