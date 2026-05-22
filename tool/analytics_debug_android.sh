#!/usr/bin/env bash
# Activa DebugView en Firebase para esta app Android (solo mientras el dispositivo está conectado).
set -euo pipefail
PACKAGE=com.example.holamundo_firebase
adb shell setprop debug.firebase.analytics.app "$PACKAGE"
echo "DebugView activado para $PACKAGE"
echo "Abre Firebase Console → proyecto holamundo-f3029 → Analytics → DebugView"
echo "Ejecuta la app, navega y pulsa el botón de evento; luego pulsa Home en el teléfono."
