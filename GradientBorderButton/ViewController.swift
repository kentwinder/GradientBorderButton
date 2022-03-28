//
//  ViewController.swift
//  GradientBorderButton
//
//  Created by Kent Winder on 3/19/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: GradientBorderButton!
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    @IBOutlet weak var startColorView: UIView!
    @IBOutlet weak var endColorView: UIView!
    @IBOutlet weak var shadowColorView: UIView!
    @IBOutlet weak var bgColorView: UIView!
    
    private var isFullyRounded = false
    private var cornerRadius: CGFloat = 8
    private var startPoint: CGPoint = .zero
    private var startColor: UIColor = .yellow
    private var endPoint: CGPoint = CGPoint(x: 1, y: 1)
    private var endColor: UIColor = .red
    private var hasShadow = false
    private var shadowColor: UIColor = .lightGray
    private var showPlainBackground = false
    private var bgColor: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        cornerRadiusSlider.isEnabled = !isFullyRounded
        startColorView.backgroundColor = startColor
        endColorView.backgroundColor = endColor
        if hasShadow {
            shadowColorView.backgroundColor = shadowColor
            button.shadowColor = shadowColor.withAlphaComponent(0.3)
        } else {
            shadowColorView.backgroundColor = .white
            button.shadowColor = nil
        }
        button.isFullyRounded = isFullyRounded
        button.cornerRadius = cornerRadius
        bgColorView.backgroundColor = bgColor
        if showPlainBackground {
            button.setPlainBackground(withColor: bgColor)
        } else {
            button.setGradientBorder(colors: [startColor, endColor], startPoint: startPoint, endPoint: endPoint, backgroundColor: bgColor)
        }
    }
    
    @IBAction func borderValueChanged(_ sender: UISlider) {
        button.borderWidth = CGFloat(sender.value)
        updateViews()
    }
    
    @IBAction func fullyRoundedValueChanged(_ sender: UISwitch) {
        isFullyRounded = sender.isOn
        updateViews()
    }
    
    @IBAction func cornerRadiusValueChanged(_ sender: UISlider) {
        cornerRadius = CGFloat(sender.value)
        updateViews()
    }
    
    @IBAction func startPointValueChanged(_ sender: UISlider) {
        startPoint = CGPoint(x: 0, y: CGFloat(sender.value))
        updateViews()
    }
    
    @IBAction func randomStartColor(_ sender: Any) {
        startColor = .random()
        updateViews()
    }
    
    @IBAction func endPointValueChanged(_ sender: UISlider) {
        endPoint = CGPoint(x: CGFloat(sender.value), y: 1)
        updateViews()
    }
    
    @IBAction func randomEndColor(_ sender: Any) {
        endColor = .random()
        updateViews()
    }
    
    @IBAction func hasShadowValueChanged(_ sender: UISwitch) {
        hasShadow = sender.isOn
        updateViews()
    }
    
    @IBAction func randomShadowColor(_ sender: Any) {
        shadowColor = .random()
        updateViews()
    }
    
    @IBAction func showPlainBackgroundValueChanged(_ sender: UISwitch) {
        showPlainBackground = sender.isOn
        if !sender.isOn {
            bgColor = .white
        }
        updateViews()
    }
    
    @IBAction func randomBackgroundColor(_ sender: Any) {
        bgColor = .random()
        updateViews()
    }
}

