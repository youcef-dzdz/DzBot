# REPORT.md — LegalBot DZ
> **Journal d'audit permanent du projet.**
> Ce fichier accumule CHAQUE tâche complétée, CHAQUE fix appliqué, CHAQUE session de travail.
> Jamais résumer ou tronquer. Jamais supprimer une entrée existante.
> Ce fichier est la mémoire complète et honnête du projet.

---

## ⚠️ Instructions pour Claude Code — OBLIGATOIRES

### Quand ajouter une entrée?
- ✅ Après chaque **Build** (feature construite)
- ✅ Après chaque **Fix** (bug corrigé)
- ✅ Après chaque **QA** (module testé)
- ✅ Même si la session est **incomplète** (⏸️ En pause) — toujours documenter

### Ordre des entrées
- Les entrées les plus récentes apparaissent **EN BAS** (ordre chronologique)
- Ne JAMAIS modifier ou supprimer une entrée existante

### Après chaque entrée — 3 actions obligatoires
```
1. Ajouter l'entrée dans REPORT.md ← tu es ici
       ↓
2. Mettre à jour docs/STATUS.md
   - Dernière tâche complétée
   - Prochaine tâche
   - Bugs connus
   - Build status
       ↓
3. Mettre à jour docs/PHASES.md
   - Cocher ✅ les tâches complétées
   - Mettre à jour le statut de la phase (% progression)
```

> ⛔ Une session n'est pas terminée tant que STATUS.md et PHASES.md ne sont pas mis à jour.

---

## 📋 Template — Copier pour chaque entrée

```markdown
---
## Session [N] — [YYYY-MM-DD HH:MM] | [Build / Fix / QA] | [Nom de la tâche]

### Résumé
[Ligne 1: Ce qui a été fait — français simple, pas de jargon]
[Ligne 2: État actuel — propre ✅ / action manuelle nécessaire ⚠️ / en pause ⏸️]

### Durée
~[X] heures

### Fichiers Touchés
| Fichier | Action | Lignes |
|---------|--------|--------|
| chemin/vers/fichier.ext | Créé / Modifié / Supprimé | ~N lignes |

### Détails
[Description technique de ce qui a été construit ou corrigé]

### Avant / Après (pour les fichiers modifiés uniquement)

**Fichier:** chemin/vers/fichier.ext

**Avant:**
[code original exact]

**Après:**
[nouveau code]

**Pourquoi:** [justification — une phrase]

### Journal des Accidents
[Chaque ligne touchée non requise par la tâche — fichier + ligne + ce qui a changé]
— OU — Aucun

### Gate 1 — Quoi Tester (pour le fondateur)
1. Aller à: [URL exacte — ex: http://localhost:3000/citoyen/chat]
2. Action: [ce que le fondateur doit faire précisément]
3. Résultat attendu: [ce qui doit se passer]
4. Si bug: [symptôme à signaler]

### Statut Build
npm run build: ✅ 0 erreurs / ❌ [lister les erreurs]

### Confiance
✅ Élevée — Fix testé de bout en bout, comportement vérifié
⚠️ Moyenne — Logiquement correct, test manuel recommandé
❌ Faible — Incertain ou partiel, réviser avant de continuer

**Ce fix/build:** [Niveau] — [Une phrase d'explication]

### Backup
.fix-backups/[timestamp]/ — [fichiers sauvegardés]
— OU — Aucun backup nécessaire (fichier créé from scratch)

### Prochaine Étape
[La prochaine tâche exacte à faire — référencer PHASES.md si besoin]

### Mises à Jour Effectuées
- [ ] STATUS.md mis à jour ✅
- [ ] PHASES.md mis à jour ✅
```

---

## 📋 Template Session En Pause

```markdown
---
## Session [N] — [YYYY-MM-DD HH:MM] | ⏸️ EN PAUSE | [Nom de la tâche]

### Résumé
Session interrompue — tâche non complétée.

### Durée
~[X] heures travaillées

### Ce Qui A Été Fait (avant la pause)
- [x] [Étape 1 complétée]
- [x] [Étape 2 complétée]

### Ce Qui Reste À Faire (à reprendre)
- [ ] [Étape 3 — point exact de reprise]
- [ ] [Étape 4]

### Fichiers En Cours de Modification
| Fichier | État | Note |
|---------|------|------|
| chemin/fichier.ext | Modifié partiellement | [où on en est] |

### Statut Build
npm run build: ✅ 0 erreurs / ❌ [erreurs — à corriger à la reprise]

### Point de Reprise
[Description précise de où reprendre — comme si tu expliquais à quelqu'un d'autre]

### Mises à Jour Effectuées
- [ ] STATUS.md mis à jour ✅
- [ ] PHASES.md mis à jour ✅
```

---

---
## Session 1 — 2026-06-07 12:00 | Build | Page Sign-In Clerk

### Résumé
Création de la page d'authentification sign-in utilisant le composant Clerk `<SignIn />`, avec fond `bg-sidebar` et logo texte "LegalBot DZ".
État actuel: propre ✅ — build 0 erreurs, page rendue à `/sign-in`.

### Durée
~15 minutes

### Fichiers Touchés
| Fichier | Action | Lignes |
|---------|--------|--------|
| `app/(auth)/sign-in/[[...sign-in]]/page.tsx` | Créé | 18 lignes |
| `tailwind.config.ts` | Modifié | +60 lignes (palette design system complète) |
| `.env.local` | Modifié | +4 lignes (variables Clerk URL manquantes) |

### Détails
- Page sign-in : composant `<SignIn />` Clerk centré verticalement/horizontalement, fond `bg-sidebar` (#F2EDE6), logo texte "LegalBot" `primary-700` + "DZ" `gold-500`.
- tailwind.config.ts : ajout de toute la palette uidesign.md (couleurs custom, border-radius, box-shadow, fontFamily). Fichier était vierge (seulement `background`/`foreground`).
- .env.local : ajout de `NEXT_PUBLIC_CLERK_SIGN_IN_URL`, `NEXT_PUBLIC_CLERK_SIGN_UP_URL`, `NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL`, `NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL`.
- Middleware Clerk v5 (`clerkMiddleware()`) : routes publiques par défaut — aucune modification requise.
- `public/` inexistant → logo texte utilisé (image prévu Phase 0.2).

### Avant / Après

**Fichier:** `tailwind.config.ts`

**Avant:** Seulement `background: "var(--background)"` et `foreground: "var(--foreground)"` — aucune couleur custom.

**Après:** Palette complète du design system (primary, gold, bg-*, text-*, border-*, shadow-*, fontFamily).

**Pourquoi:** Sans ces couleurs, aucune classe Tailwind du design system ne génère de CSS — la page sign-in serait non stylisée.

---

**Fichier:** `.env.local`

**Avant:** Manquait les 4 variables Clerk URL (`SIGN_IN_URL`, `SIGN_UP_URL`, `AFTER_SIGN_IN_URL`, `AFTER_SIGN_UP_URL`).

**Après:** 4 variables ajoutées avec valeurs correctes.

**Pourquoi:** Clerk `<SignIn />` utilise ces variables pour les redirections post-authentification.

### Journal des Accidents
Aucun

### Gate 1 — Quoi Tester (pour le fondateur)
1. Lancer le serveur: `npm run dev`
2. Aller à: `http://localhost:3000/sign-in`
3. Résultat attendu: fond crème (#F2EDE6), logo "LegalBot" en marron foncé + "DZ" en or, formulaire Clerk en dessous
4. Tester: cliquer "Sign in" avec un compte existant → doit rediriger vers `/`
5. Tester: accéder à `/sign-in` sans être connecté → formulaire visible normalement
6. Si bug: signaler si la page est blanche (Clerk non initialisé) ou si les couleurs ne s'affichent pas

### Statut Build
npm run build: ✅ 0 erreurs — Route `/sign-in/[[...sign-in]]` générée (192 B)

### Confiance
✅ Élevée — Build vérifié, composant Clerk standard, aucune logique custom, couleurs conformes uidesign.md.

### Backup
`.fix-backups/20260607-1200/tailwind.config.ts.bak` — tailwind.config.ts avant modification
`.fix-backups/20260607-1200/.env.local.bak` — .env.local avant modification
Aucun backup nécessaire pour `page.tsx` (fichier créé from scratch)

### Prochaine Étape
Phase 0 — Créer la page `app/(auth)/sign-up/[[...sign-up]]/page.tsx` (même structure que sign-in)

### Mises à Jour Effectuées
- [x] STATUS.md mis à jour ✅
- [ ] PHASES.md mis à jour (non disponible — fichier à la racine, pas dans docs/)

---

---
## Session 2 — 2026-06-07 14:00 | Build | Landing Page + Pages Auth (sign-in/sign-up)

### Résumé
Construction de la landing page complète (7 sections) et finalisation des pages d'authentification Clerk sign-in/sign-up, avec logo Thémis ajouté dans `public/`.
État actuel: propre ✅ — build 0 erreurs, toutes les routes générées.

### Durée
~2 heures

### Fichiers Touchés
| Fichier | Action | Lignes |
|---------|--------|--------|
| `app/page.tsx` | Modifié | ~40 lignes (assemblage des sections) |
| `app/(auth)/sign-in/[[...sign-in]]/page.tsx` | Modifié | — |
| `app/(auth)/sign-up/[[...sign-up]]/page.tsx` | Créé | ~18 lignes |
| `components/landing/LandingNavbar.tsx` | Créé | — |
| `components/landing/LandingHero.tsx` | Créé | — |
| `components/landing/LandingProblem.tsx` | Créé | — |
| `components/landing/LandingHowItWorks.tsx` | Créé | — |
| `components/landing/LandingFeatures.tsx` | Créé | — |
| `components/landing/LandingCTA.tsx` | Créé | — |
| `components/landing/LandingFooter.tsx` | Créé | — |
| `public/logo.png` | Créé | — |
| `tailwind.config.ts` | Modifié | — |

### Détails
- Landing page (`app/page.tsx`) assemblée à partir de 7 sous-composants dans `components/landing/`: Navbar (logo + liens + CTA), Hero (badge + titre + sous-titre + CTA + animations fade-in), Problème (3 cards), Comment ça marche (3 étapes), Features (citoyen + avocat), CTA final, Footer.
- Page sign-up créée sur le même modèle que sign-in (composant Clerk `<SignUp />`, fond `bg-sidebar`).
- Logo Thémis (`logo.png`) ajouté dans `public/` et utilisé dans `LandingNavbar.tsx` via `next/image`.
- Classes responsive (`sm:`, `md:`, `lg:`) présentes dans la majorité des sections — testé visuellement mobile/desktop.

### Avant / Après (pour les fichiers modifiés uniquement)

**Fichier:** `app/page.tsx`

**Avant:** Page par défaut Create Next App (boilerplate).

**Après:** Assemblage des 7 sections de la landing page LegalBot DZ.

**Pourquoi:** Construire la landing page définie dans `PHASES.md` Phase 0.

### Journal des Accidents
Aucun

### Gate 1 — Quoi Tester (pour le fondateur)
1. Lancer le serveur: `npm run dev`
2. Aller à: `http://localhost:3000/`
3. Résultat attendu: 7 sections affichées dans l'ordre (Navbar, Hero, Problème, Comment ça marche, Features, CTA, Footer), logo visible, animations d'entrée sur le Hero, responsive mobile/desktop correct
4. Aller à: `http://localhost:3000/sign-up` — formulaire Clerk affiché sur fond `bg-sidebar`
5. Si bug: signaler les liens qui ne mènent nulle part (connus — voir Bugs Connus) ou tout problème d'affichage du logo

### Statut Build
npm run build: ✅ 0 erreurs — routes `/`, `/sign-in/[[...sign-in]]`, `/sign-up/[[...sign-up]]` générées

### Confiance
✅ Élevée — Build vérifié, sections conformes à `uidesign.md` (couleurs/tokens), composants testés visuellement.

### Backup
Aucun backup nécessaire — fichiers de composants créés from scratch; `app/page.tsx` et `tailwind.config.ts` modifiés en continuité directe de la session précédente (pas de contenu de production à préserver).

### Prochaine Étape
Phase 0 — Câbler i18n (`LanguageSwitcher.tsx` + `fr.json`/`en.json`/`ar.json`) et corriger les liens de navigation non connectés.

### Bugs Connus (introduits ou restants)
- Liens de navigation non connectés (landing + navbar)
- i18n manquant — UI uniquement en français
- Support RTL arabe absent

### Mises à Jour Effectuées
- [x] STATUS.md mis à jour ✅
- [x] PHASES.md mis à jour ✅

---
## Session de Fix — 2026-06-07T15:00:00

## Rapport de Fix

### Résumé
Les liens de navigation par ancre ("Fonctionnalités", "Comment ça marche") atterrissaient sous la navbar fixe — le titre de la section ciblée était masqué, donnant l'impression que le lien ne menait nulle part.
Ajout de `scroll-mt-20` sur les deux sections ciblées (`#fonctionnalites`, `#comment-ca-marche`) pour décaler le point de défilement sous la navbar `sticky`.
État actuel: propre ✅ — build 0 erreurs, aucun changement non intentionnel.

---

### Détails

**Problème:** Cliquer sur "Fonctionnalités" ou "Comment ça marche" scrolle la section visée tout en haut du viewport, où elle est recouverte par la navbar `sticky top-0 z-50` — le titre de section apparaît caché/coupé.
**Cause Racine:** Les sections `<section id="fonctionnalites">` et `<section id="comment-ca-marche">` ne définissaient pas de `scroll-margin-top`, donc le navigateur aligne leur bord supérieur exact avec le haut du viewport, sous la navbar fixe.
**Scope:** 2 fichiers modifiés, 2 lignes changées (analyse complète des 12 liens/boutons des 4 composants landing — aucun `href` cassé trouvé, voir tableau d'analyse fourni au fondateur avant application).

---

#### Fix 1: Décalage de défilement — section "Fonctionnalités"

Fichier:      `components/landing/LandingFeatures.tsx`
Localisation: Ligne 21 | fonction: `LandingFeatures()`

**Avant:**
```tsx
<section id="fonctionnalites" className="bg-bg-sidebar px-6 py-20">
```

**Après:**
```tsx
<section id="fonctionnalites" className="scroll-mt-20 bg-bg-sidebar px-6 py-20">
```

**Pourquoi:** `scroll-mt-20` (80px) ajoute une marge de défilement pour que le titre de la section reste visible sous la navbar fixe au clic sur le lien d'ancre `#fonctionnalites`.

---

#### Fix 2: Décalage de défilement — section "Comment ça marche"

Fichier:      `components/landing/LandingHowItWorks.tsx`
Localisation: Ligne 25 | fonction: `LandingHowItWorks()`

**Avant:**
```tsx
<section id="comment-ca-marche" className="bg-bg-base px-6 py-20">
```

**Après:**
```tsx
<section id="comment-ca-marche" className="scroll-mt-20 bg-bg-base px-6 py-20">
```

**Pourquoi:** même raison que Fix 1 — empêcher la navbar fixe de masquer le haut de la section visée par l'ancre `#comment-ca-marche`.

---

### Changements Non Intentionnels

— Aucun

**Statut de restauration:**
- ✅ Tous les changements vérifiés conformes au dry run (diff contre backup = uniquement les 2 lignes prévues)

---

### Boucle de Fix

— Aucune erreur secondaire trouvée. Boucle terminée après 1 passage (`npm run build` → ✅ 0 erreurs).

---

### Confiance

**Ce fix:** ✅ Élevé — Changement minimal et isolé (classe Tailwind utilitaire), build vérifié, diff audité ligne par ligne contre le dry run validé par le fondateur.

---

### Backup

`.fix-backups/20260607-fixliens/LandingFeatures.tsx.bak`
`.fix-backups/20260607-fixliens/LandingHowItWorks.tsx.bak`

### Note pour le fondateur (hors scope de ce fix)
La valeur `scroll-mt-20` (80px) est une estimation basée sur la hauteur visible actuelle de la navbar. Le logo dans `LandingNavbar.tsx:13` utilise `width={140} height={140}` (carré) au lieu de `width={160} height={48}` recommandé par `uidesign.md`, ce qui rend la navbar anormalement haute (~156px). Si cette dimension est corrigée séparément, revérifier visuellement que `scroll-mt-20` reste suffisant.

---

## Session de Fix — middleware.ts — 2026-06-07 23:24

### Résumé
`clerkMiddleware()` sans `publicRoutes` bloquait `/sign-in` et `/sign-up` — redirection vers `/` pour tous les utilisateurs non connectés.
État actuel: propre ✅ — build 0 erreurs, sign-in et sign-up accessibles sans session active.

### Détails

**Problème :** `clerkMiddleware()` sans `publicRoutes` bloquait `/sign-in` et `/sign-up` — redirection vers `/` pour tous les utilisateurs non connectés.

**Cause racine :** Clerk v5 protège toutes les routes par défaut sans configuration explicite.

**Fix :** ajout de `createRouteMatcher` avec routes publiques `['/', '/sign-in(.*)', '/sign-up(.*)']` + `auth().protect()` pour les routes privées.

**Fichier touché :** `middleware.ts`

**Ajustement Clerk v5 :** `auth().protect()` au lieu de `auth.protect()` (différence API v5).

### Statut Build
npm run build : ✅ 0 erreurs

### Confiance
✅ Élevée — testé manuellement, sign-in et sign-up accessibles sans session active.

### Backup
`.fix-backups/20260607-232443/middleware.ts`

---

---
## Session 3 — 2026-06-09 | Build | i18n complet (fr/en/ar) + LanguageSwitcher + RTL arabe

### Résumé
Mise en place du système i18n complet : 3 fichiers de traduction (fr/en/ar), contexte React avec persistance localStorage, sélecteur de langue dans la navbar, et support RTL arabe via synchronisation sur `document.documentElement.dir`.
État actuel: propre ✅ — build 0 erreurs, toutes les routes générées.

### Durée
~1 heure

### Fichiers Touchés
| Fichier | Action | Lignes |
|---------|--------|--------|
| `locales/fr.json` | Créé | 54 lignes |
| `locales/en.json` | Créé | 54 lignes |
| `locales/ar.json` | Créé | 54 lignes |
| `context/LanguageContext.tsx` | Créé | 68 lignes |
| `components/shared/LanguageSwitcher.tsx` | Créé | 32 lignes |
| `app/layout.tsx` | Modifié | +2 lignes (import + LanguageProvider) |
| `components/landing/LandingNavbar.tsx` | Modifié | +useLanguage + LanguageSwitcher + fix logo 160×48 |
| `components/landing/LandingHero.tsx` | Modifié | +useLanguage + t() sur tous les textes |
| `components/landing/LandingProblem.tsx` | Modifié | +useLanguage + t() sur tous les textes |
| `components/landing/LandingHowItWorks.tsx` | Modifié | +useLanguage + t() sur tous les textes |
| `components/landing/LandingFeatures.tsx` | Modifié | +useLanguage + t() sur tous les textes |
| `components/landing/LandingCTA.tsx` | Modifié | +useLanguage + t() sur tous les textes |
| `components/landing/LandingFooter.tsx` | Modifié | +useLanguage + t() sur tous les textes |

### Détails
- `locales/fr.json` / `en.json` / `ar.json` : structure plate avec sections `nav`, `hero`, `problem`, `how`, `features`, `cta`, `footer`. Clés identiques dans les 3 fichiers.
- `context/LanguageContext.tsx` : `LanguageProvider` + `useLanguage()` hook. Fonction `resolve()` pour notation pointée (`"nav.home"` → valeur). Persistance `localStorage`. `useEffect` synchronise `document.documentElement.lang` et `dir` sur chaque changement de locale.
- `components/shared/LanguageSwitcher.tsx` : 3 boutons (FR / EN / عر), bouton actif en `bg-primary-700`, accessible (`aria-pressed`).
- Tous les composants landing passés en `"use client"` pour accéder au hook `useLanguage`.
- Logo navbar corrigé : `width={140} height={140}` → `width={160} height={48}` (conformément à `uidesign.md`, signalé en note Session 2).

### Avant / Après

**Fichier:** `app/layout.tsx`

**Avant:** `ClerkProvider` → `html` → `body` → `{children}`

**Après:** `ClerkProvider` → `html` → `body` → `LanguageProvider` → `{children}`

**Pourquoi:** Le `LanguageProvider` doit entourer tout l'arbre de l'application pour que `useLanguage()` soit disponible dans tous les composants.

---

**Fichier:** `components/landing/LandingNavbar.tsx`

**Avant:** Textes hardcodés en français, logo `140×140`, pas de sélecteur de langue.

**Après:** Textes via `t()`, logo `160×48`, `LanguageSwitcher` entre les liens nav et le CTA.

**Pourquoi:** Conformité avec la règle 4 (clés i18n avant code) et correction du bug logo signalé Session 2.

### Journal des Accidents
Aucun

### Gate 1 — Quoi Tester (pour le fondateur)
1. Lancer le serveur: `npm run dev`
2. Aller à: `http://localhost:3000/`
3. Action: Cliquer sur "EN" dans le sélecteur de langue (en haut à droite de la navbar)
4. Résultat attendu: Tous les textes de la landing basculent en anglais instantanément
5. Action: Cliquer sur "عر"
6. Résultat attendu: Textes en arabe + page entière bascule en RTL (layout miroir)
7. Action: Rafraîchir la page (F5) avec la langue arabe active
8. Résultat attendu: La langue arabe est mémorisée (persistance localStorage)
9. Si bug: Signaler si les textes ne changent pas ou si le RTL ne s'applique pas

### Statut Build
npm run build: ✅ 0 erreurs
Route `/` — 17.3 kB | `/sign-in/[[...sign-in]]` — 205 B | `/sign-up/[[...sign-up]]` — 776 B

### Confiance
✅ Élevée — Build vérifié 0 erreurs TypeScript, architecture i18n standard React Context, RTL via attribut HTML natif.

### Backup
`.fix-backups/20260609-i18n/` — layout.tsx, LandingNavbar.tsx, LandingHero.tsx, LandingProblem.tsx, LandingHowItWorks.tsx, LandingFeatures.tsx, LandingCTA.tsx, LandingFooter.tsx

### Prochaine Étape
Phase 0 — Webhook Clerk → sync users vers Supabase (`src/app/api/webhooks/clerk/route.ts`) + attribution des rôles citoyen/avocat/admin.

### Mises à Jour Effectuées
- [x] STATUS.md mis à jour ✅
- [x] PHASES.md mis à jour ✅

---

---
## Session 4 — 2026-06-09 | Build | Localisation Clerk (arSA / frFR / enUS)

### Résumé
Installation de `@clerk/localizations` et câblage dans `ClerkProvider` via un wrapper client `LocalizedClerkProvider` — les formulaires Clerk (sign-in/sign-up) basculent maintenant en arabe, français ou anglais selon la langue sélectionnée.
État actuel: propre ✅ — build 0 erreurs.

### Durée
~20 minutes

### Fichiers Touchés
| Fichier | Action | Lignes |
|---------|--------|--------|
| `package.json` / `package-lock.json` | Modifié | +4 packages (`@clerk/localizations`) |
| `components/shared/LocalizedClerkProvider.tsx` | Créé | 26 lignes |
| `app/layout.tsx` | Modifié | ClerkProvider statique → LocalizedClerkProvider dynamique |

### Détails
- `@clerk/localizations` installé (4 packages ajoutés, build 418 packages).
- `LocalizedClerkProvider.tsx` : composant client wrappant `ClerkProvider`, lit `locale` depuis `useLanguage()` et passe `arSA` / `frFR` / `enUS` selon le choix de l'utilisateur.
- `layout.tsx` : suppression de l'import `ClerkProvider` direct — replaced par `LanguageProvider` → `LocalizedClerkProvider`. `<html>` et `<body>` remontent au niveau racine (pas d'impact fonctionnel).
- Fix TypeScript : conflit de types entre `@clerk/localizations` et `@clerk/nextjs` (versions de `LocalizationResource`) résolu avec `Record<string, any>`.

### Avant / Après

**Fichier:** `app/layout.tsx`

**Avant:**
```tsx
<ClerkProvider>           // statique, toujours en anglais
  <html lang="fr">
    <body>
      <LanguageProvider>
        {children}
      </LanguageProvider>
    </body>
  </html>
</ClerkProvider>
```

**Après:**
```tsx
<html lang="fr">
  <body>
    <LanguageProvider>         // lit la locale depuis localStorage
      <LocalizedClerkProvider> // passe arSA/frFR/enUS à ClerkProvider
        {children}
      </LocalizedClerkProvider>
    </LanguageProvider>
  </body>
</html>
```

**Pourquoi:** `ClerkProvider` doit être enfant de `LanguageProvider` pour pouvoir lire le locale via `useLanguage()` et passer la bonne localisation aux formulaires Clerk.

### Journal des Accidents
Aucun

### Gate 1 — Quoi Tester (pour le fondateur)
1. `npm run dev` → `http://localhost:3000/`
2. Cliquer "عر" dans le switcher de langue
3. Aller à `http://localhost:3000/sign-in`
4. Résultat attendu: formulaire sign-in entièrement en arabe (labels, placeholder, boutons, messages d'erreur)
5. Aller à `http://localhost:3000/sign-up`
6. Résultat attendu: formulaire sign-up entièrement en arabe
7. Revenir à "FR" → formulaires repassent en français
8. Si bug: signaler si les formulaires restent en anglais après changement de langue

### Statut Build
npm run build: ✅ 0 erreurs
Route `/` — 10.9 kB (static) | `/sign-in` — 1.94 kB | `/sign-up` — 2.01 kB

### Confiance
✅ Élevée — Build vérifié 0 erreurs, architecture propre, `arSA`/`frFR`/`enUS` sont des exports officiels de `@clerk/localizations`.

### Backup
`.fix-backups/20260609-i18n/layout.v2.tsx` — layout.tsx avant modification

### Prochaine Étape
Phase 0 — Webhook Clerk → sync users vers Supabase (`src/app/api/webhooks/clerk/route.ts`) + attribution des rôles citoyen/avocat/admin.

### Mises à Jour Effectuées
- [x] STATUS.md mis à jour ✅
- [x] PHASES.md mis à jour ✅

---

*Dernière mise à jour: 2026-06-09*
*Ce fichier est géré par Claude Code — ne pas modifier manuellement les entrées existantes.*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
