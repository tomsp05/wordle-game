import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct widgetsEntryView : View {
    
    @AppStorage("AVGnumberOfGuesses") var AVGnumGuesses: Int = 0
    @AppStorage("LastNumberOfGuesses") var LastNumGuesses: Int = 0
    @AppStorage("correctGamesPlayed") var correctGamesPlayed: Int = 0
    @AppStorage("numGamesPlayed") var NumGamesPlayed: Int = 0
    @AppStorage("mostUsedCatagory") var mostUsedCatagory: String = ""
    @AppStorage("mostCorrectCatagory") var mostCorrectCatagory: String = ""
    
    var entry: Provider.Entry

    var body: some View {
        Text("Hello")
    }
}

struct widgets: Widget {
    let kind: String = "widgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetsEntryView(entry: entry)
        }
        .configurationDisplayName("User Statistics")
        .description("This is an example widget.")
    }
}

struct widgets_Previews: PreviewProvider {
    static var previews: some View {
        widgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
