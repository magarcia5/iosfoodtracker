//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Mel Alrajhi on 1/23/18.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    private var buttons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectedStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{ setupButtons() }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{ setupButtons() }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Actions
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = buttons.index(of: button) else { fatalError("Button \(button) not in array: \(buttons)") }
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    //MARK: Private methods
    private func setupButtons(){
        for button in buttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        buttons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount{
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.selected, .highlighted])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add to stack
            addArrangedSubview(button)
            
            buttons.append(button)
        }
        updateButtonSelectedStates()
    }
    
    private func updateButtonSelectedStates(){
        for(index, button) in buttons.enumerated(){
            button.isSelected = index < rating;
        }
    }
}
