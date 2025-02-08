import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var storedPassword: String? = UserDefaults.standard.string(forKey: "userPassword")
    @State private var isLoggedIn = false
    @State private var loginAttempts = 0
    @State private var isBlocked = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                VStack {
                    HStack {
                        Text("Login")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                
                
                                VStack(spacing: 20) {
                                    
                                    TextField("", text: $username, prompt: Text("User Name").foregroundColor(.blue))
                                        .padding()
                                        .foregroundColor(.blue)
                                        .accentColor(.blue)
                                        
                                        
                                        .padding()
                                        .frame(height: 50)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue, lineWidth: 1)
                                        )
                                        .padding(.horizontal, 20)
                                        .onChange(of: username) { _ in resetBlockState() }
                                    
                                    
                                    SecureField("", text: $password, prompt: Text("Password").foregroundColor(.blue))
                                        .padding()
                                        .foregroundColor(.blue)
                                        .accentColor(.blue)
                                        .foregroundColor(.blue)
                                        .padding()
                                        .frame(height: 50)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue, lineWidth: 1)
                                        )
                                        .padding(.horizontal, 20)
                                        .onChange(of: password) { _ in resetBlockState() }
                    
                    Button(action: {
                        if isBlocked {
                            return
                        }
                        
                        if let savedPassword = storedPassword {
                            if password == savedPassword {
                                UserDefaults.standard.set(username, forKey: "currentUser")
                                isLoggedIn = true
                                loginAttempts = 0
                                isBlocked = false
                            } else {
                                loginAttempts += 1
                                let attemptsLeft = 3 - loginAttempts
                                
                                if loginAttempts >= 3 {
                                    isBlocked = true
                                    alertMessage = "You are blocked from the app"
                                } else {
                                    alertMessage = "Incorrect password. Attempts left: \(attemptsLeft)"
                                }
                                showAlert = true
                            }
                        } else {
                            UserDefaults.standard.set(password, forKey: "userPassword")
                            storedPassword = password
                            UserDefaults.standard.set(username, forKey: "currentUser")
                            isLoggedIn = true
                        }
                    }) {
                        Text("Login")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(isBlocked ? Color.gray : Color.orange)
                            
                    }
                    .disabled(isBlocked)
                    .padding(.horizontal, 20)
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .background(Color.white)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Attempt"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            NavigationLink("", destination: NotificationView(), isActive: $isLoggedIn)
        }
    }
    private func resetBlockState() {
            if isBlocked {
                loginAttempts = 0
                isBlocked = false
            }
        }
}

