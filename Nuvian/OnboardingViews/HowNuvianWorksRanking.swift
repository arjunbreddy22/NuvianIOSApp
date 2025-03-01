import SwiftUI

struct HowNuvianWorksRanking: View {
    @State private var isPressed: Bool = false
    @State private var buttonScale: CGFloat = 1.0

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient for visual depth
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 10/255, green: 25/255, blue: 85/255),
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Wrap content in ScrollView for smaller screens
                ScrollView {
                    VStack(spacing: 20) {
                        // Title
                        Text("How Nuvian Works: Ranking")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 40)
                        
                        // Ranking Icons Section
                        VStack(spacing: 20) {
                            HStack {
                                Bronze(w: 150, h: 150, textInput: "I", textSize: 60)
                                Spacer()
                                Silver(w: 150, h: 150, textInput: "I", textSize: 60)
                            }
                            .padding(.horizontal)
                            
                            Gold(w: 150, h: 150, textInput: "I", textSize: 60)
                                .padding(.horizontal)
                        }
                        
                        // Description Text – layoutPriority ensures it gets enough space
                        Text("Nuvian keeps you motivated to stick to your sleep goals with a ranking system and a streak tracker. Your rank improves as you stay consistent, and your current streak serves as a daily reminder of your progress. Let's master your sleep!")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                            .padding(.horizontal)
                            .layoutPriority(1)
                        
                        // Next Button with scaling animation on tap
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                buttonScale = 0.95
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    buttonScale = 1.0
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
                        .scaleEffect(buttonScale)
                    }
                }
                .navigationDestination(isPresented: $isPressed) {
                    PickAppsToBlock()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowNuvianWorksRanking()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
