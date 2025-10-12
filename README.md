
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
### Основные зависимости

| Пакет                   | Версия     | Описание                        |
|--------------------------|-----------|---------------------------------|
| cupertino_icons          | ^1.0.8    | Иконки для iOS                  |
| equatable                | ^2.0.7    | Сравнение объектов по значению  |
| http                     | ^1.5.0    | HTTP-запросы                    |
| drift                    | ^2.28.2   | ORM для SQLite                  |
| drift_flutter            | ^0.2.7    | Поддержка Drift для Flutter     |
| path_provider            | ^2.1.5    | Работа с файловой системой      |
| get_it                   | ^8.2.0    | DI контейнер                     |
| freezed_annotation       | ^3.1.0    | Генерация immutable классов     |
| flutter_bloc             | ^9.1.1    | State management                |
| hydrated_bloc            | ^10.1.1   | Сохранение состояния BLoC       |
| cached_network_image     | ^3.4.1    | Кэширование изображений         |
| rxdart                   | ^0.28.0   | Расширения для Stream           |
| json_annotation          | ^4.9.0    | JSON сериализация               |
| shimmer                  | ^3.0.0    | Эффекты загрузки                |

### Dev dependencies

| Пакет                   | Версия     | Описание                        |
|--------------------------|-----------|---------------------------------|
| flutter_test             | sdk       | Тестирование Flutter            |
| flutter_lints            | ^5.0.0    | Рекомендуемые правила линтинга |
| drift_dev                | ^2.28.3   | Генерация кода Drift            |
| build_runner             | ^2.9.0    | Генерация кода                  |
| freezed                  | ^3.2.3    | Генерация immutable классов     |
| json_serializable        | ^6.11.1   | Генерация JSON сериализации     |
| flutter_launcher_icons   | ^0.14.4   | Настройка иконок приложения     |

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