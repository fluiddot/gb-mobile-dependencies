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
