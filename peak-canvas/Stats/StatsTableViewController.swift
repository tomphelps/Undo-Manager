//
//  StatsTableViewController.swift
//  peak-canvas
//
//  Created by Tom Phelps on 17/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {
    
    var squares: [SquareView]!
    var circles: [CircleView]!
    var triangles: [TriangleView]!
    
    var delegate: DeleteShapeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stats Cell", for: indexPath)
        if let statsCell = cell as? StatsTableViewCell{
            switch indexPath.row{
            case 0:
                statsCell.shapeType = .Square
                statsCell.shapeCount = squares.count
            case 1:
                statsCell.shapeType = .Circle
                statsCell.shapeCount = circles.count
            case 2:
                statsCell.shapeType = .Triangle
                statsCell.shapeCount = triangles.count
            default:
                break
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.row{
            case 0:
                deleteAllSquares()
            case 1:
                deleteAllCircles()
            case 2:
                deleteAllTriangles()
            default:
                break
            }
        }
    }
    
    func deleteAllSquares(){
        squares.removeAll()
        delegate?.deleteAllSquares()
        tableView.reloadData()
    }
    
    func deleteAllCircles(){
        circles.removeAll()
        delegate?.deleteAllCircles()
        tableView.reloadData()
    }
    
    func deleteAllTriangles(){
        triangles.removeAll()
        delegate?.deleteAllTriangles()
        tableView.reloadData()
    }

}

