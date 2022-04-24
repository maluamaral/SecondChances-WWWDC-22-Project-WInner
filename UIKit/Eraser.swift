//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 15/04/22.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


class TouchDownPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
    }
}

enum DrawingAction: Int {
    case erase = 0
    case draw = 1
}


class Eraser: UIView {

    public var drawingAction: DrawingAction = .erase
    public var circleRadius: CGFloat = 20
    public var maskDrawingAlpha: CGFloat = 1.0
    
    public var circleCursorColor: UIColor? = nil {
        didSet { shapeLayer.strokeColor = circleCursorColor?.cgColor }
    }
    
    public var outerCircleCursorColor: UIColor? = nil {
        didSet { outerShapeLayer.strokeColor = outerCircleCursorColor?.cgColor }
    }

    var movedCallback: (() -> ())?
    var endedCallback: (() -> ())?
    
    // MARK: - Private vars

    private var maskImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var maskLayer = CALayer()
    private var shapeLayer = CAShapeLayer()
    private var outerShapeLayer = CAShapeLayer()
    private var renderer: UIGraphicsImageRenderer?
    private var panGestureRecognizer = TouchDownPanGestureRecognizer()
    private var firstTime = true
    
    convenience init(topImage: UIImage) {
        self.init()
        self.maskImage.image = topImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        doInitSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        doInitSetup()
    }
    
    // MARK: - Public functions
    
    private func setupConstraints(){
        self.addSubview(maskImage)
        maskImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maskImage.topAnchor.constraint(
                equalTo: self.topAnchor),
            maskImage.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            maskImage.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            maskImage.bottomAnchor.constraint(
                equalTo: self.bottomAnchor),
        ])
    }
    
    private var imageBounds: CGSize {
        bounds.size
    }
    
    override func draw(_ rect: CGRect) {
        updateBounds()
    }
    
    public func updateBounds() {
        maskLayer.frame = layer.bounds
        shapeLayer.frame = layer.frame
        outerShapeLayer.frame = layer.frame
        if firstTime {
            renderer = UIGraphicsImageRenderer(size: imageBounds)
//            installSampleMask()
            layer.superlayer?.addSublayer(shapeLayer)
            layer.superlayer?.addSublayer(outerShapeLayer)
            firstTime = false
        }
        
        // potecialmente perigoso tirar esse if. se tudo explodir, voltar
        //else {
//            guard let renderer = renderer else { return }
//            let image = renderer.image { (context) in
//                if maskImage == maskImage {
//                    maskImage.image!.draw(in: bounds)
//                }
//            }
//            maskImage.image = image
//            maskLayer.contents = maskImage.image?.cgImage
        //}
        
        guard let renderer = renderer else { return }
        let image = renderer.image { (context) in
            maskImage.image?.draw(
                in: .init(origin: .zero, size: imageBounds),
                blendMode: .normal,
                alpha: 1)
        }
        
        maskImage.image = image
        maskLayer.contents = maskImage.image?.cgImage
    }
    
    private func installSampleMask() {
        guard let renderer = renderer else { return }
        let image = renderer.image { (ctx) in
            UIColor.black.setFill()
            ctx.fill(.init(origin: .zero, size: imageBounds), blendMode: .normal)
            //let insetRect = bounds.insetBy(dx: bounds.width / 4, dy: bounds.height/4)
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).setFill()
            //ctx.fill(insetRect)
        }
        maskImage.image = image
        maskLayer.contents = maskImage.image?.cgImage
    }
    
    private func drawCircleAtPoint(point: CGPoint) {
        guard let renderer = renderer else { return }
        let image = renderer.image { (context) in
            if  maskImage == maskImage {
                maskImage.image?.draw(
                    in: .init(origin: .zero, size: imageBounds),
                    blendMode: .normal,
                    alpha: 1)
                 let rect = CGRect(origin: point, size: CGSize.zero).insetBy(dx: -circleRadius/2, dy: -circleRadius/2)
                let color = UIColor.black.cgColor
                context.cgContext.setFillColor(color)
                let blendMode: CGBlendMode
                let alpha: CGFloat
                if drawingAction == .erase {
                    // This is what I worked out to reduce the alpha of the mask by maskDrawingAlpha in the drawing area
                    blendMode = .sourceIn
                    alpha = 1 - maskDrawingAlpha
                } else {
                    // In normal drawing mode the new drawing alpha is added to the alpha of the existing area.
                    blendMode = .normal
                    alpha = maskDrawingAlpha
                }

                if circleCursorColor != nil {
                    let circlePath = UIBezierPath(ovalIn:rect)
                    circlePath.fill(with: blendMode, alpha: alpha)
                    shapeLayer.path = circlePath.cgPath
                }

                if outerCircleCursorColor != nil {
                    let outerRect = rect.insetBy(dx: -2, dy: -2)
                    let outerCirclePath = UIBezierPath(ovalIn:outerRect)
                    outerCirclePath.fill(with: blendMode, alpha: alpha)
                    outerShapeLayer.path = outerCirclePath.cgPath
                }
            }
        }
        maskImage.image = image
        maskLayer.contents = maskImage.image?.cgImage
    }
    
    // MARK: - IBAction methods
    
    @objc func gestureRecognizerUpdate(_ sender: UIGestureRecognizer? = nil) {
        let point = sender?.location(in: self)
        if sender?.state != .ended {
            drawCircleAtPoint(point: point!)
        } else {
            self.shapeLayer.path = nil
            self.outerShapeLayer.path = nil
        }
        
        if (sender?.state == .cancelled
            || sender?.state == .ended
            || sender?.state == .failed) {
            endedCallback?()
        }
        
        if (sender?.state == .changed || sender?.state == .began) {
            movedCallback?()
        }
    }
    
    
    // MARK: - Object lifecycle methods
    
    func doInitSetup() {
        shapeLayer.strokeColor = circleCursorColor?.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        outerShapeLayer.strokeColor = outerCircleCursorColor?.cgColor
        outerShapeLayer.lineWidth = 1
        outerShapeLayer.fillColor = UIColor.clear.cgColor

        layer.mask = maskLayer

        // Set up a pan gesture recognizer to erase/un-erase a series of circles as the user drags over the image.
        panGestureRecognizer.addTarget(self, action: #selector(gestureRecognizerUpdate(_:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }

}
