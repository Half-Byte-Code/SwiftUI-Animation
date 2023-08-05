import SwiftUI
import PlaygroundSupport

struct ContentItem: View, Identifiable, Equatable {
    @State var title: String
    @State var color: Color
    var id: String {
        title
    }
    
    var body: some View {
        HStack {
            Text(title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color, in: .rect)
    }
    
    static func == (lhs: ContentItem, rhs: ContentItem) -> Bool {
        lhs.title == rhs.title
    }
}

struct ContentView: View {
    @State var selectedItem: ContentItem?
    var items: [ContentItem]
    var smallViewHeight = 80.0
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(items) { item in
                item
                    .frame(maxHeight: selectedItem == item ? .infinity : smallViewHeight)
                    .onTapGesture {
                        selectedItem = item
                    }
                    .animation(.smooth(duration: 0.2), value: selectedItem)
            }
        }
    }
}


let example = ContentView(items: [
    ContentItem(title: "First View", color: .blue.opacity(0.4)),
    ContentItem(title: "Second view", color: .red.opacity(0.4)),
    ContentItem(title: "Third view", color: .green.opacity(0.4)),
    ContentItem(title: "Fourth view", color: .brown.opacity(0.4)),
    ContentItem(title: "Fifth view", color: .cyan.opacity(0.4)),
])
PlaygroundPage.current.setLiveView(example.frame(width: 320, height: 540, alignment: .center))

