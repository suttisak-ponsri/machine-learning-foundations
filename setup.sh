#!/bin/bash
# ============================================
# Machine Learning Foundations - Setup Script
# ============================================

set -e

VENV_DIR=".venv"
PYTHON_CMD=""

echo "🚀 Machine Learning Foundations - Setup"
echo "========================================"

# --- Find Python 3 ---
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "❌ Python not found. Please install Python 3.9+ first."
    exit 1
fi

PYTHON_VERSION=$($PYTHON_CMD --version 2>&1)
echo "✅ Found: $PYTHON_VERSION"

# --- Create virtual environment ---
if [ -d "$VENV_DIR" ]; then
    echo "⚠️  Virtual environment '$VENV_DIR' already exists. Skipping creation."
else
    echo "📦 Creating virtual environment in '$VENV_DIR'..."
    $PYTHON_CMD -m venv "$VENV_DIR"
    echo "✅ Virtual environment created."
fi

# --- Activate virtual environment ---
echo "🔗 Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# --- Upgrade pip ---
echo "⬆️  Upgrading pip..."
pip install --upgrade pip --quiet

# --- Install dependencies ---
echo "📥 Installing dependencies from requirements.txt..."
pip install -r requirements.txt --quiet
echo "✅ All dependencies installed."

# --- Register Jupyter kernel ---
echo "🔧 Registering Jupyter kernel 'ml-foundations'..."
python -m ipykernel install --user --name=ml-foundations --display-name="ML Foundations (.venv)"
echo "✅ Jupyter kernel registered."

# --- Done ---
echo ""
echo "========================================"
echo "✅ Setup complete!"
echo ""
echo "To activate the environment manually:"
echo "  source $VENV_DIR/bin/activate"
echo ""
echo "To start Jupyter Notebook:"
echo "  jupyter notebook"
echo ""
echo "To select the kernel in VS Code:"
echo "  Open a .ipynb file → Select Kernel → 'ML Foundations (.venv)'"
echo "========================================"
