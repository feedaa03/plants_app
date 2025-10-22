import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("BackGroundColor")
                .ignoresSafeArea()
            
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("My Plants 🌱")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                Divider()
                    .background(Color.white.opacity(0.3))
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Main Body
            VStack(spacing: 24) {
                Spacer().frame(height: 80)
                
                Image("Plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .frame(maxWidth: .infinity)
                
                Text("Start your plant journey!")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.3))
                    .fontWeight(.semibold)
                    .padding(.bottom, 90)
                
                Button(action: { showSheet = true }) {
                    Text("Set Plant Reminder")
                    
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .buttonStyle(.glassProminent)
                        .background(
                            RoundedRectangle(cornerRadius: 23, style: .continuous)
                                .fill(Color("greenbutton"))
                        )
                        .padding(.horizontal, 60) // controls button width
                }
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            ReminderSheet()
        }
    }
}

// MARK: - Reminder Sheet
private struct ReminderSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color("BackGroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer().frame(height: 60)
                    
                    // Text Field
                    GlassTextField(
                        text: .constant(""),
                        title: "Plant Name",
                        placeholder: "",
                        icon: nil
                    )
                    
                    // Glass groups
                    GlassGroup {
                        GlassRow(title: "Room", value: "Bedroom", icon: "location", showDivider: true)
                        GlassRow(title: "Light", value: "Full Sun", icon: "sun.max.fill")
                    }
                    
                    GlassGroup {
                        GlassRow(title: "Watering Days", value: "Every Day", icon: "drop.fill", showDivider: true)
                        GlassRow(title: "Water", value: "20–50 ml", icon: "drop.fill")
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: 480)
                
                // Top Bar
                HStack {
                    // Dismiss (X)
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .buttonStyle(.glassProminent)
                            .foregroundStyle(.white.opacity(0.8))
                            .padding(10)
                            .background(Circle().fill(.ultraThinMaterial))
                            .overlay(
                                Circle().strokeBorder(Color.white.opacity(0.25), lineWidth: 0.5)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                    
                    Spacer()
                    
                    // Confirm (✓)
                    Button(action: {
                        // TODO: Handle confirm action
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Circle().fill(Color("greenbutton")))
                            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.thinMaterial)
        }
    }
}

// MARK: - Reusable Components

struct GlassTextField: View {
    @Binding var text: String
    var title: String?
    var placeholder: String
    var icon: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))
            }
            HStack(spacing: 12) {
                if let icon, !icon.isEmpty {
                    Image(systemName: icon)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 18))
                }
                TextField(placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct GlassGroup<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct GlassRow: View {
    var title: String
    var value: String
    var icon: String
    var showDivider: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: icon)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.white.opacity(0.85))
                    
                    Text(title)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack(spacing: 6) {
                    Text(value)
                        .foregroundStyle(.white.opacity(0.8))
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white.opacity(0.5))
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            
            if showDivider {
                Divider()
                    .background(Color.white.opacity(0.2))
                    .padding(.leading, 36)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
