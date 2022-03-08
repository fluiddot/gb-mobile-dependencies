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

// "react-native-reanimated" provides the following Android projects:
// - android: Used to build the source code of the project and produce an AAR file.
// - android-npm: Used to integrate the library into an app. It reference the AAR file produced by the project "android" as the default artifact.
// 
// By default we only include the "android-npm" project. For building the source code, we should pass the argument '-PbuildSource=True' to Gradle.
val shouldBuildSource = startParameter.projectProperties.get("buildSource") == "True"

include(":react-native-reanimated")
if (shouldBuildSource) {
    project(":react-native-reanimated").projectDir = File(rootProject.projectDir, "react-native-reanimated/android")
}
else {
    project(":react-native-reanimated").projectDir = File(rootProject.projectDir, "react-native-reanimated/android-npm")
}
