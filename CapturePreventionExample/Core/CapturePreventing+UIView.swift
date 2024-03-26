//
//  CapturePreventing+UIView.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import UIKit

public final class CapturePreventingView: UIView {

    public var preventCapture = true {
        didSet {
            textField.isSecureTextEntry = preventCapture
        }
    }

    public override var isUserInteractionEnabled: Bool {
        didSet {
            containerView?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    private var contentView: UIView?
    private let textField = UITextField()
    
    private lazy var containerView: UIView? = try? getTextFieldContainer(from: textField)

    public init(contentView: UIView? = nil) {
        self.contentView = contentView
        super.init(frame: .zero)
        
        setupUI()
    }
    
    public init(isPrevented: Bool, contentView: UIView) {
        self.contentView = contentView
        preventCapture = isPrevented
        super.init(frame: .zero)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false

        guard let container = containerView else { return }
        container.backgroundColor = .red
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
//            container.leadingAnchor.constraint(equalTo: leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: trailingAnchor),
//            container.topAnchor.constraint(equalTo: topAnchor),
//            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        guard let contentView = contentView else { return }
        setup(contentView: contentView)

        DispatchQueue.main.async {
            self.preventCapture = true
        }
    }

    public func setup(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView

        guard let container = containerView else { return }

        container.addSubview(contentView)
        container.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: container.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            bottomConstraint
        ])
    }
}

fileprivate extension CapturePreventingView {
    enum PreventionError: Error {
        case containerEmpty
    }
    
    func getTextFieldContainer(from view: UIView) throws -> UIView {
        
        guard let container = view.subviews.last else {
            throw PreventionError.containerEmpty
        }
        
        return container
    }
}
