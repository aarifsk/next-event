//
//  nextEventWidget.swift
//  nextEventWidget
//
//  Created by Aarif Shaikh on 2022/10/02.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = DayEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct nextEventWidgetEntryView : View {
    var entry: DayEntry

    var body: some View {
        ZStack{
            ContainerRelativeShape().fill(.gray.gradient)
            VStack{
                HStack(spacing: 4){
                    Text("❄️").font(.title)
                    Text(entry.date.weekdayDisplayFormat).font(.title3).fontWeight(.bold).minimumScaleFactor(0.7).foregroundColor(.black.opacity(0.7))
                    Spacer()
                }
                Text(entry.date.dayDisplayFormat).font(.system(size: 80, weight: .heavy)).foregroundColor(.white.opacity(0.6))
            }
            .padding()
        }
        
    }
}

@main
struct nextEventWidget: Widget {
    let kind: String = "nextEventWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            nextEventWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct nextEventWidget_Previews: PreviewProvider {
    static var previews: some View {
        nextEventWidgetEntryView(entry: DayEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}
