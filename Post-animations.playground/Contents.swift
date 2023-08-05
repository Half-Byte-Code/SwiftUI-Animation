import SwiftUI
import PlaygroundSupport

extension String: Identifiable {
    public var id: String {
        self
    }
}

extension Double: Identifiable {
    public var id: Double {
        self
    }
}

struct AnimatingBar: View {
    var width: CGFloat?
    var height: CGFloat?
    var body: some View {
        Rectangle()
            .background(Color.init(UIColor.lightGray))
            .frame(width: width, height: height)
            .phaseAnimator([0.1,0.5]) { content, phase in
                content
                    .opacity(phase)
            }
    }
}

struct ContentView: View {
    @State var animatingBarSize: [Double] = [100, 200, 120, 160]
    @State var data = ["😀","😁","😂","🥲","😍","😋","🤪","😡"]
    
    @State var selectedEmoji: String?
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 200)
                
                // animating horizontal bars
                VStack(alignment: .leading) {
                    ForEach(animatingBarSize) { size in
                        VStack {
                            AnimatingBar(width: size, height: 30)
                        }
                    }
                }
                
                Spacer()
                
                // Bottom emoji view
                LazyHStack {
                    ForEach(data) { val in
                        Text(val)
                            .font(.system(size: 30))
                            .onTapGesture {
                                selectedEmoji = val
                            }
                            .phaseAnimator([0,20], trigger: selectedEmoji) { content, phase in
                                if selectedEmoji == val {
                                    content
                                        .scaleEffect(phase == 0 ? 1 : phase/10)
                                        .transformEffect(.init(translationX: 0, y: -phase))
                                } else {
                                    content
                                }
                            }
                    }
                }
                .frame(alignment: .bottom)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.purple, in: .rect)
            
            // Overlay animation with selected emoji
            Text(selectedEmoji ?? "")
                .font(.system(size: 80))
                .phaseAnimator([0,1], trigger: selectedEmoji) { content, phase in
                    content
                        .rotationEffect(.degrees(phase*360.0))
                        .scaleEffect(phase*2)
                        .opacity(phase)
                }
        }
    }
}


let example = ContentView()
PlaygroundPage.current.setLiveView(example.frame(width: 320, height: 540, alignment: .center))

