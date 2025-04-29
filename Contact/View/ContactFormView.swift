import SwiftUI

struct ContactFormView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var number: String
    @Binding var showValidationError: Bool
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("First Name")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    TextField(text: $firstName, label: {
                        Text("Enter your first name.")
                            .font(.callout)
                    })
                    .autocorrectionDisabled()
                    .font(.callout)
                    .opacity(0.7)
                    
                    if showValidationError && firstName.isEmpty {
                        Text("First name is required")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last Name")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    TextField(text: $lastName, label: {
                        Text("Enter your last name.")
                            .font(.callout)
                    })
                    .autocorrectionDisabled()
                    .font(.callout)
                    .opacity(0.7)
                    
                    if showValidationError && lastName.isEmpty {
                        Text("Last name is required")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    TextField(text: $email, label: {
                        Text("Enter your email address.")
                            .font(.callout)
                    })
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .font(.callout)
                    .opacity(0.7)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Mobile Number")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    TextField(text: $number, label: {
                        Text("Enter your mobile number.")
                            .font(.callout)
                    })
                    .keyboardType(.phonePad)
                    .autocorrectionDisabled()
                    .font(.callout)
                    .opacity(0.7)
                    
                    if showValidationError && number.isEmpty {
                        Text("Mobile number is required")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    if showValidationError && !number.isEmpty && number.count != 10 {
                        Text("Invalid mobile number")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    ContactFormView(firstName: .constant("Demo"), lastName: .constant("Demo"), email: .constant("Demo"), number: .constant("Demo"), showValidationError: .constant(true))
}
