import SwiftUI

// MARK: - Model
struct CheckboxItem: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var location: String
    var isChecked: Bool
    var sunlight: String = "Full sun"
    var waterAmount: String = "20–50 ml"
}

// MARK: - Main List View
struct TodayReminderList: View {
    @State private var items = [
        CheckboxItem(name: "Monstera", location: "in Kitchen", isChecked: false),
        CheckboxItem(name: "Pothos", location: "in Bedroom", isChecked: true),
        CheckboxItem(name: "Orchid", location: "in Living Room", isChecked: false),
        CheckboxItem(name: "Spider", location: "in Kitchen", isChecked: true),
    ]
    
    @State private var showAddPlantSheet = false
    
    private var countsOfcheck: Double {
        guard !items.isEmpty else { return 0 }
        let checked = items.filter { $0.isChecked }.count
        return (Double(checked) / Double(items.count)) * 100.0
    }
    
    private var plantsStatusText: String {
        let count = items.filter { $0.isChecked }.count
        switch count {
        case 0:
            return "Your plants are waiting for a sip 💦"
        case 1:
            return "1 of your plants feels loved today ✨"
        case items.count:
            return "All your plants are happy today 🌸"
        default:
            return "\(count) of your plants feel loved today ✨"
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                    Text(plantsStatusText)
                        .foregroundColor(.white.opacity(0.85))
                        .font(.headline)
                        .padding(.bottom, 8)
                        .animation(.easeInOut(duration: 0.3), value: plantsStatusText)
                    
                    ProgressView(value: countsOfcheck, total: 100)
                        .tint(.green)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach($items) { $item in
                                VStack(spacing: 0) {
                                    TodayReminder(item: $item)
                                    
                                    Rectangle()
                                        .fill(Color.white.opacity(0.15))
                                        .frame(height: 1)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.vertical, 22)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.horizontal)
            
            // ✅ زر الإضافة (+)
            Button(action: {
                showAddPlantSheet.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.green)
                    .clipShape(Circle())
                    .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
            .sheet(isPresented: $showAddPlantSheet) {
                VStack(spacing: 16) {
                    Text("Add Plant")
                        .font(.title2.bold())
                    Text("This is a placeholder sheet. Replace with your add-plant form when ready.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Close") { showAddPlantSheet = false }
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                .presentationDetents([.large])
            }
        }
    }
}

// MARK: - Single Row
struct TodayReminder: View {
    @Binding var item: CheckboxItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "location")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 12))
                Text(item.location)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 13))
            }
            
            HStack(spacing: 12) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        item.isChecked.toggle()
                    }
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
            
            HStack(spacing: 12) {
                Label {
                    Text(item.sunlight)
                        .font(.caption)
                        .foregroundColor(.yellow)
                } icon: {
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.yellow.opacity(0.15))
                .cornerRadius(8)
                
                Label {
                    Text(item.waterAmount)
                        .font(.caption)
                        .foregroundColor(.blue)
                } icon: {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(8)
            }
            .padding(.leading, 34)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Preview
#Preview {
    TodayReminderList()
}
