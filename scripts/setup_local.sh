#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-/Users/drico/Mesa/Dev/clipbear}"
REPO_URL="${CLIPBEAR_REPO_URL:-https://github.com/MagnaSoluto/ClipBear.git}"
BRANCH="${CLIPBEAR_BRANCH:-cursor/flutterflow-restart-8bd1}"

echo "==> ClipBear — setup local"
echo "    Destino: $TARGET_DIR"
echo "    Branch:  $BRANCH"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Erro: Flutter não encontrado."
  echo "Instale em https://docs.flutter.dev/get-started/install/macos"
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Erro: git não encontrado."
  exit 1
fi

mkdir -p "$(dirname "$TARGET_DIR")"

if [ -d "$TARGET_DIR/.git" ]; then
  echo "==> Repositório já existe. Atualizando..."
  git -C "$TARGET_DIR" fetch origin
  git -C "$TARGET_DIR" checkout "$BRANCH" 2>/dev/null || git -C "$TARGET_DIR" checkout -b "$BRANCH" "origin/$BRANCH"
  git -C "$TARGET_DIR" pull origin "$BRANCH"
else
  echo "==> Clonando repositório..."
  git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"
flutter pub get
flutter doctor

echo ""
echo "==> Pronto. Para iniciar:"
echo "    cd \"$TARGET_DIR\""
echo "    flutter run -d chrome        # Web (mais rápido)"
echo "    flutter run -d macos         # App nativo macOS"
echo "    open -a Simulator && flutter run -d ios   # Simulador iOS"
