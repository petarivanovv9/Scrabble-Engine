#!/bin/sh

echo "===>>> Compiling Swift Module 'Scrabble_Engine'..."
swift build

echo "===>>> Running 'Scrabble_Engine'..."
./.build/debug/Scrabble-Engine
