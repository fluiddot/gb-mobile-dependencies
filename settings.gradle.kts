pluginManagement {
    val androidGradlePluginVersion: String by settings
    plugins {
        id("com.android.library") version androidGradlePluginVersion
    }
    repositories {
        gradlePluginPortal()
        google()
    }
}

include(":react-native-gesture-handler")
project(":react-native-gesture-handler").projectDir = File(rootProject.projectDir, "react-native-gesture-handler/android")
