//
//  FeedbackViewProtocol.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 01/12/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation

/// Base interface to report view common UI messages for user feedback.
protocol FeedbackViewProtocol: class {
    
    /// Show some UI feedback to user for loading data status.
    ///
    /// - Parameter message: optional message for loading control.
    func showLoading(message: String?)
    
    /// Dismiss from ui the current loading indicator.
    func dismissLoading()
    
    /// Show some UI feedback to user to report some error situation.
    ///
    /// - Parameter message: optional message for error description.
    func showError(message: String?)
    
    /// Show some UI feedback to user to report action finish with success.
    ///
    /// - Parameter message: optional message for success situation.
    func showSuccess(message: String?)
}

// MARK: - Extension with empty default implementation (to allow the protocol be optional).
extension FeedbackViewProtocol {
    
    func showLoading(message: String?) {}
    func dismissLoading() {}
    func showError(message: String?) {}
    func showSuccess(message: String?) {}
}
