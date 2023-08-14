import SwiftUI
import PlaygroundSupport



struct ContentView: View {
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack {
                    
                    // animating flag
                    TimelineView(.animation) { timelineCtx in
                        Canvas { context, size in
                            let angle = Angle.degrees(
                                timelineCtx
                                    .date
                                    .timeIntervalSinceReferenceDate
                                    .remainder(dividingBy: 4) * 180)
                            let cos = (cos(angle.radians)) * 11
                            let sin = (sin(angle.radians)) * 9
                            let height = size.height/3
                            
                            // orange color
                            var path = Path { path in
                                path.move(to: CGPoint(x: 0 , y: 10+height/2 ))
                                
                                path.addCurve(to: CGPoint(x: size.width, y: 10+height/2),
                                              control1: CGPoint(x: size.width * 0.4 , y: height * 0.2 - cos + 10),
                                              control2: CGPoint(x: size.width * 0.6 , y: height * 0.8 + sin + 10))
                            }
                            
                            context.stroke(path, with: .linearGradient(
                                Gradient(colors: [.orange, .orange.opacity(0.6)]),
                                startPoint: .zero ,
                                endPoint: CGPoint(x: size.width, y: size.height)), lineWidth: 30)
                            
                            //white color
                            path = Path { path in
                                path.move(to: CGPoint(x: 0 , y: 40+height/2 ))
                                
                                path.addCurve(to: CGPoint(x: size.width, y: 40+height/2),
                                              control1: CGPoint(x: size.width * 0.4 , y: height * 0.2 - cos + 40),
                                              control2: CGPoint(x: size.width * 0.6 , y: height * 0.8 + sin + 40))
                            }
                            
                            context.stroke(path, with: .color(.white), lineWidth: 30)
                            
                            // spoke
                            context.stroke(Path(ellipseIn: CGRect(x: size.width * 0.4, y: height * 0.2 + sin/4 - cos/4 + 40, width: 20, height: 20)), with: .color(.black.opacity(0.5)))
                            
                            // green color
                            path = Path { path in
                                path.move(to: CGPoint(x: 0 , y: height/2 + 70 ))
                                
                                path.addCurve(to: CGPoint(x: size.width, y: height/2 + 70),
                                              control1: CGPoint(x: size.width * 0.4 , y: height * 0.2 - cos + 70),
                                              control2: CGPoint(x: size.width * 0.6 , y: height * 0.8 + sin + 70))
                            }
                            
                            context.stroke(path, with: .linearGradient(
                                Gradient(colors: [.green, .green.opacity(0.6)]),
                                startPoint: .zero ,
                                endPoint: CGPoint(x: size.width, y: size.height)), lineWidth: 30)
                        }
                    }
                    .frame(width: 200, height: 110)
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                
                // Stand
                Canvas { context, size in
                    context.fill(Path(ellipseIn: CGRect(x: 225, y: 395, width: 40, height: 10)), with: .color(.gray))
                    context.fill(Path(CGRect(x: 225, y: 400, width: 40, height: 10)), with: .color(.gray))
                    context.stroke(Path(ellipseIn: CGRect(x: 225, y: 395, width: 40, height: 10)), with: .color(.black.opacity(0.4)))
                    context.fill(Path(roundedRect: CGRect(x: 155, y: 410, width: 130, height: 20), cornerRadius: 5), with: .color(.gray))
                    context.fill(Path(roundedRect: .init(x: 240, y: 0, width: 10, height: 400), cornerSize: .init(width: 10, height: 10)), with: .color(.red))
                }
                .padding()
                .frame(width: 320, height: 540)
                .border(.purple)
                
                // Text
                VStack {
                    Text("HAPPY")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                    Text("INDEPENDENCE")
                        .font(.system(size: 30))
                        .overlay {
                            LinearGradient(
                                colors: [.orange, .white, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask {
                                Text("INDEPENDENCE")
                                    .font(.system(size: 30))
                            }
                        }
                    Text("DAY")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                    
                }
                .padding(EdgeInsets(top: 250, leading: -80, bottom: 0, trailing: 0))
                
                
            }
        }
        .padding(150)
        .background(LinearGradient(colors: [.purple.opacity(0.3), .purple.opacity(0.8)], startPoint: .top, endPoint: .bottom))
    }
}


let example = ContentView()
PlaygroundPage.current.setLiveView(example.frame(width: 320, height: 540, alignment: .center))

