import Foundation

class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    func signUp() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields."
            return
        }
        
        KeychainHelper.savePassword(password, for: username)
        UserDefaults.standard.set(username, forKey: "currentUser")
        isAuthenticated = true
    }

    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields."
            return
        }
        
        if let storedPassword = KeychainHelper.getPassword(for: username), storedPassword == password {
            UserDefaults.standard.set(username, forKey: "currentUser")
            isAuthenticated = true
        } else {
            errorMessage = "Invalid username or password."
        }
    }
}
