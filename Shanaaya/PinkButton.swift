//
//  PinkButton.swift
//  Shanaaya
//
//  Created by Amit Dhamija on 3/16/18.
//  Copyright © 2018 Amit Dhamija. All rights reserved.
//

import UIKit

class PinkButton: UIButton {

    override var isEnabled: Bool { didSet { stateChanged() }}
    override var isHighlighted: Bool { didSet { stateChanged() }}
    override var isSelected: Bool { didSet { stateChanged() }}
    
    fileprivate var normalColor: UIColor? = UIColor.colorWithHexValue("E63E62")
    fileprivate var highlightedColor: UIColor? = UIColor.colorWithHexValue("893843")
    fileprivate var selectedColor: UIColor? = UIColor.colorWithHexValue("EC86AA")
    fileprivate var disabledColor: UIColor? = UIColor.lightGray
    
    /*
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initialize()
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        initialize()
        stateChanged()
    }
    
    private func initialize() {
        layer.masksToBounds = true
        backgroundColor = normalColor
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        stateChanged()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        stateChanged()
    }
    
    fileprivate func stateChanged() {
        
        switch state {
            
        case .normal:
            backgroundColor = normalColor
            
        case .highlighted:
            backgroundColor = highlightedColor
            
        case .selected:
            backgroundColor = selectedColor
            
        case .disabled:
            backgroundColor = disabledColor
            
        default:
            break
        }
    }
}
