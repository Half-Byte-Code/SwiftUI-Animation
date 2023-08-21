import SwiftUI
import PlaygroundSupport

struct Person: Identifiable, Equatable {
    var id: String {
        name
    }
    
    let name: String
    let imageUrl: String
    let gender: String
    let age: Int
}

let people = [
    Person(name: "Sam", imageUrl: "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80", gender: "Male", age: 26),
    Person(name: "Jurica", imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80", gender: "Male", age: 28),
    Person(name: "Jan", imageUrl: "https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80", gender: "Female", age: 28),
    Person(name: "Hannah", imageUrl: "https://images.unsplash.com/photo-1499887142886-791eca5918cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80", gender: "Female", age: 22)
]

struct ContentView: View {
    
    @State private var scrollId: String?
    @State private var person: Person?
    
    var body: some View {
        VStack {
            // Images horizontal scroll
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(people) { person in
                        // load image
                        AsyncImage(
                            url: URL.init(string: person.imageUrl),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 200, maxHeight: 200)
                            },
                            placeholder: {
                                Rectangle()
                                    .foregroundColor(.gray)
                            }
                        )
                        .frame(width: 200, height: 200)
                        .clipShape(.circle)
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.7)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.7)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollId)
            .onChange(of: scrollId) { old, new in
                person = people.first(where: { $0.id == new })
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden, axes: .horizontal)
            .safeAreaPadding(.horizontal, 60)
            .frame(height: 200)
            .padding()
            
            // Bottom info list
            VStack {
                Text(person?.name ?? "")
                    .font(.headline)
                    .padding(2)
                Text("Age: " + String(person?.age ?? 0))
                    .font(.subheadline)
                    .padding(2)
                Text("Gender: " + (person?.gender ?? ""))
                    .font(.subheadline)
                    .padding(2)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
                    .padding(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))

            }
            .contentMargins(10)
            .phaseAnimator([1, 0.6, 1], trigger: person) { content, phase in
                // animate on change of selected person
                content
                    .opacity(phase)
                    .scaleEffect(phase)
            }
        }
        .frame(width: 320, height: 540)
        .background(.purple.opacity(0.4))
    }
    
}


let example = ContentView()
PlaygroundPage.current.setLiveView(example.frame(width: 320, height: 540, alignment: .center))

