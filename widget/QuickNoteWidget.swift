//
//  widget.swift
//  widget
//
//  Created by Max Zhang on 2022/8/29.
//

import WidgetKit
import SwiftUI
import Intents
import RealmSwift

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
//    let configuration: ConfigurationIntent
    var content: String
}

let snapshotEntry = SimpleEntry(content: "This is snpashot entry...")

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(content: "T")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
            let realm = RealmManager.shared
            let entry = realm.getEntries().first!
            let simpleEntry = SimpleEntry(content: entry.content)
            completion(simpleEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let realm = RealmManager.shared
            let entry = realm.getEntries().first!
            let simpleEntry = SimpleEntry(content: entry.content)
            entries.append(simpleEntry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



struct widgetEntryView : View {
    @State var entry: Provider.Entry

    var body: some View {
        Text(entry.content)
            .padding()
            .font(.system(size: 14))
    }
}

struct QuickNoteWidget: Widget {
    let kind: String = "QuickNoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quick Note")
        .description("Quick note from you home screen.")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(content: "This is  a preview content."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

@main
struct FlashWdiget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        QuickNoteWidget()
    }
}
