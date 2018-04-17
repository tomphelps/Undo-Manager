//
//  ViewController.swift
//  peak-canvas
//
//  Created by Tom Phelps on 16/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import UIKit
import Foundation

// Global list of shapes
var squares = [SquareView]()
var circles = [CircleView]()
var triangles = [TriangleView]()

class ShapeEditorViewController: UIViewController, DeleteShapeProtocol {

    let commandManager = CommandManager()

    @IBOutlet weak var canvas: UIView!

    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        commandManager.setCanvas(canvas: canvas)
    }

    // MARK:- Actions
    @IBAction func squareButtonPressed(_ sender: Any) {
        
        // Generate a shape at random point within the given canvas bounds
        let square = SquareView.generateRandomSquare(in: canvas)
        square.setInitalPoint(point: CGPoint(x: square.center.x, y: square.center.y))
        
        // Use the CommandManager to add undo action of shape creation
        CreateShapeCommand(shape: square).execute()
        
        // Add new shape to the canvas, and list of specific shape
        canvas.addSubview(square)
        squares.append(square)
        
        // Add Gestures to new view
        addPanGesture(view: square)
        addLongTapGesture(view: square)
    }

    @IBAction func circleButtonPressed(_ sender: Any) {
        let circle = CircleView.generateRandomCircle(in: canvas)
        circle.setInitalPoint(point: CGPoint(x: circle.center.x, y: circle.center.y))
        CreateShapeCommand(shape: circle).execute()
        canvas.addSubview(circle)
        circles.append(circle)
        addPanGesture(view: circle)
        addLongTapGesture(view: circle)
    }
    
    @IBAction func triangleButtonPressed(_ sender: Any) {
        let triangle = TriangleView.generateRandomTriangle(in: canvas)
        triangle.setInitalPoint(point: CGPoint(x: triangle.center.x, y: triangle.center.y))
        CreateShapeCommand(shape: triangle).execute()
        canvas.addSubview(triangle)
        triangles.append(triangle)
        addPanGesture(view: triangle)
        addLongTapGesture(view: triangle)
    }
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        commandManager.undo()
    }
    
    // MARK:- Add Gestures
    func addPanGesture(view: Shape){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    func addLongTapGesture(view: UIView){
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap(sender:)))
        view.addGestureRecognizer(longTap)
    }
    
    // MARK: Handle Gestures
    @objc func handlePan(sender: UIPanGestureRecognizer){
        let objectView = sender.view!
        let translation = sender.translation(in: canvas)
        
        switch sender.state {
        case .began, .changed:
            objectView.center = CGPoint(x: objectView.center.x + translation.x, y: objectView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: canvas)
        // When Pan ends, add the new movement point to CommandManager to enable undo
        case .ended:
            if let square = objectView as? SquareView{
                let moveSquare = MoveShapeCommand(shape: square)
                let newPoint = CGPoint(x: square.center.x + translation.x, y: square.center.y + translation.y)
                moveSquare.execute(moveTo: newPoint)
            }
            if let circle = objectView as? CircleView{
                let moveCircle = MoveShapeCommand(shape: circle)
                let newPoint = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
                moveCircle.execute(moveTo: newPoint)
            }
            if let triangle = objectView as? TriangleView{
                let moveTriangle = MoveShapeCommand(shape: triangle)
                let newPoint = CGPoint(x: triangle.center.x + translation.x, y: triangle.center.y + translation.y)
                moveTriangle.execute(moveTo: newPoint)
            }
        default:
            break
        }
    }

    @objc func handleLongTap(sender: UILongPressGestureRecognizer){
        if let square = sender.view! as? SquareView{
            if let index = squares.index(of: square){
                squares.remove(at: index)
                DeleteShapeCommand(shape: square).execute()
            }
        }
        
        if let circle = sender.view! as? CircleView{
            if let index = circles.index(of: circle){
                circles.remove(at: index)
                DeleteShapeCommand(shape: circle).execute()
            }
        }
        
        if let triangle = sender.view! as? TriangleView{
            if let index = triangles.index(of: triangle){
                triangles.remove(at: index)
                DeleteShapeCommand(shape: triangle).execute()
            }
        }
        
        
    }
    
    // MARK:- Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Stats"{
            if let statsView = segue.destination as? StatsTableViewController{
                statsView.squares = squares
                statsView.circles = circles
                statsView.triangles = triangles
                statsView.delegate = self
            }
        }
    }
    
    // MARK:- Protocol Methods
    func deleteAllSquares(){
        for square in squares{
            square.removeFromSuperview()
            if let index = squares.index(of: square){
                squares.remove(at: index)
            }
        }
    }
    
    func deleteAllCircles(){
        for circle in circles{
            circle.removeFromSuperview()
            if let index = circles.index(of: circle){
                circles.remove(at: index)
            }
        }
    }
    
    func deleteAllTriangles(){
        for triangle in triangles{
            triangle.removeFromSuperview()
            if let index = triangles.index(of: triangle){
                triangles.remove(at: index)
            }
        }
    }
    
}

// MARK:- Protocol Decleration
protocol DeleteShapeProtocol {
    func deleteAllSquares()
    func deleteAllCircles()
    func deleteAllTriangles()
}

