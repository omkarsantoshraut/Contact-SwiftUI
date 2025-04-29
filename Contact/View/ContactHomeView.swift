import SwiftUI
import SwiftData

struct ContactHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var contacts: [Contact]
    @State private var showSheet = false
    @State private var searchedText: String = ""

    var filteredContacts: [Contact] {
        if searchedText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.firstName.localizedCaseInsensitiveContains(searchedText)
                || $0.lastName.localizedCaseInsensitiveContains(searchedText)
                || $0.email.localizedCaseInsensitiveContains(searchedText)
                || $0.number.localizedCaseInsensitiveContains(searchedText) }
        }
    }

    var body: some View {
        NavigationSplitView {
            NavigationStack {
                List {
                    ForEach(filteredContacts) { contact in
                        NavigationLink(value: contact, label: {
                            ContactCell(number: contact.number, firstName: contact.firstName, lastName: contact.lastName)
                                .padding([.top, .bottom])
                        })
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Contacts")
                .searchable(text: $searchedText, prompt: "Search")
            }
            .navigationDestination(for: Contact.self, destination: { contact in
                ContactDetailsView(contact: .constant(contact))
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                NavigationStack {
                    AddContactView(firstName: "", lastName: "", email: "", number: "")
                        .presentationDetents([.fraction(0.7)])
                }
            })
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        showSheet = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(contacts[index])
            }
        }
    }
}

#Preview {
    ContactHomeView()
        .modelContainer(for: Contact.self, inMemory: true)
}
