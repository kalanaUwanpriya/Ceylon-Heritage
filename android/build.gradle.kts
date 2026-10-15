allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}
subprojects {
    val configureCompileSdk: (Project) -> Unit = { proj ->
        val android = proj.extensions.findByName("android")
        if (android != null) {
            val method = android.javaClass.methods.firstOrNull {
                (it.name == "setCompileSdkVersion" || it.name == "setCompileSdk" || it.name == "compileSdkVersion")
                    && it.parameterTypes.size == 1
                    && (it.parameterTypes[0] == Int::class.javaPrimitiveType || it.parameterTypes[0] == java.lang.Integer::class.java)
            }
            method?.invoke(android, 36)
        }
    }

    if (state.executed) {
        configureCompileSdk(this)
    } else {
        afterEvaluate {
            configureCompileSdk(this)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
