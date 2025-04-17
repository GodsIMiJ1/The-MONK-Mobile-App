# Developer Guide - The MONK Mobile

![GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com/logo.png)

This guide provides detailed information for developers working on The MONK Mobile project.

Developed by [GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com)

## Architecture Overview

The MONK Mobile follows the MVVM (Model-View-ViewModel) architecture pattern with a clean architecture approach:

```
UI Layer (Compose) → ViewModel → Repository → Data Sources (Room DB, Supabase API)
```

### Key Components

1. **UI Layer**
   - Jetpack Compose screens and components
   - Navigation handled by Navigation Compose
   - UI state management through StateFlow

2. **ViewModel Layer**
   - Manages UI state and business logic
   - Communicates with repositories
   - Exposes StateFlow for UI consumption

3. **Repository Layer**
   - Abstracts data sources
   - Handles data operations and transformations
   - Manages synchronization between local and remote data

4. **Data Layer**
   - Room Database for local storage
   - Supabase API client for remote operations
   - Data models and DTOs

## Package Structure

- `com.example.livingjournal.ai`: AI-related functionality
- `com.example.livingjournal.data`: Data handling
  - `model`: Data models and entities
  - `repository`: Repository implementations
  - `local`: Room database and DAOs
  - `remote`: Supabase API client and DTOs
- `com.example.livingjournal.ui`: UI components
  - `screens`: Compose screens
  - `components`: Reusable Compose components
  - `theme`: App theming
  - `viewmodel`: ViewModels for screens

## Setting Up Supabase

### Database Schema

Create the following tables in your Supabase project:

#### Users Table
```sql
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
```

#### Journal Entries Table
```sql
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

### Authentication Setup

1. Configure email authentication in the Supabase dashboard
2. Set up OAuth providers if needed (Google, Facebook, etc.)
3. Configure password recovery flow

## Room Database

The app uses Room for local storage of journal entries. Key components:

### Entities

```kotlin
@Entity(tableName = "journal_entries")
data class JournalEntryEntity(
    @PrimaryKey val id: String,
    val userId: String,
    val title: String,
    val content: String,
    val mood: String?,
    val tags: List<String>,
    val createdAt: Long,
    val updatedAt: Long,
    val isSynced: Boolean = false
)
```

### DAOs

```kotlin
@Dao
interface JournalEntryDao {
    @Query("SELECT * FROM journal_entries ORDER BY createdAt DESC")
    fun getAllEntries(): Flow<List<JournalEntryEntity>>

    @Query("SELECT * FROM journal_entries WHERE id = :id")
    suspend fun getEntryById(id: String): JournalEntryEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertEntry(entry: JournalEntryEntity)

    @Update
    suspend fun updateEntry(entry: JournalEntryEntity)

    @Delete
    suspend fun deleteEntry(entry: JournalEntryEntity)

    @Query("SELECT * FROM journal_entries WHERE isSynced = 0")
    suspend fun getUnsyncedEntries(): List<JournalEntryEntity>
}
```

## Supabase Integration

The app uses Ktor client to interact with Supabase:

```kotlin
class SupabaseClient(
    private val supabaseUrl: String,
    private val supabaseKey: String
) {
    private val client = HttpClient(OkHttp) {
        install(JsonFeature) {
            serializer = KotlinxSerializer(Json {
                ignoreUnknownKeys = true
                coerceInputValues = true
            })
        }
        defaultRequest {
            header("apikey", supabaseKey)
            contentType(ContentType.Application.Json)
        }
    }

    suspend fun getJournalEntries(): List<JournalEntryDto> {
        return client.get("$supabaseUrl/rest/v1/journal_entries?select=*") {
            header("Authorization", "Bearer $supabaseKey")
        }
    }

    // Additional API methods...
}
```

## AI Integration

The AI features are implemented in the `ai` package:

- `JournalAnalyzer`: Analyzes journal entries for patterns and insights
- `PromptGenerator`: Generates writing prompts based on user history
- `SentimentAnalyzer`: Analyzes the sentiment of journal entries

## Testing Strategy

### Unit Tests

- ViewModel tests using JUnit and Turbine for Flow testing
- Repository tests with MockK for mocking dependencies
- Room DAO tests using Room's in-memory database

### UI Tests

- Compose UI tests using ComposeTestRule
- Navigation tests
- End-to-end tests with Espresso

## Synchronization Strategy

The app implements a background synchronization strategy:

1. Local-first approach: All changes are saved to Room first
2. Background sync using WorkManager
3. Conflict resolution with last-write-wins strategy
4. Offline support with queued operations

## Performance Considerations

- Use of Paging 3 for large datasets
- Efficient image loading with Coil
- Background processing with WorkManager
- Memory management best practices

## Security

- Secure storage of Supabase credentials
- Encryption of sensitive local data
- Proper authentication flow
- Input validation and sanitization

## Accessibility

- Support for TalkBack
- Proper content descriptions
- Sufficient color contrast
- Support for different font sizes

## Localization

The app supports multiple languages through Android's localization system:

- String resources in `res/values/strings.xml`
- Language-specific resources in `res/values-{locale}/strings.xml`

## Contact

For technical questions or development support:

- **Website:** [www.godsimij-ai-solutions.com](https://www.godsimij-ai-solutions.com)
- **Email:** [james@godsimij-ai-solutions.com](mailto:james@godsimij-ai-solutions.com)

---

© 2023 GodsIMiJ AI Solutions. All rights reserved.
