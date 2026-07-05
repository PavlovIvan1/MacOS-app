# HelloWorldApp

Простое SwiftUI-приложение для macOS. Окно с текстом «Hello, World!» и кнопкой «Нажми меня», которая переключает текст на «Привет!».

Собирается полностью через Swift Package Manager — без Xcode-проекта.

## Требования

- macOS 12+
- Xcode Command Line Tools (Swift 5.9+)

## Установка и запуск

### Через Homebrew

```bash
brew tap PavlovIvan1/macos-app https://github.com/PavlovIvan1/MacOS-app.git
brew install macos-app
macos-app
```

Формула собирает бинарник из исходников прямо на вашей машине (`swift build`), поэтому Gatekeeper не блокирует запуск и нотаризация через Apple Developer Program не требуется.

### Из исходников

```bash
git clone git@github.com:PavlovIvan1/MacOS-app.git
cd MacOS-app
swift run
```

### Готовое `.app`-приложение

```bash
./build_app.sh
open HelloWorldApp.app
```

## Лицензия

MIT — см. [LICENSE](LICENSE).
