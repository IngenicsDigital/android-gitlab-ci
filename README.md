# Gitlab CI build environment for Android

Build environment for building android apps with Gitlab CI.

## Usage

Add following gitlab ci configuration to your android project.

```yaml
.gitlab-ci.yml
--------------
image: pixelgroup/android-gitlab-ci:latest

before_script:
  - export GRADLE_USER_HOME=$(pwd)/.gradle
  - chmod +x ./gradlew

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - .gradle/

stages:
  - build
  - test

unitTests:
  stage: test
  script:
    - ./gradlew test

instrumentedTests:
  stage: test
  script:
    - prepareAndroidEmulator.sh
    - adb shell input keyevent 82
    - ./gradlew connectedCheck
```