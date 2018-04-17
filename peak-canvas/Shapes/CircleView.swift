//
//  CircleView.swift
//  peak-canvas
//
//  Created by Tom Phelps on 17/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import UIKit

class CircleView: Shape {
    
    var points = [CGPoint]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.createCircle()
        // Specify the fill color and apply it to the path.
        UIColor.green.setFill()
        path.fill()
        
        // Specify a border (stroke) color.
        UIColor.black.setStroke()
        path.stroke()
    }
    
    static func generateRandomCircle(in canvas: UIView) -> CircleView{
        let randX = CGFloat(super.getRandomXandY(in: canvas).randomX)
        let randY = CGFloat(super.getRandomXandY(in: canvas).randomY)
        let circle = CircleView(frame: CGRect(x: randX,
                                              y: randY,
                                              width: 100,
                                              height: 100))
        
        return circle
    }
    
    func setInitalPoint(point: CGPoint){
        if points.isEmpty{
            points.append(point)
        }
    }
    
    override func move(to point: CGPoint){
        self.center = point
        points.append(point)
    }
    
    override func undoMove(){
        if points.count >= 2{
            points.removeLast(1)
            self.center = points.last!
        }else{
            deleteShape()
        }
    }
    
    override func deleteShape(){
        self.removeFromSuperview()
    }
    
    override func undoDeleteShape(){
        self.draw(frame)
    }

}
