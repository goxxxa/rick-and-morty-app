
# Rick and Morty App

Приложение на Flutter для просмотра персонажей вселенной "Rick and Morty".
Поддерживает локальное кеширование данных, добавление в избранное и офлайн-режим.


## Функционал

- Загрузка списка персонажей с API
- Локальное хранение с помощью SQLite (drift)
- Добавление и удаление из избранного
- Сортировка и фильтрация избранных
- Поддержка темной/светлой темы
- Реактивное обновление UI через потоки (Stream + BLoC)

## Архитектура и Clean Architecture

Проект построен по принципам **Clean Architecture** с использованием **BLoC**.

### Data Layer
Работа с API и локальной базой (Drift/SQLite).  
Репозитории объединяют источники данных и предоставляют единый интерфейс.  

**Примеры файлов:**  
- `local_storage_character_api.dart`  
- `api_client.dart`  
- `characters_repository.dart`  

### Domain Layer
Сущности и бизнес-правила.  

**Сущности:** `Character`, `Origin`, `Location`  
**Use-cases:** `getCharacters`, `loadMore`, `setFavorite`, `unsetFavorite`  

### Presentation Layer
UI и управление состоянием через **BLoC/Cubit**.

**Примеры папок:**  
- `features/characters/view` — список персонажей  
- `features/favorites/view` — избранное  
- `home/view` — навигация  

### Преимущества
- **Сепарация ответственности** и лёгкое тестирование  
- **Расширяемость** и поддержка новых функций  
- **Реактивное обновление UI** через `Stream`  

### Пример потока данных
`BLoC` → репозиторий → проверка локальной базы → загрузка с API при необходимости → сохранение в локальную базу → обновление стрима → **UI автоматически обновляется**


## Сборка и запуск

### Клонирование репозитория

Сначала клонируйте репозиторий на локальную машину:

```bash
git clone https://github.com/goxxxa/rick-and-morty-app.git
cd rick-and-morty-app
```

### Требования
- **Flutter:** 3.24.0 или выше  
- **Dart:** 3.4.0 или выше

## Вариант 1:
### Установка зависимостей

```bash
flutter pub get
```

### Кодогенерация
```
dart run build_runner build --delete-conflicting-outputs
```
## Вариант 2: запуск через Makefile

Если установлен **`make`**, можно использовать удобные команды для сборки, генерации и форматирования проекта.

### Доступные команды

| Команда | Описание |
|----------|-----------|
| **`make get`** | Устанавливает зависимости (`flutter pub get`) |
| **`make codegen`** | Генерирует код (Freezed, Drift, JSON и др.) |
| **`make gen`** | Синоним команды `make codegen` |
| **`make fix`** | Форматирует код и исправляет замечания (`dart fix`) |
| **`make build-apk`** | Собирает APK-profile версию проекта |
| **`make upgrade-packages`** | Обновляет все зависимости до последних версий |
| **`make precommit`** | Форматирует код перед коммитом |

---

### Пример использования

```bash
# Установка зависимостей и генерация кода
make codegen
```
### Запуск приложения после генерации
```
flutter run
```

## Структура проекта

```
├── lib/
│   ├── bootstrap.dart
│   ├── main.dart
│   ├── api/
│   │   ├── local_api/
│   │   │   ├── character_api.dart
│   │   │   └── local_storage_character_api.dart
│   │   └── remote_api/
│   │       └── api_client.dart
│   ├── app/
│   │   ├── app.dart
│   │   └── app_bloc_observer.dart
│   ├── core/
│   │   └── database/
│   │       └── database.dart
│   ├── features/
│   │   ├── characters/
│   │   │   ├── characters.dart
│   │   │   ├── bloc/
│   │   │   │   ├── characters_bloc.dart
│   │   │   │   ├── characters_event.dart
│   │   │   │   └── characters_state.dart
│   │   │   └── view/
│   │   │       ├── characters_page.dart
│   │   │       └── view.dart
│   │   ├── favorites/
│   │   │   ├── favorites.dart
│   │   │   ├── bloc/
│   │   │   │   ├── favorites_bloc.dart
│   │   │   │   ├── favorites_event.dart
│   │   │   │   └── favorites_state.dart
│   │   │   ├── view/
│   │   │   │   ├── favorites_page.dart
│   │   │   │   └── view.dart
│   │   │   └── widgets/
│   │   │       ├── sorting_menu.dart
│   │   │       └── widgets.dart
│   │   └── home/
│   │       ├── home.dart
│   │       ├── cubit/
│   │       │   ├── home_cubit.dart
│   │       │   └── home_state.dart
│   │       └── view/
│   │           ├── home_page.dart
│   │           └── view.dart
│   ├── repositories/
│   │   └── characters/
│   │       ├── characters.dart
│   │       ├── characters_repository.dart
│   │       └── model/
│   │           ├── character.dart
│   │           └── model.dart
│   ├── ui/
│   │   ├── ui.dart
│   │   ├── theme/
│   │   │   ├── theme.dart
│   │   │   └── cubit/
│   │   │       ├── theme_cubit.dart
│   │   │       └── theme_state.dart
│   │   └── widgets/
│   │       ├── character_list_card.dart
│   │       └── widgets.dart
│   └── utils/
│       ├── utils.dart
│       └── extensions/
│           ├── extensions.dart
│           └── to_companion.dart
```