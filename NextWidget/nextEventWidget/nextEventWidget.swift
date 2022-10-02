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

        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffest in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffest, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, configuration: configuration)
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
    var config: MonthlyConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthlyConfig.determineConfig(from: entry.date)
    }

    var body: some View {
        ZStack{
            ContainerRelativeShape().fill(config.backgroundColor.gradient)
            VStack{
                Text("Event name").font(.title2).fontWeight(.bold).minimumScaleFactor(0.7)
                HStack(spacing: 4){
                    Text(config.emojiText).font(.title)
                    Text(entry.date.weekdayDisplayFormat).font(.title3).fontWeight(.bold).minimumScaleFactor(0.7).foregroundColor(config.weekdayTextColor.opacity(0.7))
                    Spacer()
                }
                Text(entry.date.dayDisplayFormat).font(.system(size: 80, weight: .heavy)).foregroundColor(config.dayTextColor.opacity(0.6))
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
        .configurationDisplayName("Styled Event Countdown widget")
        .description("Theme of widget changes based on event type").supportedFamilies([.systemSmall])
    }
}

struct nextEventWidget_Previews: PreviewProvider {
    static var previews: some View {
        nextEventWidgetEntryView(entry: DayEntry(date: dateToDisplay(year: 2022, month: 1, day: 22), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
    static func dateToDisplay(year: Int, month: Int, day:Int) -> Date {
        let components = DateComponents(calendar:Calendar.current,year: year, month: month, day:day)
        return Calendar.current.date(from: components)!
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
