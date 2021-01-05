//
//  ViewController.swift
//  GestureLevel2
//
//  Created by cm0640 on 2021/1/5.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties

    private lazy var pieceView: UIView = {
        return UIView()
    }()
    
    /// 長按手勢
    private lazy var longPressPiece: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        gesture.minimumPressDuration = 0.3
        return gesture
    }()
    
    /// 旋轉手勢
    private lazy var rotatePiece: UIRotationGestureRecognizer = {
        let gesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        return gesture
    }()
    
    /// 縮放手勢
    private lazy var pinchPiece: UIPinchGestureRecognizer = {
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        return gesture
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieceView()
    }
}

// MARK: - Setup Methods

extension ViewController {
    
    func setupPieceView() {
        pieceView.addGestureRecognizer(longPressPiece)
        pieceView.addGestureRecognizer(rotatePiece)
        pieceView.addGestureRecognizer(pinchPiece)
        pieceView.backgroundColor = .red
        pieceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pieceView)
        pieceView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pieceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pieceView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pieceView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

// MARK: - Action Methods

extension ViewController {
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            guard let view = gestureRecognizer.view else { return }
            
            view.becomeFirstResponder()

            let menuController = UIMenuController.shared
            menuController.menuItems = [UIMenuItem(title: "Reset", action: #selector(handleResetPiece))]
            
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            let menuLocation = CGRect(x: location.x, y: location.y, width: 0, height: 0)

            menuController.showMenu(from: view, rect: menuLocation)
        }
    }
    
    @objc func handleResetPiece() {
        pieceView.transform = .identity
    }
    
    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
                 
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            pieceView.transform = pieceView.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            pieceView.transform = pieceView.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
            gestureRecognizer.scale = 1.0
        }
    }
}
