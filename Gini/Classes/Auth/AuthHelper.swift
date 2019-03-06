//
//  AuthHelper.swift
//  Gini
//
//  Created by Enrique del Pozo Gómez on 3/4/19.
//

import Foundation

final class AuthHelper {
        
    static func authorizationHeader(for accessToken: String, headerType: AuthType) -> HTTPHeader {
        return ("Authorization", "\(headerType.rawValue) \(accessToken)")
    }
        
    static func isTokenStillValid(expirationDateString: String?) -> Bool {
        guard let expirationDateString = expirationDateString,
            let expirationDate = DateFormatter().date(from: expirationDateString) else { return false }
        
        return Date() < expirationDate
    }
    
    static func generateUser(with domain: String) -> User {
        return User(email: "\(UUID().uuidString)@\(domain)",
                    password: UUID().uuidString)
    }
    
    static func encoded(credentials: Credentials) -> String {
        let credentials = "\(credentials.id):\(credentials.password)"
        let credData = credentials.data(using: .utf8)
        return "\(credData?.base64EncodedString() ?? "")"
    }
}
