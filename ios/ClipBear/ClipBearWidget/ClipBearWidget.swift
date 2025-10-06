import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    private let appGroupIdentifier = "group.com.clipbear.mvp"
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), suggestion: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let suggestion = getLatestSuggestion()
        let entry = SimpleEntry(date: Date(), suggestion: suggestion)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Create a timeline entry for now
        let currentDate = Date()
        let suggestion = getLatestSuggestion()
        let entry = SimpleEntry(date: currentDate, suggestion: suggestion)
        entries.append(entry)

        // Create a timeline that refreshes every hour
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
    
    private func getLatestSuggestion() -> String? {
        guard let sharedDefaults = UserDefaults(suiteName: appGroupIdentifier) else {
            return nil
        }
        return sharedDefaults.string(forKey: "latest_suggestion")
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let suggestion: String?
}

struct ClipBearWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            // Tinker Avatar
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Text("🤖")
                        .font(.title2)
                )
                .accessibilityLabel("Tinker, your companion avatar")
            
            // Widget Title
            Text("Tinker")
                .font(.caption)
                .fontWeight(.semibold)
            
            // Suggestion or placeholder
            if let suggestion = entry.suggestion {
                Text(suggestion)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .accessibilityLabel("Latest suggestion: \(suggestion)")
            } else {
                Text("Ready to help!")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("No suggestions yet, Tinker is ready to help")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .widgetURL(URL(string: "clipbear://open"))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(widgetAccessibilityLabel)
        .accessibilityHint("Tap to open ClipBear app")
    }
    
    private var widgetAccessibilityLabel: String {
        if let suggestion = entry.suggestion {
            return "ClipBear widget. Latest suggestion: \(suggestion)"
        } else {
            return "ClipBear widget. No suggestions yet. Tinker is ready to help."
        }
    }
}

@main
struct ClipBearWidget: Widget {
    let kind: String = "ClipBearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ClipBearWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("ClipBear Companion")
        .description("Your digital companion on the home screen")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ClipBearWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClipBearWidgetEntryView(entry: SimpleEntry(date: Date(), suggestion: "Take a break?"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
