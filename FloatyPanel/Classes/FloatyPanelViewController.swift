//
//  FloatyPanelViewController.swift
//  FloatyPanel
//
//  Created by Emir Shayymov on 4/17/20.
//  Copyright © 2020 Shayimpagne. All rights reserved.
//

import UIKit

@objc
public enum FloatyPanelState: Int {
    case full = 0
    case hidden
}

@objc
public protocol FloatyPanelDelegate: class {
    @objc
    optional func floatyPanelDidClose(_ floatingPanel: FloatyPanelViewController)
    @objc
    optional func floatyPanelWillBeginDragging(_ floatingPanel: FloatyPanelViewController)
    @objc
    optional func floatyPanelDidEndDragging(_ floatingPanel: FloatyPanelViewController, targetPosition: FloatyPanelState)
}

fileprivate let Delta: CGFloat = 0.25
fileprivate let Radius: CGFloat = 16
fileprivate let GrabberViewContainerHeight: CGFloat = 56
fileprivate let GrabberViewHeight: CGFloat = 4
fileprivate let GrabberViewWidth: CGFloat = 40
fileprivate let GrabberViewTop: CGFloat = 6
fileprivate let PanelViewPart: Int = 3

open class FloatyPanelViewController: UIViewController {
    
    @IBOutlet public weak var panelViewContentBottomConstraint: NSLayoutConstraint?
    
    @IBOutlet public weak var panelView: UIView!
    @IBOutlet weak var panelViewBottomConstraint: NSLayoutConstraint!
    
    public weak var delegate: FloatyPanelDelegate?
    
    public var isGrabberHidden = false {
        didSet {
            grabberViewContainer?.isHidden = isGrabberHidden
        }
    }
    
    public var isInteractiveBackground = true {
        didSet {
            backgroundView?.isUserInteractionEnabled = isInteractiveBackground
        }
    }
    
    public var state: FloatyPanelState = .full
    public var panelViewHeight: CGFloat = 0
    
    private var panelViewStartBottomPosition: CGFloat = 0
    private var contentViewBottomPadding: CGFloat = 0
    
    private var backgroundView: UIView!
    private var grabberViewContainer: UIView!
    
    /*
     MARK: - Init and setup
     */
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        setupBackgroundView()
        setupGrabberView()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panelViewHeight = panelView.bounds.height
        panelViewBottomConstraint.constant = -(panelViewHeight)
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        panelView.roundCorners([.topLeft, .topRight], radius: Radius)
    }
    
    /*
     MARK: Hide logic
     */
    open func hidePanel(with completion: (() -> ())?) {
        panelViewBottomConstraint.constant = -(panelViewHeight)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn], animations: {
            self.view.layoutIfNeeded()
            self.backgroundView.alpha = 0
        }) { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss(animated: false, completion: {
                self.delegate?.floatyPanelDidClose?(self)
                completion?()
            })
        }
    }
    
    /*
     MARK: Present logic
     */
    private func present() {
        panelViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
            self.backgroundView.alpha = 0.7
        }, completion: nil)
    }
    
    /*
     MARK: UI functions
     */
    private func setupBackgroundView() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0
        backgroundView.isUserInteractionEnabled = isInteractiveBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        backgroundView.addGestureRecognizer(tapGesture)
        
        view.addSubview(backgroundView)
        view.sendSubview(toBack: backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupGrabberView() {
        grabberViewContainer = UIView()
        grabberViewContainer.backgroundColor = UIColor.clear
        grabberViewContainer.isUserInteractionEnabled = true
        grabberViewContainer.isHidden = isGrabberHidden
        panelView.addSubview(grabberViewContainer)
        
        grabberViewContainer.translatesAutoresizingMaskIntoConstraints = false
        grabberViewContainer.topAnchor.constraint(equalTo: panelView.topAnchor, constant: 0).isActive = true
        grabberViewContainer.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 0).isActive = true
        grabberViewContainer.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: 0).isActive = true
        grabberViewContainer.heightAnchor.constraint(equalToConstant: GrabberViewContainerHeight).isActive = true
        
        let grabberView = UIView()
        grabberView.backgroundColor = UIColor.lightGray
        grabberView.clipsToBounds = true
        grabberViewContainer.addSubview(grabberView)
        
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        grabberView.topAnchor.constraint(equalTo: grabberViewContainer.topAnchor, constant: GrabberViewTop).isActive = true
        grabberView.centerXAnchor.constraint(equalTo: grabberViewContainer.centerXAnchor, constant: 0).isActive = true
        grabberView.heightAnchor.constraint(equalToConstant: GrabberViewHeight).isActive = true
        grabberView.widthAnchor.constraint(equalToConstant: GrabberViewWidth).isActive = true
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(dragPopover(_:)))
        grabberViewContainer.addGestureRecognizer(dragGesture)
    }
    
    /*
     MARK: Gesture recognizers functions
     */
    @objc
    private func hide() {
        hidePanel(with: nil)
    }

    @objc
    private func dragPopover(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            panelViewStartBottomPosition = panelViewBottomConstraint.constant
            contentViewBottomPadding = panelViewContentBottomConstraint?.constant ?? 0
            delegate?.floatyPanelWillBeginDragging?(self)
        case .changed:
            let translation = gesture.translation(in: panelView)
            let yPosition = panelViewStartBottomPosition - translation.y
            
            switch yPosition {
            case let x where x > 0:
                let position = yPosition * Delta
                panelViewContentBottomConstraint?.constant = contentViewBottomPadding + position
            default:
                panelViewBottomConstraint.constant = yPosition
            }
        case .cancelled, .ended:
            let translation = gesture.translation(in: panelView)
            let yPosition = panelViewStartBottomPosition - translation.y
            
            switch yPosition {
            case let x where x < -(panelViewHeight / CGFloat(PanelViewPart)):
                hidePanel(with: nil)
                state = .hidden
            default:
                panelViewBottomConstraint.constant = 0
                panelViewContentBottomConstraint?.constant = contentViewBottomPadding
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                    self.view.layoutSubviews()
                }, completion: nil)
                
                state = .full
            }
            
            delegate?.floatyPanelDidEndDragging?(self, targetPosition: state)
        default:
            break
        }
    }

}
