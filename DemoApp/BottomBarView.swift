//
//  BottomBarView.swift
//  DemoApp
//
//  Created by I'm Vyas on 03/09/25.
//

import UIKit
import UIKit

protocol BottomBarDelegate: AnyObject {
    func bottomBarButtonTapped(index: Int)
}

class BottomBarView: UIView {
    static let reuseIdentifier = "BottomBarView"
//    class func getNib() -> BottomBarView? {
//        let view = Bundle.main.loadNibNamed(BottomBarView.reuseIdentifier, owner: self, options: nil)?.first as? BottomBarView
//        return view
//    }
    
    // MARK: - Load from XIB
    class func instanceFromNib() -> BottomBarView {
        return UINib(nibName: BottomBarView.reuseIdentifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as! BottomBarView
    }
    
    weak var delegate: BottomBarDelegate?
    
    @IBOutlet var buttons: [UIButton]!
    
    //private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    var onButtonTap: ((Int) -> Void)?
    
    /*
    // Define a default height
    private let barHeight: CGFloat = 60
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setupView()
    }
    */
    func setupView() {
        backgroundColor = .systemGray6
        
        let titles = ["One", "Two", "Three", "Four", "Five"]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, button) in self.buttons.enumerated() {
            /*
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            */
            button.tag = index
            //button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            // default style
            button.setTitleColor(.darkGray, for: .normal)
            
            //buttons.append(button)
            //stackView.addArrangedSubview(button)
        }
        
        //addSubview(stackView)
        
        
        /*
        NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        */
        // default select first button
        updateSelection(index: 0)
    }
    
    /*
    // 🔑 Auto size support
       override var intrinsicContentSize: CGSize {
           return CGSize(width: UIView.noIntrinsicMetric, height: barHeight)
       }
    */
    //func buttonTapped(_ sender: UIButton) {
    @IBAction func buttonTapped(_ sender: UIButton) {
    
    
        //updateSelection(index: sender.tag)
//        delegate?.bottomBarButtonTapped(index: sender.tag)
        
        onButtonTap?(sender.tag) // send index to container
    }
    
    func updateSelection(index: Int) {
        /*
        for (i, btn) in buttons.enumerated() {
            if i == index {
                btn.setTitleColor(.systemBlue, for: .normal)
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            } else {
                btn.setTitleColor(.darkGray, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            }
        }
        */
        
        for (i, button) in buttons.enumerated() {
                    button.isSelected = (i == index)
                    button.backgroundColor = button.isSelected ? .systemBlue : .clear
                    button.setTitleColor(button.isSelected ? .white : .systemBlue, for: .normal)
                }
        
        selectedIndex = index
    }
}
