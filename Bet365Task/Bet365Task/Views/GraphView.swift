//
//  GraphView.swift
//  Bet365TechTask
//
//  Created by Faraz on 27/12/2023.
//

import UIKit

class GraphView: UIView {
    
    enum Constants {
        
        static let margin: Int = 20
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
        static let stepX: CGFloat = 40.0
        static let scaleFactor: CGFloat = 100.0
    }
    
    private var infoPopup: UILabel?
    
    /// property to hold location of points to draw  circles
    private var dataPoints: [CGPoint] = []
    
    var graphPoints: [Float] = [] {
        
        didSet {
            // trigger ui update
            infoPopup?.removeFromSuperview()
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        self.backgroundColor = .gray.withAlphaComponent(0.3)
    }
    
    override func draw(_ rect: CGRect) {
        
        dataPoints.removeAll()
        
        let height = rect.height
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            return
        }
               
        // Calculate the x point
        let margin = CGFloat(Constants.margin)
        let columnXPoint = { (column: Int) -> CGFloat in
            
            return CGFloat(column) * Constants.stepX + margin + 2
        }
        
        // Calculate the y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else {
            
            // initially empty so return safely
            return
        }
        
        let columnYPoint = { (graphPoint: Float) -> CGFloat in
            
            let yPoint = log( CGFloat(graphPoint) / CGFloat(maxValue)) * graphHeight * Constants.scaleFactor
            return topBorder + margin - (yPoint) // Flip the graph
        }
                    
        // Set up the points line
        let graphPath = UIBezierPath()

        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))

        // Draw the line graph
        UIColor.black.setFill()
        UIColor.black.setStroke()
        
        // Add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 0..<graphPoints.count {
            
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
            dataPoints.append(nextPoint)
            drawCircle(at: nextPoint, with: context)
        }

        graphPath.stroke()
        graphPath.lineWidth = 2.0
        
        drawGirdLines(rect: rect)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         guard let touch = touches.first else { return }
         let touchLocation = touch.location(in: self)

         for point in dataPoints {
             
             let circleFrame = CGRect(x: point.x - 5, y: point.y - 5, width: 10, height: 10)

             if circleFrame.contains(touchLocation) {

                 showInfoPopup(at: point)
                 setNeedsDisplay()
                 break
             }
             else {
                 
                 // remove if clicked any where on screen
                 infoPopup?.removeFromSuperview()
             }
         }
     }
    
    // MARK: - Private
    
    private func drawGirdLines(rect: CGRect) {
        
        let verticalLines = (rect.width ) / ( Constants.stepX)
        let horizontalLines = (rect.height) / Constants.stepX
        
        let verticalLinePath = UIBezierPath()
        let horizontalLinePath = UIBezierPath()
        
        let step: Int = Int(Constants.stepX)
        
        for i in 0..<Int(verticalLines) {

            verticalLinePath.move(to: CGPoint(x: Constants.margin + i * step, y: Constants.margin))
            verticalLinePath.addLine(to: CGPoint(x: Constants.margin + i * step, y: Int(rect.height) - Constants.margin))
        }
        
        for i in 1..<Int(horizontalLines) {
            
            horizontalLinePath.move(to: CGPoint(x: Constants.margin, y: i * step))
            horizontalLinePath.addLine(to: CGPoint(x: Int(rect.width) - Constants.margin, y: i * step))
        }
        
        verticalLinePath.lineWidth = 1.0
        UIColor.blue.withAlphaComponent(0.3).setStroke()
        
        verticalLinePath.stroke()
        horizontalLinePath.stroke()
    }
    
    private func drawCircle(at point: CGPoint, with context: CGContext) {
        
        var tempPoint = point
        tempPoint.x -= Constants.circleDiameter / 2
        tempPoint.y -= Constants.circleDiameter / 2
            
        let circle = UIBezierPath(
          ovalIn: CGRect(
            origin: tempPoint,
            size: CGSize(
              width: Constants.circleDiameter,
              height: Constants.circleDiameter)
          )
        )

        circle.fill()
    }
        
    private func showInfoPopup(at point: CGPoint) {
        
        if let dataPointIndex = dataPoints.firstIndex(of: point) {
            
            infoPopup = UILabel(frame: CGRect(x: point.x - 10, y: point.y + 20, width: 100, height: 20))
            infoPopup?.text = "\(graphPoints[dataPointIndex])"
            infoPopup?.textColor = UIColor.black
            addSubview(infoPopup!)
        }
    }
}
