//
//  ApplicationSecurityError.swift
//  KISS Views
//

import Foundation

/// An enumeration representing app security issues.
enum ApplicationSecurityError: Error, Equatable, Codable, Hashable {
    case jailbrokenDevice
    case appTamperedWith
}
