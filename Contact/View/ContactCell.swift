import SwiftUI

struct ContactCell: View {
    let number: String
    let firstName: String
    let lastName: String

    var initials: String {
        return String(firstName.first ?? Character("")) + String(lastName.first ?? Character(""))
    }

    var body: some View {
        HStack {
            Text(initials)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)
                .frame(maxWidth: 60, maxHeight: .infinity)
                .background(Circle().fill(.white))
                .overlay(Circle().stroke(.gray, lineWidth: 4))
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text("\(firstName) \(lastName)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Text(number)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .opacity(0.5)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContactCell(number: "1111111111", firstName: "Demo", lastName: "Demo")
}
