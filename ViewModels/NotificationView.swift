import SwiftUI

struct NotificationView: View {
    @State private var username = UserDefaults.standard.string(forKey: "currentUser") ?? "User Name"

    var notifications = Array(1...8)
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 36)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Notification")
                        .font(.headline)
                        .padding(.top, 27)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .edgesIgnoringSafeArea(.top)

            Text("Welcome \(username)!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.vertical, 10)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(notifications, id: \.self) { _ in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)

                            VStack(alignment: .leading) {
                                Text("Notification Title")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)

                                Text(currentDate())
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding()
                        Divider() 
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
    }

    private func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: Date())
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
