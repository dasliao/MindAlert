# MindAlert: Play Export Design Implementation Plan

## Overview
Implement the detailed Play export design from `MindAlert Release/` into the current MindAlert app.
The Play export uses PlaySDK (not usable directly) — we extract design intent (colors, typography, spacing, layout) and re-implement in pure SwiftUI.

**Rule: Keep current TabView/tab bar implementation (Phase 10 skipped per user instruction).**

---

## Screen-by-Screen Comparison

### Phase 1: Design System (Colors, Typography, Spacing)

**Play Export (Foundations/):**
- **Colors**: 18 tokens with light/dark support
  - green: `rgb(0.459, 0.604, 0.420)` / dark: `rgb(0.522, 0.690, 0.471)`
  - lightGreen: `rgb(0.714, 0.8, 0.561)`
  - whiteGreen: `rgb(0.955, 0.966, 0.938)`
  - peach: `rgb(0.949, 0.702, 0.6)`
  - darkPeach: `rgb(0.820, 0.549, 0.433)`
  - lightPeach: `rgb(0.937, 0.847, 0.808)`
  - whitePeach: `rgb(1.0, 0.976, 0.965)`
  - textPrimary: `rgb(0.2, 0.2, 0.2)` / dark: `rgb(0.961, 0.961, 0.961)`
  - textSecondary: `rgb(0.4, 0.4, 0.4)`
  - textTertiary: `rgb(0.702, 0.702, 0.702)`
  - lightGray: `rgb(0.961, 0.961, 0.961)`
  - buttonDisable: `rgb(0.867, 0.867, 0.867)`
  - backgroundPrimary: white 30% opacity / dark: black 30%
  - borderSeparator: `rgb(0.914, 0.914, 0.914)`
  - staticWhite, staticBlack (non-adaptive)
- **Gradients**: green (lightGreen -> green, 45deg), peach (peach -> lightPeach, 45deg)
- **Typography**: 9 styles
  - largeTitle: 32pt, System Rounded, semibold (weight 0.3)
  - safetyPlanTitle: 34pt, System Rounded, semibold
  - splashBody: 28pt, System Default, semibold, lineHeight 32
  - pageHeaderSmall: 22pt, System Default, semibold
  - headline: 19pt, System Default, semibold
  - safetyPlanBody: 19pt, System Rounded, medium (weight 0.23), lineHeight 24
  - boldbody: 17pt, System Default, medium, lineHeight 24
  - caption: 15pt, System Default, regular
  - tabCaption: 12pt, System Default, medium
- **Spacing**: 0, 1, 2, 4, 8, 12, 16, 24, 32, 48, 64, 128
- **Radius**: 0, 4, 8, 12, 16, 24, 32, 40, 48, 56, 64

**Current App (MindAlertTheme.swift):**
- Only 7 color references (from xcassets), no light/dark adaptive code
- No typography system — ad-hoc font sizes everywhere
- No spacing/radius tokens
- background hardcoded as `Color(red: 0.96, green: 0.96, blue: 0.96)`

**Changes needed:**
- [ ] Expand MindAlertTheme with all 18 color tokens (adaptive light/dark)
- [ ] Add gradient definitions (green, peach)
- [ ] Add typography presets as ViewModifiers or Font extensions
- [ ] Add spacing and radius constants
- [ ] Add text color tokens (textPrimary, textSecondary, textTertiary)

---

### Phase 2: Splash Screen + Initial/Welcome Page

**Play Export:**
- `page_SplashScreen`: MindAlert branding with introductory text, splashBody (28pt) typography
- `page_InitialPage`: "Welcome to MindAlert!" with logo, heart icon, "What should we call you?" prompt

**Current App:**
- `LoadingView.swift`: Simple loading with logo
- `NameView.swift`: Combined welcome + name input on one screen

**Changes needed:**
- [ ] Update LoadingView to match SplashScreen design (branding text, proper typography)
- [ ] Update NameView to match InitialPage design (logo component, proper layout)

---

### Phase 3: Welcome + Info/Disclaimer

**Play Export:**
- `page_Name`: Name input with proper styling, person icon
- Welcome page (after name): "Hello, [Name]!" greeting, safety plan features list, panic button explanation

**Current App:**
- `WelcomePageView.swift`: Has greeting, features list, panic button info — close to design
- `InfoAndDisclaimer.swift`: Disclaimer page

**Changes needed:**
- [ ] Update WelcomePageView typography to match Play design tokens
- [ ] Update InfoAndDisclaimer to match page_InfoDisclaimer layout (term agreement, conditions link)

---

### Phase 4: Coping Strategies Flow

**Play Export:**
- `page_CopingStrategiesIntro`: "Do you already have strategies that help you stay grounded in a crisis?" with emoji indicators, Yes/No buttons
- `page_CopingStrategiesInput`: Strategy input with StrategyInputBox components, numbered strategy cards

**Current App:**
- `CopingStrategies.swift`: Has question + Yes/No
- `CopingStrategiesYes.swift`: Has strategy input
- `CopingStrategiesNo_1.swift`: Has encouragement text

**Changes needed:**
- [ ] Update CopingStrategies to match CopingStrategiesIntro (emoji row, proper typography)
- [ ] Update CopingStrategiesYes to use StrategyInputBox-style cards with numbering
- [ ] Update CopingStrategiesNo_1 to match Play design

---

### Phase 5: Emergency Contacts (People That Help)

**Play Export:**
- `page_PeopleThatHelp`: Contact cards with firstName, lastName, phoneNumber, profile image support
- Uses ContactCard component with green accent

**Current App:**
- `EmergencyContacts.swift`: System contact picker, contact list

**Changes needed:**
- [ ] Update EmergencyContacts to match PeopleThatHelp design
- [ ] Implement ContactCard-style display for added contacts
- [ ] Keep system CNContactPickerViewController (no entitlements needed)

---

### Phase 6: Emergency Services

**Play Export:**
- `page_EmergencyServices`: Emergency service selection with EmergencyServiceActions component (911, 988 states)

**Current App:**
- `EmergencyServicesView.swift`: Service selection buttons

**Changes needed:**
- [ ] Update EmergencyServicesView to match Play design
- [ ] Style service options to match EmergencyServiceActions component

---

### Phase 7: Setup Confirmation (Complete View)

**Play Export:**
- `page_SetupConfirmation`: Setup finished confirmation with image, setupFinished variable
- `page_AboutSafetyPlan`: Information about safety plan features

**Current App:**
- `CompleteView.swift`: Completion screen

**Changes needed:**
- [ ] Update CompleteView to match SetupConfirmation design
- [ ] Add panic button explanation to complete view

---

### Phase 8: Home Screen + Panic Button

**Play Export:**
- `page_Home`: Greeting "Hello, [Name]!", countdown instruction, countdown display (3-2-1)
- Uses green circle expanding animation with countdown numbers

**Current App:**
- `HomeView.swift`: Has greeting + PanicButton + instruction text
- `PanicButton.swift`: Has expanding circle + countdown (3-2-1) — already matches design intent

**Changes needed:**
- [ ] Update HomeView typography to match Play tokens (greeting size, instruction text)
- [ ] Fix background to be truly full-screen (no padding/white on sides)
- [ ] Fix PanicButton timer data race warning (line 76)
- [ ] Ensure countdown numbers use proper typography (large, bold, white)

---

### Phase 9: Plan Activated View

**Play Export:**
- `page_PlanActivated`: Multi-section view showing:
  - Greeting + "Safety Plan is activated"
  - "We have sent text messages to" + contact avatars
  - "Help is on the way"
  - "Let's focus on Coping Strategies" + strategy pills
  - Countdown section (3, 2, 1 steps)

**Current App:**
- `SafetyPlanActivatedView.swift`: Already has multi-section layout, close to design

**Changes needed:**
- [ ] Update typography and spacing to match Play design tokens
- [ ] Match card styling (corner radius, padding) to Play design
- [ ] Add countdown step sections if not present

---

### Phase 10: Tab Bar — SKIPPED
Keep current TabView implementation.

---

### Phase 11: Profile/Settings

**Play Export:**
- `page_ProfileSetting`: Profile settings with user data display
  - userName, userEmail
  - Coping strategies as StrategySettingCard components
  - Contact cards
  - Emergency service items

**Current App:**
- `ProfileView.swift`: Has sections for Name, Strategies, Contacts, Emergency, Debug (rerun onboarding)

**Changes needed:**
- [ ] Update ProfileView to match Play design
- [ ] Use StrategySettingCard-style for strategies (numbered cards)
- [ ] Use ContactCard-style for contacts
- [ ] Keep rerun onboarding debug option
- [ ] Match typography and spacing to Play tokens

---

### Phase 12: New Pages (if needed)

**Play Export has pages not in current app:**
- `page_PrivacyPolicy`
- `page_TermsCondition`
- `page_ProfessionalSupport`
- `page_AboutSafetyPlan`

**Decision:** Add these as accessible from Profile/Settings if content is available from Play export.

---

## Additional Bug Fixes

1. **PanicButton.swift:76** — "Sending 'timer' risks causing data races" — fix Timer usage with proper MainActor isolation
2. **Contact Notes entitlement** — Not needed; we use system CNContactPickerViewController
3. **Home gray background not full page** — Fix padding/white edges
4. **Onboarding buttons with liquid glass layer** — Use native iOS 26 glass buttons or plain styled buttons

---

## Implementation Order

1. Phase 1: Design System tokens
2. Phase 2: Splash + Initial page
3. Phase 3: Welcome + Info/Disclaimer
4. Phase 4: Coping Strategies flow
5. Phase 5: Emergency Contacts
6. Phase 6: Emergency Services
7. Phase 7: Setup Confirmation
8. Phase 8: Home + Panic Button + bug fixes
9. Phase 9: Plan Activated
10. Phase 11: Profile/Settings
11. Phase 12: New pages
12. Debug pass across all screens
