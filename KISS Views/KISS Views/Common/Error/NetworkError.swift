//
//  NetworkError.swift
//  KISS Views
//

import Foundation

/// An enumeration describing a network error.
enum NetworkError: Error, Equatable, Codable, Hashable {
    case notFound
    case forbidden
    case unauthorized
    case invalidRequest(code: Int, message: String?)
    case serverMaintenance(message: String?)
    case serverError(code: Int, message: String?)
    case custom(code: Int, message: String?)
}

extension NetworkError {

    /// A convenience initializer for NetworkError.
    /// Use to convert generic network errors to NetworkError type.
    ///
    /// - Parameters:
    ///   - code: an error code.
    ///   - message: an optional error message.
    init?(code: Int, message: String?) {
        switch code {
        case 200...399:
            return nil
        case 404:
            self = .notFound
        case 403:
            self = .forbidden
        case 401:
            self = .unauthorized
        case 400...499:
            self = .invalidRequest(code: code, message: message)
        case 510:
            self = .serverMaintenance(message: message)
        case 500...599:
            self = .serverError(code: code, message: message)
        default:
            self = .custom(code: code, message: message)
        }
    }
}
