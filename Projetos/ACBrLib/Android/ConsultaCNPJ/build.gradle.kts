// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    alias(libs.plugins.android.library) apply false
}


extra["ACBrFolder"] = System.getenv("ACBR_HOME")
extra["ACBrLibComumJar"] = "../../Comum/libs/jars/ACBrLibComum.jar"
extra["ACBrProjectName"] = "ConsultaCNPJ"
extra["ACBrDependenciesFolder"] = "${extra["ACBrFolder"]}/DLLs/Android"
extra["ACBrLibFolder"] = "${extra["ACBrFolder"]}/Projetos/ACBrLib"
extra["jniLibsFolder"] = "${rootProject.projectDir}/ACBrLibConsultaCNPJ/src/main/jniLibs"
extra["jniLibsFolder_arm64"] = "${extra["jniLibsFolder"]}/arm64-v8a"
extra["jniLibsFolder_armeabi"] = "${extra["jniLibsFolder"]}/armeabi-v7a"