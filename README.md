# Gitlab CI build environment for Android

Build environment for building android apps with Gitlab CI.

## Usage

Add following gitlab ci configuration to your android project.

```yaml
.gitlab-ci.yml
--------------
# use registry.gitlab.com/pixelsoftware/android-gitlab-ci:28 if you have no instrumented unit tests
image: registry.gitlab.com/pixelsoftware/android-gitlab-ci:28-emulator

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

## Build docker images

* without emulator ~1.02 GB
    * `docker build -f Dockerfile -t registry.gitlab.com/pixelsoftware/android-gitlab-ci:28 .`
* with emulator ~1.38 GB
    * `docker build -f DockerfileEmulator -t registry.gitlab.com/pixelsoftware/android-gitlab-ci:28-emulator .`
        
## Upload docker images to registry

* see instructions https://gitlab.com/pixelsoftware/android-gitlab-ci/container_registry
