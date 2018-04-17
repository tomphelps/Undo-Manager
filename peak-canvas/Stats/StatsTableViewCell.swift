//
//  StatsTableViewCell.swift
//  peak-canvas
//
//  Created by Tom Phelps on 17/03/2018.
//  Copyright © 2018 Tom Phelps. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    
    var shapeType: ShapeType?
    var shapeCount: Int? {didSet{updateUI()}}
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var shapesLabel: UILabel!
    
    func updateUI(){
        if shapeType != nil{
            switch shapeType!{
            case .Square:
                shapesLabel.text = "Squares"
                numberLabel.text = String(shapeCount!)
            case .Circle:
                shapesLabel.text = "Circles"
                numberLabel.text = String(shapeCount!)
            case .Triangle:
                shapesLabel.text = "Triangles"
                numberLabel.text = String(shapeCount!)
            }
        }
    }

}
