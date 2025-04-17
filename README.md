# The MONK Mobile

![GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com/logo.png)

A modern Android journaling application built with Jetpack Compose and Supabase integration. This app allows users to create, manage, and reflect on journal entries with AI-assisted features.

Developed by [GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com)

## Project Overview

The MONK Mobile is a mobile application designed to help users maintain a digital journal with smart features:

- **Modern UI**: Built with Jetpack Compose for a fluid and responsive interface
- **Local Storage**: Room database for offline access to journal entries
- **Cloud Sync**: Supabase backend integration for data synchronization across devices
- **AI Features**: Smart journaling assistance for reflection and insights

## Tech Stack

- **UI Framework**: Jetpack Compose
- **Architecture**: MVVM (Model-View-ViewModel)
- **Local Database**: Room
- **Backend**: Supabase
- **Networking**: Ktor
- **JSON Serialization**: Kotlinx Serialization
- **Concurrency**: Kotlin Coroutines
- **Navigation**: Jetpack Navigation Compose

## Project Structure

```
LivingJournalApp/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/livingjournal/
│   │   │   │   ├── ai/         # AI-related functionality
│   │   │   │   ├── data/       # Data models, repositories, and Room database
│   │   │   │   ├── ui/
│   │   │   │   │   └── screens/ # Compose UI screens
│   │   │   ├── res/            # Android resources
│   │   │   └── AndroidManifest.xml
│   └── build.gradle            # App-level dependencies
├── build.gradle                # Project-level build configuration
└── settings.gradle             # Project settings
```

## Getting Started

### Prerequisites

- Android Studio Arctic Fox (2021.3.1) or newer
- JDK 11 or higher
- Supabase account (for backend services)

### Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Open the project in Android Studio

3. Sync Gradle files

4. Configure Supabase:
   - Create a Supabase project
   - Set up authentication and database tables
   - Add your Supabase URL and API key to the project

5. Run the app on an emulator or physical device

## Supabase Integration

This project uses Supabase for backend services. To set up Supabase:

1. Create a new project at [supabase.com](https://supabase.com)
2. Set up the following tables:
   - `journals` - For storing journal entries
   - `users` - For user profiles
3. Configure authentication methods (email, social logins)
4. Create a `.env` file or secure storage for your Supabase credentials

## AI Features

The app includes AI-assisted journaling features:

- Smart prompts for reflection
- Sentiment analysis of entries
- Pattern recognition across journal entries
- Personalized insights based on journaling history

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Contact

For questions, support, or business inquiries:

- **Website:** [www.godsimij-ai-solutions.com](https://www.godsimij-ai-solutions.com)
- **Email:** [james@godsimij-ai-solutions.com](mailto:james@godsimij-ai-solutions.com)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

© 2023 GodsIMiJ AI Solutions. All rights reserved.
