# MindAlert Figma Design Implementation Plan

## Figma Source
- File: `tPSP6iSPun2dojJcZkd3TR`
- Page: `165:3567` (Release Version)

## Phase 1 - Progress Indicator, Tab Name, Home Greeting (Small)
- **Progress Indicator**: Redesign from 4-step capsule dots to 3-step numbered circles (1, 2, 3) connected by lines with green fill. Steps: 1=Info/Coping, 2=Contacts, 3=Emergency Services
  - Figma frames: `603:1903` (Assets)
  - File: `OnboardingProgressIndicator.swift`
  - Also update all onboarding views from 4 steps to 3 steps
- **Tab name**: Rename "Home" to "Safety Plan" in HomeTabView
  - File: `HomeTabView.swift`
- **Home greeting**: Change to "Hello, Kim!" format (with comma and exclamation)
  - Figma frame: `165:3921` (Home screen)
  - File: `HomeView.swift`

## Phase 2 - NameView, InfoAndDisclaimer, Button Styling (Medium)
- **NameView**: Remove `.mindAlertCard()` wrapper, content directly on background. Full-width button.
  - Figma frames: `603:1821` (empty), `603:1856` (filled)
  - File: `NameView.swift`
- **InfoAndDisclaimer**: Each disclaimer in its own white rounded card with large light-weight number (1, 2, 3). Button says "I understand" not "Next". No progress indicator on this screen (it's before the 3-step flow). Remove the card wrapper around all disclaimers.
  - Figma frame: `165:3652`
  - File: `InfoAndDisclaimer.swift`
- **"No, I need help" button**: Change from filled PeachButton to outlined/bordered style
  - Figma frame: `165:3691`
  - File: `CopingStrategies.swift`, possibly new button style

## Phase 3 - Combine Welcome Screens (Medium)
- Merge 3 WelcomePageView screens (.hello, .safetyPlanOverview, .panicButton) into 1 scrollable page
- Figma frame `165:3574`: Shows "Hello, Kim!" header, description text, card with "Your Safety Plan will include:" features, then "After creating your Safety Plan, a Panic Button will become available." text, Next button
- Files: `WelcomePageView.swift` (rewrite), `OnboardingFlowView.swift` (remove welcome2/welcome3 steps)

## Phase 4 - Strategy List Card Redesign (Medium)
- Each strategy in its own white rounded card with "Strategy N" label and peach underline text field
- "+ Add Strategies" is a peach-outlined pill button
- "Confirm" button gray when empty, green when filled
- Figma frames: `165:3708` (empty), `624:1986` (filling), `624:2028` (filled)
- File: `CopingStrategiesYes.swift`

## Phase 5 - Emergency Services Card-based Radio (Small)
- Options inside a single white card with green checkmark circles
- Not filled peach backgrounds for selection
- Figma frames: `624:2781` (911 selected), `624:2869` (alternative selected)
- File: `EmergencyServicesView.swift`

## Phase 6 - Complete View with Panic Button Explanation (Medium)
- Checkmark + "You did it, Kim!" centered
- Card showing: "A Panic Button is now available for you." + nested card with logo icon + "It looks like this." + instructions
- Below card: "After the plan is activated, we will message your emergency contacts and notify your emergency services."
- Done button
- Figma frame: `165:3912`
- File: `CompleteView.swift`

## Phase 7 - Emergency Contacts Phone Picker (Large)
- Contact list picker from phone's address book using CNContactStore
- Rows with avatar, name, phone number, selectable checkmark circles
- "Add Contact" pill button
- Contact avatars shown as circles with initials
- Message Template card with "Edit Message" button
- Figma frames: `165:3770` (empty), `624:2723` (with contacts), `624:2336` (picker unselected), `634:1932` (picker selected)
- File: `EmergencyContacts.swift` (major rewrite)

## Phase 8 - Panic Button Countdown Animation (Large)
- When held, green circle EXPANDS while showing countdown 3 → 2 → 1
- Circle grows from normal size to filling the screen
- Uses MindAlert logo icon (heart+cross) inside green circle instead of Image("TheButtonLarge")
- Figma frames: `165:3921` (idle), `165:3941` (3), `165:3955` (2), `165:3969` (1)
- File: `PanicButton.swift` (major rewrite)

## Phase 9 - Safety Plan Activated Multi-section Redesign (Large)
- Scrollable view with distinct card sections:
  1. Checkmark + "Hi Kim, your Safety Plan is activated"
  2. "We have sent text messages to" + contact avatar circles with names
  3. "And help is on the way..." + ambulance icon
  4. "Now Let's focus on your Coping Strategies." + tray icon
  5. "Let's try these activities:" + peach pill buttons for each strategy (with arrow for URLs)
- Figma frames: `638:4233` (initial card), `165:3982` (full scrollable)
- File: `SafetyPlanActivatedView.swift` (major rewrite)

## Phase 10 - SKIPPED (keep current tab bar implementation)
