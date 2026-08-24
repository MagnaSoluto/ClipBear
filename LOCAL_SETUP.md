# Setup Local — macOS

## Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install/macos) (stable)
- [Xcode](https://developer.apple.com/xcode/) (para iOS Simulator)
- Git

Verifique:

```bash
flutter doctor
```

## Opção 1: Script automático

```bash
bash scripts/setup_local.sh /Users/drico/Mesa/Dev/clipbear
```

## Opção 2: Manual

```bash
mkdir -p /Users/drico/Mesa/Dev
cd /Users/drico/Mesa/Dev

git clone https://github.com/MagnaSoluto/ClipBear.git clipbear
cd clipbear
git checkout cursor/flutterflow-restart-8bd1

flutter pub get
```

## Iniciar o app

### Web (recomendado para teste rápido)

```bash
cd /Users/drico/Mesa/Dev/clipbear
flutter run -d chrome
```

### iOS Simulator

```bash
open -a Simulator
flutter run -d ios
```

### macOS nativo

```bash
flutter run -d macos
```

## O que você verá

Tela placeholder com o urso 🐻 e mensagem de que o projeto aguarda export do FlutterFlow. Isso é esperado — a UI completa será construída no FlutterFlow conforme as specs em `specs/`.

## Problemas comuns

| Problema | Solução |
|----------|---------|
| `flutter: command not found` | Adicione Flutter ao PATH no `~/.zshrc` |
| CocoaPods (iOS) | `cd ios && pod install && cd ..` |
| Licença Xcode | `sudo xcodebuild -license accept` |
| Nenhum device | `flutter devices` para listar opções |
