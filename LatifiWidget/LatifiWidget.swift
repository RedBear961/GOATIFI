//
//  LatifiWidget.swift
//  LatifiWidget
//
//  Created by Георгий Черемных on 05.11.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    private let userDefaults = UserDefaults(suiteName: "group.com.webviewlab.latificounter")!
    
    func placeholder(in context: Context) -> WidgetContent {
        WidgetContent(date: Date(), count: 43)
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (WidgetContent) -> ()
    ) {
        let entry = WidgetContent(date: Date(), count: 43)
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let entry = WidgetContent(
            date: Date(),
            count: userDefaults.integer(forKey: "kLatifiCounter")
        )
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetContent: TimelineEntry {
    
    let date: Date
    let count: Int
}

struct LatifiWidgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            
            VStack {
                Spacer()
                
                Text("\(entry.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Spacer()
                
                VStack(spacing: 3) {
                    Text("widget.title", comment: "")
                        .fontWeight(.semibold)
                    
                    Text("widget.subtitle", comment: "")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 16)
                        .padding(.horizontal)
                }
            }
        }
    }
}

@main
struct LatifiWidget: Widget {
    
    let kind: String = "LatifiWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LatifiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("GOATIFI counter widget")
        .description("Сколько раз ты уже выпил за него?")
        .supportedFamilies([.systemSmall])
    }
}

struct LatifiWidget_Previews: PreviewProvider {
    static var previews: some View {
        LatifiWidgetEntryView(entry: WidgetContent(date: Date(), count: 43))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
