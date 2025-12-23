#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <имя_проекта> <версия_python>"
    echo "Пример: $0 my_project 3.11"
    exit 1
fi

PROJECT_NAME=$1
PYTHON_VERSION=$2

echo "Начинаем создание проекта: $PROJECT_NAME с Python $PYTHON_VERSION"
echo "========================================"

if ! command -v python$PYTHON_VERSION &> /dev/null; then
    echo "ОШИБКА: Python $PYTHON_VERSION не найден в системе."
    echo "Установите его командой: sudo apt install python$PYTHON_VERSION"
    exit 1
fi

echo "✓ Python $PYTHON_VERSION доступен в системе."

echo "Создаю структуру папок..."

mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

mkdir -p src           
mkdir -p tests        
mkdir -p docs          
mkdir -p data          
mkdir -p notebooks     

echo "✓ Папки созданы: src/, tests/, docs/, data/, notebooks/"

echo "Создаю базовые файлы..."

cat > src/__init__.py << 'EOF'
"""
Модуль $PROJECT_NAME
"""
__version__ = '0.1.0'
EOF

cat > src/main.py << 'EOF'
"""
Основной модуль приложения
"""
import sys

def main():
    print(f"Проект {__package__} успешно запущен!")
    print(f"Версия Python: {sys.version}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
EOF

cat > requirements.txt << EOF

-e . 
EOF

cat > .gitignore << 'EOF'
venv/
.env
.env.local

__pycache__/
*.py[cod]
*$py.class

.ipynb_checkpoints/

.vscode/
.idea/

logs/
*.log
*.sqlite3

dist/
build/
*.egg-info/
EOF

cat > README.md << EOF

Краткое описание вашего проекта.

1. Клонируйте репозиторий
2. Создайте виртуальное окружение: python -m venv venv
3. Активируйте его: source venv/bin/activate
4. Установите зависимости: pip install -r requirements.txt

\`\`\`bash
python src/main.py
\`\`\`

\`\`\`
$PROJECT_NAME/
├── src/           
├── tests/         
├── docs/          
├── data/          | Данные
├── notebooks/     
├── requirements.txt
└── README.md
\`\`\`
EOF

echo "✓ Файлы созданы: src/main.py, requirements.txt, .gitignore, README.md"

# --- ПРОВЕРКА НАЛИЧИЯ МОДУЛЯ VENV ---
echo "Проверяю наличие модуля venv для python$PYTHON_VERSION..."
if ! python$PYTHON_VERSION -c "import venv" 2>/dev/null; then
    echo "❌ ОШИБКА: Модуль 'venv' для Python $PYTHON_VERSION не установлен."
    echo "Установите его командой:"
    echo "    sudo apt install python$PYTHON_VERSION-venv"
    echo ""
    echo "Или установите глобальный пакет virtualenv:"
    echo "    sudo apt install python3-virtualenv"
    exit 1
fi
echo "✓ Модуль venv доступен."

echo "Создаю виртуальное окружение с Python $PYTHON_VERSION..."

python$PYTHON_VERSION -m venv venv

if [ $? -eq 0 ]; then
    echo "✓ Виртуальное окружение создано в папке venv/"
else
    echo "ОШИБКА: Не удалось создать виртуальное окружение"
    echo "Проверьте, установлен ли python$PYTHON_VERSION-venv:"
    echo "sudo apt install python$PYTHON_VERSION-venv"
    exit 1
fi

echo "Настраиваю виртуальное окружение..."

source venv/bin/activate

pip install --upgrade pip

pip install wheel setuptools

echo "✓ Pip обновлен, базовые пакеты установлены"

deactivate

echo ""
echo "========================================"
echo "ПРОЕКТ УСПЕШНО СОЗДАН: $PROJECT_NAME"
echo "========================================"
echo ""
echo "ЧТОБЫ НАЧАТЬ РАБОТУ:"
echo "1. Перейдите в папку проекта: cd $PROJECT_NAME"
echo "2. Активируйте виртуальное окружение: source venv/bin/activate"
echo "3. Установите зависимости: pip install -r requirements.txt"
echo "4. Запустите проект: python src/main.py"
echo ""
echo "Структура проекта:"
tree -I 'venv|__pycache__' --dirsfirst 2>/dev/null || ls -la
echo ""
