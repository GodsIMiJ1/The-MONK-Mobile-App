# setup.ps1 - The MONK Mobile: AI Journal App Scaffold (Supabase + Compose + AI)

Write-Host "Initializing project structure for The MONK Mobile..."

# Root project name
$projectName = "LivingJournalApp"

# Core folders
$folders = @(
    "$projectName",
    "$projectName/app",
    "$projectName/app/src/main/java/com/example/livingjournal/ai",
    "$projectName/app/src/main/java/com/example/livingjournal/data",
    "$projectName/app/src/main/java/com/example/livingjournal/ui/screens",
    "$projectName/app/src/main/res/values",
    "$projectName/docs"
)

foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Host "Created: $folder"
    } else {
        Write-Host "Exists: $folder"
    }
}

# Root-level Gradle files
@"
rootProject.name = '$projectName'
include ':app'
"@ | Set-Content "$projectName/settings.gradle"

@"
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:8.1.3"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.21"
        classpath "com.google.gms:google-services:4.4.0"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
"@ | Set-Content "$projectName/build.gradle"

# App-level Gradle config
@"
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'kotlin-kapt'
}

android {
    namespace 'com.example.livingjournal'
    compileSdk 34

    defaultConfig {
        applicationId "com.example.livingjournal"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildFeatures {
        compose true
    }

    composeOptions {
        kotlinCompilerExtensionVersion '1.5.4'
    }
}

dependencies {
    implementation "androidx.core:core-ktx:1.12.0"
    implementation "androidx.lifecycle:lifecycle-runtime-ktx:2.7.0"
    implementation "androidx.activity:activity-compose:1.8.2"
    implementation "androidx.compose.ui:ui:1.6.1"
    implementation "androidx.compose.material:material:1.6.1"
    implementation "androidx.compose.ui:ui-tooling-preview:1.6.1"
    implementation "androidx.navigation:navigation-compose:2.7.7"
    implementation "androidx.lifecycle:lifecycle-viewmodel-compose:2.7.0"
    implementation "androidx.room:room-runtime:2.6.1"
    kapt "androidx.room:room-compiler:2.6.1"
    implementation "androidx.room:room-ktx:2.6.1"
    implementation "org.jetbrains.kotlinx:kotlinx-coroutines-android:1.8.0"

    // Supabase
    implementation "io.ktor:ktor-client-core:2.3.3"
    implementation "io.ktor:ktor-client-okhttp:2.3.3"
    implementation "io.ktor:ktor-client-serialization:2.3.3"
    implementation "org.jetbrains.kotlinx:kotlinx-serialization-json:1.5.1"

    // Retrofit (for OpenAI)
    implementation "com.squareup.retrofit2:retrofit:2.9.0"
    implementation "com.squareup.retrofit2:converter-gson:2.9.0"
}
"@ | Set-Content "$projectName/app/build.gradle"

# Default theme
@"
<resources xmlns:tools="http://schemas.android.com/tools">
    <style name="Theme.MonkMobile" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
        <item name="colorPrimary">@android:color/holo_blue_light</item>
        <item name="colorPrimaryVariant">@android:color/holo_blue_dark</item>
        <item name="colorOnPrimary">@android:color/white</item>
        <item name="colorSecondary">@android:color/holo_green_light</item>
        <item name="colorOnSecondary">@android:color/black</item>
        <item name="android:statusBarColor" tools:targetApi="l">@android:color/holo_blue_dark</item>
    </style>
</resources>
"@ | Set-Content "$projectName/app/src/main/res/values/themes.xml"

# AndroidManifest.xml
@"
<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\"
    package=\"com.example.livingjournal\">
    <application
        android:allowBackup=\"true\"
        android:icon=\"@mipmap/ic_launcher\"
        android:label=\"The MONK Mobile\"
        android:supportsRtl=\"true\"
        android:theme=\"@style/Theme.MonkMobile\">
        <activity android:name=\".MainActivity\">
            <intent-filter>
                <action android:name=\"android.intent.action.MAIN\" />
                <category android:name=\"android.intent.category.LAUNCHER\" />
            </intent-filter>
        </activity>
    </application>
</manifest>
"@ | Set-Content "$projectName/app/src/main/AndroidManifest.xml"

# Place markdown docs (if found in root)
$docFiles = @(
    "README.md",
    "CONTRIBUTING.md",
    "DEVELOPER_GUIDE.md",
    "SETUP_GUIDE.md",
    "USER_GUIDE.md"
)

foreach ($file in $docFiles) {
    if (Test-Path $file) {
        Copy-Item $file -Destination "$projectName/docs" -Force
        Write-Host "Copied $file → docs/"
    }
}

# Add .gitignore
@"
.gradle/
.idea/
build/
local.properties
*.iml
.DS_Store
secrets.properties
.env
"@ | Set-Content "$projectName/.gitignore"

# Git initialization
Set-Location "$projectName"
if (-not (Test-Path ".git")) {
    git init
    git add .
    git commit -m "Initial project scaffold for The MONK Mobile (Supabase + Compose + AI)"
    Write-Host "Git initialized and first commit created"
} else {
    Write-Host "Git repo already exists"
}

Write-Host "`nSetup complete!"
Write-Host "Open '$projectName' in Android Studio"
Write-Host "Run Gradle sync, connect Supabase & start building"
