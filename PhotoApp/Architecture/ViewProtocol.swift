//
//  ViewProtocol.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 01/12/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation

/// Base view interface for common tasks.
protocol ViewProtocol: class {
    
    /// Setup the UI view.
    func setupUI()
    
    /// Localized UI.
    func localizeView()
}

// MARK: - Extension with empty default implementation (to allow the protocol be optional).
extension ViewProtocol {
    
    func setupUI() {}
    func localizeView() {}
}
