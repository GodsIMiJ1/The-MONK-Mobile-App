# Setup Guide - The MONK Mobile

![GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com/logo.png)

This guide will help you set up The MONK Mobile development environment.

Developed by [GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com)

## Prerequisites

Before you begin, ensure you have the following installed:

- **Android Studio**: Arctic Fox (2021.3.1) or newer
- **JDK**: Version 11 or higher
- **Git**: For version control
- **PowerShell**: For running setup scripts (Windows)

## Initial Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd LivingJournalApp
```

### 2. Run the Setup Script (Windows)

The project includes a PowerShell setup script that initializes the project structure:

```powershell
.\setup.ps1
```

This script:
- Creates the necessary directory structure
- Sets up Gradle configuration files
- Creates placeholder files for the Android project
- Initializes a Git repository

### 3. Open the Project in Android Studio

- Launch Android Studio
- Select "Open an Existing Project"
- Navigate to the LivingJournalApp directory and click "OK"
- Wait for the Gradle sync to complete

## Supabase Configuration

### 1. Create a Supabase Project

1. Sign up or log in at [supabase.com](https://supabase.com)
2. Create a new project
3. Note your project URL and API key

### 2. Set Up Database Tables

Execute the following SQL in the Supabase SQL editor:

```sql
-- Create profiles table
create table public.profiles (
  id uuid references auth.users not null primary key,
  username text unique,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Set up Row Level Security (RLS)
alter table public.profiles enable row level security;
create policy "Users can view their own profile" on public.profiles
  for select using (auth.uid() = id);
create policy "Users can update their own profile" on public.profiles
  for update using (auth.uid() = id);

-- Create journal entries table
create table public.journal_entries (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles not null,
  title text not null,
  content text not null,
  mood text,
  tags text[],
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Set up Row Level Security (RLS)
alter table public.journal_entries enable row level security;
create policy "Users can CRUD their own entries" on public.journal_entries
  for all using (auth.uid() = user_id);
```

### 3. Configure Authentication

1. Go to the Authentication section in your Supabase dashboard
2. Enable Email authentication
3. Configure additional providers as needed

### 4. Add Supabase Credentials to the Project

Create a `secrets.properties` file in the project root (this file should be git-ignored):

```properties
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_KEY=your-supabase-anon-key
```

## Project Configuration

### 1. Configure Gradle Properties

Create or edit `gradle.properties` to include:

```properties
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
android.nonTransitiveRClass=true
```

### 2. Set Up Local Properties

Create a `local.properties` file with your Android SDK path:

```properties
sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
```

## Creating the Main Activity

Create a new Kotlin file at `app/src/main/java/com/example/livingjournal/MainActivity.kt`:

```kotlin
package com.example.livingjournal

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                Surface {
                    Text("Welcome to The MONK Mobile")
                }
            }
        }
    }
}

@Preview
@Composable
fun DefaultPreview() {
    MaterialTheme {
        Surface {
            Text("Welcome to The MONK Mobile")
        }
    }
}
```

## Running the App

1. Connect an Android device or start an emulator
2. Click the "Run" button in Android Studio
3. Select your device and click "OK"

## Troubleshooting

### Gradle Sync Issues

If you encounter Gradle sync issues:

1. Check that your Android SDK is properly installed
2. Ensure you have the correct JDK version
3. Try "File > Invalidate Caches / Restart"
4. Update Gradle plugin and wrapper versions if needed

### Supabase Connection Issues

If you have trouble connecting to Supabase:

1. Verify your API key and URL
2. Check your internet connection
3. Ensure your Supabase project is active
4. Check for any CORS issues

## Next Steps

After setting up the project:

1. Implement the data models and Room database
2. Set up the Supabase client
3. Create the UI screens with Jetpack Compose
4. Implement the ViewModels and repositories
5. Add authentication flow
6. Implement synchronization logic

Refer to the [Developer Guide](DEVELOPER_GUIDE.md) for more detailed information on the project architecture and implementation details.

## Support

If you encounter any issues during setup or have questions:

- **Website:** [www.godsimij-ai-solutions.com](https://www.godsimij-ai-solutions.com)
- **Email:** [james@godsimij-ai-solutions.com](mailto:james@godsimij-ai-solutions.com)

---

© 2023 GodsIMiJ AI Solutions. All rights reserved.
