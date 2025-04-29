import SwiftUI

struct ContactDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Binding var contact: Contact
    @State var isAlertPresented: Bool = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var number: String = ""
    @State private var showValidationError: Bool = false

    private var shouldEnableSaveButton: Bool {
        let value = firstName != contact.firstName
        || lastName != contact.lastName
        || email != contact.email
        || number != contact.number
        
        return !value
    }

    var body: some View {
        ZStack {
            NavigationView(content: {
                
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit Contact")
            
            VStack {
                ContactFormView(firstName: $firstName, lastName: $lastName, email: $email, number: $number, showValidationError: $showValidationError)
                
                Button(action: {
                    isAlertPresented = true
                }, label: {
                    Text("Delete Contact")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .foregroundStyle(.white)
                        .background(.red)
                        .font(.title3)
                        .fontWeight(.semibold)
                })
            }
            .alert(
                "Deleting Contact?",
                isPresented: $isAlertPresented,
                actions: {
                    Button(role: .destructive, action: {
                        deleteItems()
                    }, label: {
                        Text("Delete")
                    })

                    Button("Cancel", role: .cancel, action: {})
                },
                message: {
                    Text("Deleting contact will lose all information of the contact.")
                })
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(
                    action: updateItem,
                    label: {
                        Text("Save")
                            .disabled(shouldEnableSaveButton)
                    })
            }
        }
        .onAppear {
            firstName = contact.firstName
            lastName = contact.lastName
            email = contact.email
            number = contact.number
        }
        .onChange(of: contact, {
            firstName = contact.firstName
            lastName = contact.lastName
            email = contact.email
            number = contact.number
        })
    }

    private func deleteItems() {
        withAnimation {
            modelContext.delete(contact)
            dismiss()
        }
    }

    private func updateItem() {
        showValidationError = true
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !number.isEmpty, number.count == 10 else {
            return
        }
        contact.firstName = firstName
        contact.lastName = lastName
        contact.email = email
        contact.number = number
        try? modelContext.save()
    }
}

#Preview {
    ContactDetailsView(contact: .constant(Contact(timestamp: Date(), firstName: "Demo", lastName: "Demo", email: "test@gmail.com", number: "1111111111")))
}
