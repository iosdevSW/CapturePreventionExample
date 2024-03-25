//
//  PreventCaptureHostingViewController.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import SwiftUI

final class PreventCaptureHostingViewController<Content: View>: UIViewController {

    private let content: () -> Content
    private let wrapperView = CapturePreventingView()

    var isPrevented: Bool = true {
        didSet {
            wrapperView.preventCapture = isPrevented
        }
    }

    init(isPrevented: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isPrevented = isPrevented
        self.content = content
        super.init(nibName: nil, bundle: nil)

        setupUI()
        wrapperView.preventCapture = isPrevented
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        view.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let hostVC = UIHostingController(rootView: content())
        hostVC.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostVC)
        wrapperView.setup(contentView: hostVC.view)
        hostVC.didMove(toParent: self)
    }
}
