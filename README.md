Instrukcja uruchomienia:
Aby aplikacja działała poprawnie należy poczynić zmiany plików w -pubspec.yaml: w sekcji dependencies: flutter: sdk: flutter sqflite: any http: any path: any provider: any intl: any w sekcji assets: - lib/assets/login_icon.png
Należy następnie w Terminalu wpisać komendy:
flutter clean
rm -rf android/.gradle
flutter build apk
flutter pub get 
na końcu flutter run.
Po tych krokach i komendach należy zmodyfikować następujące pliki:
Android/settings.gradle zmieniając wersje jak poniżej: id "com.android.application" version "8.3.2" apply false - Android/gradle/gradle-wrapper.properties zmieniając wersję na najnowszą jak poniżej distributionUrl=https://services.gradle.org/distributions/gradle-8.12-all.zip




Opis działania aplikacji:
Aplikacja umożliwia użytkownikom zarządzanie codziennymi zadaniami, w tym tworzenie, edycję oraz usuwanie zadań. Każde zadanie może mieć przypisane indywidualne ustawienia, takie jak czcionka, kolor kafelka czy status ukończenia. Dodatkowo, aplikacja wyświetla aktualne dane pogodowe dla miasta Cieszyn na podstawie integracji z API OpenWeather. Dane użytkowników oraz zadań są przechowywane lokalnie w bazie danych SQLite.
Ekran logowania pozwala użytkownikowi wprowadzić nazwę użytkownika i hasło, które są sprawdzane w tabeli users w lokalnej bazie SQLite. W przypadku poprawnych danych użytkownik przechodzi do ekranu głównego, gdzie wyświetlana jest lista jego zadań. Jeśli dane logowania są niepoprawne, wyświetlany jest komunikat o błędzie. Na ekranie logowania wyświetlany jest także pasek z aktualną pogodą dla miasta Cieszyn, a użytkownik ma dostęp do przycisków „Log In” (logowanie użytkownika) i „Register” (przejście do ekranu rejestracji nowego użytkownika).
Ekran rejestracji umożliwia nowemu użytkownikowi podanie nazwy użytkownika i hasła, które zostają zapisane w tabeli users w bazie danych. Po pomyślnej rejestracji użytkownik jest przekierowywany z powrotem na ekran logowania.
Na ekranie głównym (HomeScreen) wyświetlana jest lista zadań przypisanych do zalogowanego użytkownika w formie kafelków. Każde zadanie zawiera tytuł, opcjonalną treść, status ukończenia zadania oraz indywidualne ustawienia czcionki i koloru kafelka. Zadania można edytować lub usuwać za pomocą dedykowanych przycisków. Na górze ekranu wyświetlana jest aktualna temperatura i opis pogody dla miasta Cieszyn. Dostępne są przyciski „Add Task” (przejście do ekranu dodawania nowego zadania) oraz „Log Out” (wylogowanie użytkownika i powrót do ekranu logowania).
Ekran edycji zadania (EditScreen) umożliwia użytkownikowi dodanie nowego zadania lub edycję istniejącego, wprowadzając tytuł, treść, ustawienia czcionki (typ, rozmiar, kolor) oraz kolor kafelka. Po zapisaniu zmiany są przechowywane w tabeli tasks w bazie danych, a użytkownik wraca na ekran główny, gdzie lista zadań jest automatycznie odświeżana.
W przypadku błędów aplikacja reaguje w sposób intuicyjny. Jeśli dane logowania są nieprawidłowe, użytkownik otrzymuje komunikat: „Nieprawidłowe dane logowania”. Jeśli dane zadania (np. brak tytułu) są niepełne, użytkownik jest proszony o ich uzupełnienie za pomocą komunikatu błędu. W przypadku problemów z połączeniem z API OpenWeather wyświetlany jest komunikat o błędzie, a aplikacja kontynuuje działanie.
Integracja z OpenWeather umożliwia pobieranie danych pogodowych dla miasta Cieszyn. Dane są prezentowane w formacie: temperatura w stopniach Celsjusza i opis pogody (np. „12.5°C, clear sky”). Dane pogodowe są odświeżane za każdym razem, gdy użytkownik otwiera aplikację lub ekran logowania.
Aplikacja jest intuicyjna, estetyczna i pozwala użytkownikom na efektywne zarządzanie codziennymi zadaniami w przyjaznym środowisku.


Użyte technologie:
dependencies:
flutter:
sdk: flutter
sqflite: any
path: any
provider: any
http: any
flutter_colorpicker: any

