//
//  PreventCapture.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import SwiftUI

@available(iOS 13.0, *)

public struct PreventCaptureModifier: ViewModifier {
    
    public let isPrevented: Bool
    
    public func body(content: Content) -> some View {
        _CapturePreventView(isPrevented: isPrevented) {
            content
        }
    }
}

public extension View {
    func capturePrevented(isPrevented: Bool) -> some View {
        modifier(PreventCaptureModifier(isPrevented: isPrevented))
    }
}
