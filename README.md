# 🌸 CycleFlow — Application de Suivi du Cycle Menstruel

> Application mobile Flutter pour le suivi, le calcul et la prédiction du cycle menstruel. Disponible sur Android et iOS.

---

## 📌 Table des matières

- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Technologies](#technologies)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Structure du projet](#structure-du-projet)
- [Modèle de données](#modèle-de-données)
- [Calculs & Algorithmes](#calculs--algorithmes)
- [Utilisation](#utilisation)
- [Confidentialité](#confidentialité)
- [Auteur](#auteur)
- [Licence](#licence)

---

## Aperçu

**CycleFlow** est une application mobile développée avec Flutter. Elle permet aux utilisatrices de suivre leur cycle menstruel, de prédire les prochaines règles, la période d'ovulation et les jours fertiles, tout en offrant un journal de symptômes et d'humeurs.

Toutes les données sont stockées **localement** sur l'appareil (aucune donnée personnelle envoyée en ligne), garantissant une confidentialité totale.

---

## Fonctionnalités

### 📅 Suivi du cycle
- Enregistrement du premier jour des règles
- Saisie de la durée des règles et de la durée du cycle
- Historique des cycles précédents
- Calcul automatique de la durée moyenne du cycle

### 🔮 Prédictions
- Prochaine date des règles
- Fenêtre d'ovulation estimée
- Jours fertiles (J-5 à J+1 autour de l'ovulation)
- Phase du cycle en cours (menstruelle, folliculaire, ovulatoire, lutéale)

### 📓 Journal de symptômes
- Suivi quotidien de l'humeur (😊 😐 😢 😡)
- Enregistrement des symptômes physiques (crampes, maux de tête, fatigue, etc.)
- Notes personnelles par journée
- Niveau de flux (léger, modéré, abondant)

### 📊 Statistiques & Historique
- Durée moyenne du cycle et des règles
- Graphique d'évolution des cycles
- Calendrier mensuel coloré selon les phases
- Export des données (JSON)

### 🔔 Notifications
- Rappel avant les prochaines règles (J-2)
- Rappel de la fenêtre fertile
- Rappel journalier pour la saisie des symptômes (optionnel)

---

## Technologies

| Composant | Technologie |
|-----------|-------------|
| Framework | Flutter 3.x |
| Langage | Dart 3.x |
| Stockage local | SQLite via `sqflite` |
| Préférences | `shared_preferences` |
| Notifications | `flutter_local_notifications` |
| Graphiques | `fl_chart` |
| Calendrier | `table_calendar` |
| Gestion d'état | Provider |
| Navigation | `go_router` |

---

## Prérequis

Avant de lancer le projet, assurez-vous d'avoir :

- **Flutter SDK 3.10+** → [Installer Flutter](https://docs.flutter.dev/get-started/install)
- **Dart 3.0+** (inclus avec Flutter)
- **Android Studio** ou **VS Code** avec l'extension Flutter
- Un émulateur Android/iOS ou un appareil physique

Vérifiez votre environnement :

```bash
flutter doctor
```

---

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/votre-utilisateur/cycleflow.git
cd cycleflow
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Lancer l'application

```bash
# Sur un émulateur ou appareil connecté
flutter run

# En mode release
flutter run --release
```

### 4. Compiler l'APK (Android)

```bash
flutter build apk --release
# Le fichier APK se trouve dans build/app/outputs/flutter-apk/
```

### 5. Compiler pour iOS

```bash
flutter build ios --release
```

---

## Dépendances (`pubspec.yaml`)

```yaml
name: cycleflow
description: Application de suivi du cycle menstruel
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # Base de données locale
  sqflite: ^2.3.0
  path: ^1.8.3

  # Préférences utilisateur
  shared_preferences: ^2.2.0

  # Notifications locales
  flutter_local_notifications: ^16.1.0

  # Graphiques
  fl_chart: ^0.66.0

  # Calendrier
  table_calendar: ^3.0.9

  # Gestion d'état
  provider: ^6.1.1

  # Navigation
  go_router: ^12.1.1

  # Icônes
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## Structure du projet

```
cycleflow/
├── lib/
│   ├── main.dart                         # Point d'entrée
│   ├── app.dart                          # Configuration app & thème
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart           # Palette de couleurs
│   │   │   └── app_strings.dart          # Textes & libellés
│   │   ├── utils/
│   │   │   ├── cycle_calculator.dart     # Algorithmes de calcul
│   │   │   └── date_helpers.dart         # Utilitaires de dates
│   │   └── database/
│   │       └── database_helper.dart      # Gestion SQLite
│   ├── models/
│   │   ├── cycle.dart                    # Modèle Cycle
│   │   ├── symptome.dart                 # Modèle Symptôme
│   │   └── journee.dart                  # Modèle Journée
│   ├── providers/
│   │   ├── cycle_provider.dart           # État des cycles
│   │   └── symptome_provider.dart        # État des symptômes
│   ├── repositories/
│   │   ├── cycle_repository.dart         # Accès données cycles
│   │   └── symptome_repository.dart      # Accès données symptômes
│   └── views/
│       ├── home/
│       │   └── home_screen.dart          # Écran principal
│       ├── calendar/
│       │   └── calendar_screen.dart      # Calendrier mensuel
│       ├── journal/
│       │   └── journal_screen.dart       # Journal quotidien
│       ├── stats/
│       │   └── stats_screen.dart         # Statistiques
│       └── settings/
│           └── settings_screen.dart      # Paramètres
├── assets/
│   ├── images/                           # Illustrations
│   └── icons/                            # Icônes personnalisées
├── test/
│   ├── unit/
│   │   └── cycle_calculator_test.dart    # Tests des calculs
│   └── widget/
│       └── home_screen_test.dart         # Tests de widgets
├── pubspec.yaml
└── README.md
```

---

## Modèle de données

### Table `cycles`

```sql
CREATE TABLE cycles (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    date_debut      TEXT NOT NULL,        -- Date du 1er jour des règles (ISO 8601)
    duree_regles    INTEGER DEFAULT 5,    -- Durée des règles en jours
    duree_cycle     INTEGER DEFAULT 28,   -- Durée totale du cycle en jours
    notes           TEXT,
    created_at      TEXT DEFAULT (datetime('now'))
);
```

### Table `journees`

```sql
CREATE TABLE journees (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    date            TEXT NOT NULL UNIQUE, -- Date (ISO 8601)
    humeur          TEXT,                 -- 'joyeuse','neutre','triste','irritee'
    niveau_flux     TEXT,                 -- 'leger','modere','abondant','aucun'
    temperature     REAL,                 -- Température basale (°C)
    notes           TEXT,
    created_at      TEXT DEFAULT (datetime('now'))
);
```

### Table `symptomes`

```sql
CREATE TABLE symptomes (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    journee_date    TEXT NOT NULL,        -- Référence à journees.date
    type_symptome   TEXT NOT NULL,        -- 'crampes','fatigue','maux_tete', etc.
    intensite       INTEGER DEFAULT 1,    -- Échelle 1 à 3
    created_at      TEXT DEFAULT (datetime('now'))
);
```

---

## Calculs & Algorithmes

### Prochaine date des règles

```dart
DateTime prochainesRegles(DateTime dernierDebut, int dureeCycle) {
  return dernierDebut.add(Duration(days: dureeCycle));
}
```

### Fenêtre d'ovulation

L'ovulation survient généralement **14 jours avant la fin du cycle** (phase lutéale fixe de 14 jours).

```dart
DateTime dateOvulation(DateTime dernierDebut, int dureeCycle) {
  return dernierDebut.add(Duration(days: dureeCycle - 14));
}

DateTimeRange fenetresFertiles(DateTime ovulation) {
  return DateTimeRange(
    start: ovulation.subtract(const Duration(days: 5)), // J-5
    end:   ovulation.add(const Duration(days: 1)),      // J+1
  );
}
```

### Phase du cycle actuelle

```dart
enum PhaseCycle { menstruelle, folliculaire, ovulatoire, lutéale }

PhaseCycle phaseActuelle(
  DateTime aujourd_hui,
  DateTime dernierDebut,
  int dureeCycle,
  int dureeRegles,
) {
  final jourDuCycle  = aujourd_hui.difference(dernierDebut).inDays + 1;
  final jourOvulation = dureeCycle - 14;

  if (jourDuCycle <= dureeRegles)         return PhaseCycle.menstruelle;
  if (jourDuCycle < jourOvulation - 1)    return PhaseCycle.folliculaire;
  if (jourDuCycle <= jourOvulation + 1)   return PhaseCycle.ovulatoire;
  return PhaseCycle.lutéale;
}
```

### Durée moyenne du cycle

```dart
double dureeMoyenneCycle(List<Cycle> cycles) {
  if (cycles.length < 2) return 28.0;
  final durees = <int>[];
  for (int i = 1; i < cycles.length; i++) {
    durees.add(
      cycles[i].dateDebut.difference(cycles[i - 1].dateDebut).inDays,
    );
  }
  return durees.reduce((a, b) => a + b) / durees.length;
}
```

---

## Utilisation

### Premier lancement

1. L'application demande la **date de début des dernières règles**
2. Saisir la **durée habituelle des règles** (par défaut : 5 jours)
3. Saisir la **durée habituelle du cycle** (par défaut : 28 jours)
4. Le tableau de bord affiche immédiatement les prédictions

### Enregistrer un nouveau cycle

1. Depuis l'écran **Accueil**, appuyer sur **"Mes règles ont commencé"**
2. Confirmer ou ajuster la date
3. Les prédictions sont automatiquement recalculées

### Journal quotidien

1. Aller dans l'onglet **Journal**
2. Sélectionner la date du jour
3. Renseigner l'humeur, le flux, les symptômes et une note
4. Appuyer sur **"Enregistrer"**

### Consulter les statistiques

1. Aller dans l'onglet **Statistiques**
2. Consulter la durée moyenne, l'irrégularité et les graphiques d'évolution
3. Utiliser **"Exporter"** pour sauvegarder les données en JSON

---

## Code couleur du calendrier

| Couleur | Phase |
|---------|-------|
| 🔴 Rouge | Jours de règles |
| 🟠 Orange | Jours fertiles |
| 🟡 Jaune | Jour d'ovulation |
| 🟣 Violet | Phase lutéale |
| ⚪ Blanc | Phase folliculaire |

---

## Confidentialité

> **Aucune donnée n'est collectée ni transmise.** Toutes les informations sont stockées exclusivement en local sur l'appareil de l'utilisatrice via SQLite. L'application ne requiert aucune connexion Internet.

---

## Auteur

Développé par **Vincent Gérard SALABANZI**
📧 vincent@vincentsalabanzi.com
🔗 [GitHub](https://github.com/20cen)

---

## Licence

Ce projet est sous licence **MIT** — voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

*CycleFlow v1.0 — Flutter 3 · Dart 3 · SQLite*
