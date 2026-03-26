import SwiftUI

/// Matches Play page: SplashScreen — 3-slide carousel with indicators + controls
struct SplashScreenView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentSlide = 0

    var body: some View {
        ZStack {
            MindAlertTheme.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Carousel
                TabView(selection: $currentSlide) {
                    slide1.tag(0)
                    slide2.tag(1)
                    slide3.tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                // Page indicators
                HStack(spacing: MindAlertTheme.Spacing._8) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(currentSlide == index ? MindAlertTheme.staticWhite : MindAlertTheme.staticWhite.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, MindAlertTheme.Spacing._24)

                // Controls
                VStack(spacing: MindAlertTheme.Spacing._12) {
                    MAButton(title: "Get started", style: .primary) {
                        router.navigate(to: .initial)
                    }
                    MAButton(title: "Log in", style: .tertiary) {
                        // Log in flow (future)
                    }
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .padding(.bottom, MindAlertTheme.Spacing._32)
            }
        }
    }

    // MARK: - Slide 1: Welcome

    private var slide1: some View {
        VStack(spacing: MindAlertTheme.Spacing._24) {
            Spacer()
            MALogo(onAccent: true, size: 64)
            VStack(spacing: MindAlertTheme.Spacing._4) {
                Text("Welcome to")
                    .font(.maLargeTitle)
                    .foregroundColor(MindAlertTheme.staticWhite)
                MindAlertTitle(font: .maLargeTitle)
            }
            Spacer().frame(height: MindAlertTheme.Spacing._16)
            Text("This is a space for you to build your own safety plan, something that can help when things get really tough. ")
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.staticWhite.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, MindAlertTheme.Spacing._32)
            Spacer()
        }
    }

    // MARK: - Slide 2: Safety Plan

    private var slide2: some View {
        VStack(spacing: MindAlertTheme.Spacing._24) {
            Spacer()
            Text("Safety Plan")
                .font(.maLargeTitle)
                .foregroundColor(MindAlertTheme.staticWhite)
            Text("It's like a guide you create for yourself. It helps you get through tough moments — with your own words, your own reasons.")
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.staticWhite.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, MindAlertTheme.Spacing._32)
            Button("Learn more") {
                router.navigate(to: .aboutSafetyPlan)
            }
            .font(.maBoldBody)
            .foregroundColor(MindAlertTheme.mindGreen)
            Spacer()
        }
    }

    // MARK: - Slide 3: What's Included

    private var slide3: some View {
        VStack(spacing: MindAlertTheme.Spacing._24) {
            Spacer()
            Text("Your Safety Plan includs")
                .font(.maLargeTitle)
                .foregroundColor(MindAlertTheme.staticWhite)
            VStack(spacing: MindAlertTheme.Spacing._12) {
                includeCard(icon: "tray.full", text: "Coping Strategies")
                includeCard(icon: "person.2.fill", text: "Trust Contacts")
                includeCard(icon: "stethoscope", text: "Professional Contacts")
                includeCard(icon: "exclamationmark.triangle.fill", text: "Emergency Services")
            }
            .padding(.horizontal, MindAlertTheme.Spacing._24)
            Spacer()
        }
    }

    @ViewBuilder
    private func includeCard(icon: String, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(MindAlertTheme.mindGreen)
                .frame(width: 32)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.staticWhite)
            Spacer()
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.staticWhite.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._12))
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
