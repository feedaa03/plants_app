import SwiftUI

// MARK: - Model
struct CheckboxItem: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var location: String      // ✅ أضفنا الموقع
    var isChecked: Bool
}

// MARK: - Main List View
struct TodayReminderList: View {
    @State private var items = [
        CheckboxItem(name: "Monstera", location: "in Kitchen", isChecked: false),
        CheckboxItem(name: "Pothos", location: "in Bedroom", isChecked: true),
        CheckboxItem(name: "Orchid", location: "in Living Room", isChecked: false),
        CheckboxItem(name: "Spider", location: "in Kitchen", isChecked: true),
    ]
    
    var body: some View {
        ZStack {
            Color("BackGroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Header
                Text("My Plants 🌱")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                Divider()
                    .background(Color.white.opacity(0.3))
                
                VStack {
                    Text("Your plants are waiting for a sip 💦")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    ProgressView(value: 20, total: 100)
                        .tint(.green)
                    
                    // List of items
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach($items) { $item in
                                VStack(spacing: 0) {
                                    TodayReminder(item: $item)
                                    
                                    // Thin divider between items
                                    Rectangle()
                                        .fill(Color.white.opacity(0.15))
                                        .frame(height: 1)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.vertical, 22) // space between each card
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Single Row
struct TodayReminder: View {
    @Binding var item: CheckboxItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            // 📍 Location line
            HStack(spacing: 4) {
              Image(systemName: "location")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 12))
                Text(item.location)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 13))
            }
            
            // ✅ Checkbox + plant name
            HStack(spacing: 12) {
                Button {
                    item.isChecked.toggle()
                } label: {
                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isChecked ? .green : .gray)
                        .font(.system(size: 22))
                }
                .buttonStyle(.plain)
                
                Text(item.name)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}


// MARK: - Preview
#Preview {
    TodayReminderList()
}
