//
//  GradientBorderButton.swift
//  GradientBorderButton
//
//  Created by Kent Winder on 3/19/22.
//

import UIKit

class GradientBorderButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var cornerRadius: CGFloat = 12
    @IBInspectable var isFullyRounded: Bool = false
    @IBInspectable var startPoint: CGPoint = CGPoint.zero
    @IBInspectable var startColor: UIColor = UIColor.yellow
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1)
    @IBInspectable var endColor: UIColor = UIColor.red
    @IBInspectable var shadowColor: UIColor? = nil
    
    private var colors: [UIColor] = []
    private var wrapperView = UIView()
    private var gradientLayer = CAGradientLayer()
    private var backgroundView = UIView()
    private var showPlainBackground = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        guard !showPlainBackground else { return }
        
        wrapperView.removeFromSuperview()
        wrapperView = UIView()
        wrapperView.isUserInteractionEnabled = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(wrapperView, at: 0)
        wrapperView.backgroundColor = backgroundColor
        NSLayoutConstraint.activate([
            wrapperView.leftAnchor.constraint(equalTo: leftAnchor),
            wrapperView.rightAnchor.constraint(equalTo: rightAnchor),
            wrapperView.topAnchor.constraint(equalTo: topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        gradientLayer.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        if colors.count == 0 { // in case colors are set using setGradientBorder method
            colors = [startColor, endColor]
        }
        gradientLayer.colors = colors.compactMap({ return $0.cgColor })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        wrapperView.layer.insertSublayer(gradientLayer, at: 0)
        
        backgroundView.removeFromSuperview()
        backgroundView = UIView()
        backgroundView.isUserInteractionEnabled = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(backgroundView)
        backgroundView.backgroundColor = backgroundColor
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: borderWidth),
            backgroundView.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -borderWidth),
            backgroundView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: borderWidth),
            backgroundView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -borderWidth)
        ])
        
        setupCorners()
        dropShadow()
    }
    
    private func setupCorners() {
        var _cornerRadius = cornerRadius
        if isFullyRounded {
            _cornerRadius = frame.height / 2
            if frame.width < frame.height {
                _cornerRadius = frame.width / 2
            }
        }
        layer.cornerRadius = _cornerRadius
        
        wrapperView.layer.cornerRadius = _cornerRadius
        wrapperView.clipsToBounds = true
        backgroundView.layer.cornerRadius = _cornerRadius - borderWidth
        backgroundView.clipsToBounds = true
    }
    
    private func dropShadow() {
        if let shadowColor = shadowColor {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = 1
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 4, height: 4)
        } else {
            layer.shadowOpacity = 0
        }
    }
    
    func setGradientBorder(colors: [UIColor], startPoint: CGPoint = .zero, endPoint: CGPoint = .init(x: 1, y: 1), backgroundColor: UIColor = .white) {
        self.showPlainBackground = false
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.backgroundColor = backgroundColor
        setupViews()
    }
    
    func setPlainBackground(withColor backgroundColor: UIColor = .systemGreen) {
        self.showPlainBackground = true
        self.backgroundColor = backgroundColor
        backgroundView.removeFromSuperview()
        gradientLayer.removeFromSuperlayer()
        wrapperView.removeFromSuperview()
        setupCorners()
        dropShadow()
    }
}
