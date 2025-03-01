import SwiftUI

struct HowNuvianWorksBlocking: View {
    @State private var isPressed: Bool = false
    @State private var scale: CGFloat = 1.0

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient for depth and visual interest
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 10/255, green: 25/255, blue: 85/255),
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Title
                        Text("How Nuvian Works: Blocking")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 40)
                        
                        // Custom image or illustration
                        InstagramXImage()
                            .padding(.vertical, 20)
                        
                        // Description Text
                        Text("Nuvian blocks distracting apps on sleep schedules you set. You are free to unblock these apps after a short delay, but that's where the next core feature of Nuvian comes in...")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                        // Next Button with scaling animation on tap
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                scale = 0.95
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    scale = 1.0
                                }
                                isPressed = true
                            }
                        }) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(Color(red: 10/255, green: 25/255, blue: 85/255))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(Color.white)
                                )
                                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                        .scaleEffect(scale)
                    }
                }
                .navigationDestination(isPresented: $isPressed) {
                    HowNuvianWorksRanking()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowNuvianWorksBlocking()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
