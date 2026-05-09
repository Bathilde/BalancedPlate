import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), topNutrients: [.iron: 0.8, .vitaminC: 0.6, .zinc: 0.5])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), topNutrients: [.iron: 0.8, .vitaminC: 0.6, .zinc: 0.5])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(date: Date(), topNutrients: [.iron: 0.8, .vitaminC: 0.6, .zinc: 0.5]) // Mock data for now
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let topNutrients: [Nutrient: Double]
}

struct BalancedPlateWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Progress")
                .font(.caption)
                .fontWeight(.bold)
            
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(Array(entry.topNutrients.keys.prefix(3)), id: \.self) { nutrient in
                    VStack {
                        GeometryReader { proxy in
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(colorForNutrient(nutrient))
                                    .frame(height: proxy.size.height * CGFloat(entry.topNutrients[nutrient] ?? 0.0))
                            }
                        }
                        
                        Text(nutrient.rawValue.prefix(3).capitalized)
                            .font(.system(size: 10))
                    }
                }
            }
            
            Link(destination: URL(string: "balancedplate://log")!) {
                Text("Log Meal")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    private func colorForNutrient(_ nutrient: Nutrient) -> Color {
        switch nutrient {
        case .iron: return .red
        case .vitaminD: return .orange
        case .b12: return .purple
        case .calcium: return .gray
        case .magnesium: return .green
        case .zinc: return .blue
        case .vitaminC: return .yellow
        }
    }
}

struct BalancedPlateWidget: Widget {
    let kind: String = "BalancedPlateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BalancedPlateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Nutrient Status")
        .description("Track your top 3 nutrients today.")
        .supportedFamilies([.systemSmall])
    }
}
