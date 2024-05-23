//
//  AuthManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 21.05.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthManager {
    static let shared = AuthManager()
    private init () { }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
      let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    func logIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    func signOut() throws {
         try Auth.auth().signOut()
     }
}
