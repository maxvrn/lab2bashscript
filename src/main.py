#!/usr/bin/env python3

import sys
import platform
import time
from datetime import datetime

def show_info():
    
    print("=" * 50)
    print(" ПРИЛОЖЕНИЕ: GitHub Actions Builder")
    print("=" * 50)
    
    print(f" Дата и время: {datetime.now().strftime('%d.%m.%Y %H:%M:%S')}")
    print(f" Версия Python: {platform.python_version()}")
    print(f" ОС: {platform.system()} {platform.release()}")
    print(f" Процессор: {platform.processor() or 'Неизвестно'}")
    
    if len(sys.argv) > 1:
        print(f"\n Получено аргументов: {len(sys.argv) - 1}")
        for i, arg in enumerate(sys.argv[1:], 1):
            print(f"    {i}. '{arg}'")
    
    print("\n Приложение успешно запущено!")
    print("=" * 50)

def main():
  
    show_info()
    
    if "--help" in sys.argv or "-h" in sys.argv:
        print("\n СПРАВКА:")
        print("  Использование: ./myapp [опции]")
        print("  Опции:")
        print("    --help, -h     Показать эту справку")
        print("    --time         Показать время работы")
        print("    --version      Показать версию")
        return 0
    
    if "--time" in sys.argv:
        print(f"\n  Время запуска: {time.strftime('%H:%M:%S')}")
    
    if "--version" in sys.argv or "-v" in sys.argv:
        print("\n ВЕРСИЯ: 1.0.0")
        print("   Собрано с помощью GitHub Actions")
        print("   Исполняемый файл для Linux")
    
    return 0

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n Программа остановлена")
        sys.exit(0)
    except Exception as e:
        print(f"\n Ошибка: {e}", file=sys.stderr)
        sys.exit(1)
