# HouseHub App

**HouseHub** — это приложение для управления домом, предоставляющее пользователю доступ к информации о квартплате, показаниям счётчиков и уведомлениям. Оно разработано на Swift и UIKit, и использует архитектуру MVC (Model-View-Controller).

## Особенности

- **Загрузка данных с сервера**: Приложение загружает данные профиля, уведомлений и других сервисов через API.
- **Отображение уведомлений**: Пользователи могут просматривать новые уведомления и их количество прямо на главном экране.
- **Управление квартплатой**: Приложение показывает текущую сумму квартплаты и предоставляет дополнительную информацию о ней.
- **Показания счетчиков**: Отображение последних показаний счетчиков для удобства пользователя.

## Скриншоты

[Посмотреть скриншоты](https://disk.yandex.ru/d/26Oq2K43ru6DOg)

## Скринкасты

[Посмотреть скринкасты](https://disk.yandex.ru/d/KJV21DBapC68KA)

## Используемые технологии

- Swift
- UIKit
- URLSession

## Архитектура

Приложение построено на основе MVC (Model-View-Controller). Модели используются для хранения данных, контроллеры управляют логикой приложения и взаимодействием с пользователем, а представления обеспечивают отображение данных.

## Структура проекта

- **DashboardData.swift**: Модель данных для главного экрана.
- **AuthService.swift**: Управление авторизацией пользователя.
- **DashboardService.swift**: Получение данных для главного экрана через API.
- **DashboardViewController.swift**: Отображение данных пользователя и управление главным экраном.
- **LoginViewController.swift**: Экран входа пользователя.
- **MainTabBarController.swift**: Управление вкладками основного интерфейса.
- **StartViewController.swift**: Экран приветствия и авторизации пользователя.
