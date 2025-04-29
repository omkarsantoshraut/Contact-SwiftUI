import SwiftUI

struct AddContactView: View {
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var number: String
    
    @State private var showValidationError: Bool = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            NavigationView(content: {
                
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Contact")
            
            VStack {
                ContactFormView(firstName: $firstName, lastName: $lastName, email: $email, number: $number, showValidationError: $showValidationError)
                
                Button(action: {
                    showValidationError = true
                    withAnimation {
                        guard !firstName.isEmpty, !lastName.isEmpty, !number.isEmpty, number.count == 10 else {
                            return
                        }
                        let newItem = Contact(
                            timestamp: Date(),
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            number: number)
                        modelContext.insert(newItem)
                        dismiss()
                    }
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .font(.title3)
                        .fontWeight(.semibold)
                })
            }
        }
    }
}

#Preview {
    AddContactView(firstName: "Demo", lastName: "Demo", email: "test@gmail.com", number: "1111111111")
}
