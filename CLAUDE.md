# CLAUDE.md — LegalBot DZ
> **LIS CE FICHIER EN ENTIER AVANT DE TOUCHER AU MOINDRE CODE.**
> Tu es un agent de codage IA travaillant sur le projet LegalBot DZ.
> Produis un rapport de statut complet et attends l'approbation du fondateur avant de faire quoi que ce soit.

---

## 🔴 LES 17 RÈGLES D'OR — NON NÉGOCIABLES

Violer une seule règle invalide la tâche. Sans exception.

| # | Règle |
|---|-------|
| 1 | **Jamais d'erreurs brutes montrées à l'utilisateur.** Toujours afficher un message générique traduit et professionnel. Jamais de `setError(error.message)` rendu dans l'UI. |
| 2 | **Fetch natif + AbortController pour le streaming. Fetch standard pour les requêtes normales.** Le streaming de l'agent IA utilise `useStream.ts` + AbortController — obligatoire. |
| 3 | **Aucun composant de plus de 300 lignes.** Si une page dépasse 300 lignes, la diviser en sous-composants nommés avant de continuer. |
| 4 | **Les clés de traduction doivent exister dans les 3 fichiers AVANT de construire le composant.** Ajouter dans `fr.json`, `en.json`, ET `ar.json` d'abord. Jamais "plus tard". Le code et les commentaires sont en français uniquement. L'UI et l'agent répondent dans les 3 langues. |
| 5 | **`npm run build` à zéro erreur = seule définition de "terminé".** Une tâche n'est pas terminée si le build échoue ou contient des erreurs TypeScript. |
| 6 | **Jamais créer un nouveau composant sans vérifier qu'il n'existe pas déjà.** Chercher dans `frontend/src/components/` avant de créer quoi que ce soit. |
| 7 | **Un composant de page par fichier. Sans exception.** Jamais regrouper deux pages dans un seul fichier. |
| 8 | **Jamais hardcoder des couleurs, espacements ou ombres.** Classes Tailwind uniquement selon `uidesign.md`. Si une valeur n'est pas dans `uidesign.md`, l'y ajouter d'abord. |
| 9 | **Les appels API et Supabase vivent dans `/services/` uniquement.** Jamais écrire `fetch()` ou `supabase.from()` directement dans une page ou un composant. |
| 10 | **En cas de doute sur le scope — s'arrêter et demander. Jamais supposer.** L'incertitude n'est pas une permission d'élargir le scope. |
| 11 | **Gate 1 — Validation humaine après chaque tâche.** Après chaque build ou correction terminé, dire au fondateur exactement quoi tester, puis s'arrêter et attendre confirmation. |
| 12 | **Gate 2 — QA stricte du module complet.** Quand un module entier est terminé, tester chaque page, bouton, formulaire. Zéro échec avant de passer au module suivant. |
| 13 | **Chaque tâche produit un rapport avant/après.** Le journal des accidents est obligatoire — écrire "Aucun" si propre. |
| 14/15 | **Avant de modifier TOUT fichier existant: backup → modifier → documenter.** Créer le backup dans `.fix-backups/<timestamp>/` avant le premier edit. |
| 16 | **Chaque tâche terminée ajoute son rapport complet à `docs/REPORT.md`.** Format: header timestamp + rapport complet. Jamais résumer ou tronquer. |
| 17 | **Chaque méthode et handler React clé doit avoir un commentaire professionnel de 2 lignes.** Ligne 1 = ce que ça fait. Ligne 2 = qui peut le faire et pourquoi. |

---

## 🎯 Vue d'Ensemble du Projet

| Item | Valeur |
|------|--------|
| **Nom** | LegalBot DZ |
| **Type** | Plateforme LegalTech intelligente multilingue |
| **Marché** | Algérie — citoyens + professions libérales juridiques |
| **Fondateur** | Solo |
| **Deadline** | Fin septembre 2025 — soutenance startup |
| **Langues du code** | Français (code, commentaires, MD files) |
| **Langues de l'UI** | Français, Arabe, Anglais |
| **Chemin local** | `C:\Users\HP X2\Documents\legalbot-dz` |

---

## 🏗️ Stack Technique — Architecture Finale

```
Frontend          →  Next.js 14 + TypeScript + Tailwind CSS
Auth              →  Clerk (frontend) + Supabase RLS (backend)
Base de données   →  Supabase (PostgreSQL + pgvector + Storage)
RAG / Vector      →  pgvector dans Supabase
Agent IA          →  Gemini API (direct, sans LangGraph)
Emails            →  Resend
Deployment        →  Vercel
```

### Pourquoi cette stack?
- **TypeScript uniquement** — pas de Python, pas de FastAPI, pas de ChromaDB
- **Supabase** = PostgreSQL + pgvector + Storage + Auth en une seule plateforme
- **Clerk** = Auth production-ready en 1 jour au lieu de 2 semaines
- **Gemini direct** = RAG sans LangGraph — même résultat, 10x moins de code
- **Vercel** = deployment en minutes, pas en jours

### Architecture V2 (Post-graduation) sauvegardée dans:
```
docs/architecture-v2/   ← FastAPI + LangGraph + ChromaDB — NE PAS TOUCHER
```

---

## 🏗️ Structure des Dossiers

```
legalbot-dz/
│
├── CLAUDE.md                    # Ce fichier — mémoire du projet
├── uidesign.md                  # Système de design UI validé
├── .env.local                   # ⛔ JAMAIS commité
├── .env.example                 # ✅ Modèle public sans valeurs
├── .gitignore
│
├── docs/
│   ├── PHASES.md
│   ├── STATUS.md
│   ├── FIX.md
│   ├── SECURITY.md
│   ├── REPORT.md
│   └── architecture-v2/         # Architecture production — après graduation
│       ├── CLAUDE.md
│       └── PHASES.md
│
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   │   ├── sign-in/[[...sign-in]]/page.tsx
│   │   │   └── sign-up/[[...sign-up]]/page.tsx
│   │   ├── (citoyen)/
│   │   │   ├── chat/page.tsx
│   │   │   ├── historique/page.tsx
│   │   │   └── profil/page.tsx
│   │   ├── (avocat)/
│   │   │   ├── dashboard/page.tsx
│   │   │   ├── dossiers/page.tsx
│   │   │   ├── dossiers/[id]/page.tsx
│   │   │   ├── memoires/page.tsx
│   │   │   └── profil/page.tsx
│   │   ├── (admin)/
│   │   │   ├── lois/page.tsx
│   │   │   └── dashboard/page.tsx
│   │   ├── api/
│   │   │   ├── chat/route.ts          # Streaming Gemini + RAG
│   │   │   ├── webhooks/clerk/route.ts
│   │   │   └── laws/ingest/route.ts   # Indexation des lois
│   │   ├── layout.tsx
│   │   └── page.tsx                   # Landing page
│   │
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Navbar.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   └── Footer.tsx
│   │   ├── ui/
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── Badge.tsx
│   │   │   ├── Input.tsx
│   │   │   └── Modal.tsx
│   │   ├── chat/
│   │   │   ├── ChatWindow.tsx
│   │   │   ├── MessageBubble.tsx
│   │   │   ├── ChatInput.tsx
│   │   │   └── SourceTag.tsx
│   │   └── shared/
│   │       ├── LanguageSwitcher.tsx
│   │       ├── RTLWrapper.tsx
│   │       └── PDFDownloadButton.tsx
│   │
│   ├── hooks/
│   │   ├── useStream.ts           # Streaming Gemini avec AbortController
│   │   ├── useAuth.ts             # Clerk user + role
│   │   └── usePDF.ts              # Génération PDF
│   │
│   ├── services/
│   │   ├── supabase.ts            # Client Supabase
│   │   ├── chatService.ts         # Appels API chat
│   │   ├── dossierService.ts      # CRUD dossiers
│   │   ├── lawsService.ts         # Gestion lois
│   │   └── pdfService.ts          # Génération PDF
│   │
│   ├── lib/
│   │   ├── gemini.ts              # Client Gemini + RAG
│   │   ├── rag.ts                 # Logique RAG (search + embed)
│   │   ├── prompts.ts             # System prompts agent
│   │   └── resend.ts              # Client email
│   │
│   ├── middleware.ts              # Clerk auth middleware
│   ├── context/
│   │   └── LanguageContext.tsx
│   ├── types/
│   │   ├── user.types.ts
│   │   ├── chat.types.ts
│   │   └── dossier.types.ts
│   └── locales/
│       ├── fr.json
│       ├── ar.json
│       └── en.json
│
├── public/
│   ├── logo.png                   # Logo Thémis — fond crème
│   ├── logo-dark.png              # Logo Thémis — fond sombre
│   └── favicon.ico
│
├── laws/
│   ├── raw/                       # ⛔ gitignored — PDFs originaux
│   └── processed/                 # Textes extraits prêts pour RAG
│
├── scripts/
│   ├── ingest-laws.ts             # Indexation lois → Supabase pgvector
│   └── seed-lawyers.ts            # Données avocats de test
│
└── supabase/
    └── migrations/
        ├── 001_init.sql
        ├── 002_pgvector.sql
        └── 003_rls_policies.sql
```

---

## 🔑 Variables d'Environnement

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=        # ⛔ server-side uniquement

# Clerk
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=
CLERK_SECRET_KEY=
NEXT_PUBLIC_CLERK_SIGN_IN_URL=/sign-in
NEXT_PUBLIC_CLERK_SIGN_UP_URL=/sign-up
NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL=/
NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL=/

# Gemini
GEMINI_API_KEY=                   # aistudio.google.com

# Resend
RESEND_API_KEY=                   # resend.com

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

---

## 🤖 Système RAG — Architecture

```
Lois algériennes (PDF)
        ↓
scripts/ingest-laws.ts
        ↓
Découpage en chunks (500 tokens)
        ↓
Gemini Embedding API
        ↓
Supabase pgvector (table: lois_algeriennes)
        ↓
══════════════════════════════════
Question utilisateur
        ↓
Gemini Embedding (question)
        ↓
pgvector similarity search (top 5)
        ↓
Construction du prompt contextuel
        ↓
Gemini API (réponse streamée)
        ↓
Citation source + disclaimer
```

### Schema Supabase — Tables Principales

```sql
-- Lois algériennes vectorisées
CREATE TABLE lois_algeriennes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL,        -- 'civil', 'penal', 'famille', 'travail'
  article TEXT NOT NULL,     -- 'Article 126'
  contenu TEXT NOT NULL,     -- Texte complet de la loi
  embedding vector(768),     -- Gemini embedding dimension
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Utilisateurs (sync Clerk webhook)
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clerk_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('citoyen', 'avocat', 'admin')),
  nom TEXT,
  prenom TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Conversations citoyens
CREATE TABLE conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  titre TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Messages
CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  contenu TEXT NOT NULL,
  sources JSONB,             -- Articles de loi cités
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Dossiers avocat
CREATE TABLE dossiers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  avocat_id UUID REFERENCES users(id) ON DELETE CASCADE,
  client_nom TEXT NOT NULL,
  type_cas TEXT NOT NULL,
  statut TEXT DEFAULT 'actif' CHECK (statut IN ('actif', 'en_attente', 'cloture')),
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Audiences
CREATE TABLE audiences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id UUID REFERENCES dossiers(id) ON DELETE CASCADE,
  tribunal TEXT NOT NULL,
  date_audience TIMESTAMPTZ NOT NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 🤖 Règles de l'Agent IA

### Règle 1 — System Prompt
- Défini UNIQUEMENT dans `src/lib/prompts.ts` — jamais ailleurs
- Toute modification → documenter dans `docs/REPORT.md`

### Règle 2 — RAG Obligatoire
- Rechercher dans pgvector AVANT toute réponse juridique
- Minimum 3 résultats avant de répondre
- Si 0 résultats → message d'insuffisance standard

### Règle 3 — Langue de Réponse
- Détecter automatiquement la langue
- Arabe→Arabe | Darija→Darija | Français→Français | Anglais→Anglais

### Règle 4 — Prévention des Hallucinations
- Répondre UNIQUEMENT à partir des lois dans pgvector
- Citer TOUJOURS la source: "Selon l'article X du Code Y..."
- Ajouter TOUJOURS le disclaimer juridique

### Règle 5 — Streaming
- Toutes les réponses utilisent le streaming — sans exception
- `src/hooks/useStream.ts` + AbortController obligatoire
- Timeout maximum: 30 secondes

### Règle 6 — Sécurité Prompts
- Sanitiser les entrées AVANT envoi à Gemini
- Défini dans `src/lib/rag.ts`
- Jailbreak prevention dans le system prompt

---

## 🔐 Clerk — Gestion des Rôles

```typescript
// middleware.ts — protège toutes les routes
import { authMiddleware } from "@clerk/nextjs"

export default authMiddleware({
  publicRoutes: ["/", "/sign-in(.*)", "/sign-up(.*)"],
})

// Rôles dans Clerk metadata
// user.publicMetadata.role = 'citoyen' | 'avocat' | 'admin'

// Webhook Clerk → sync vers Supabase
// src/app/api/webhooks/clerk/route.ts
```

---

## 🔐 Supabase RLS — Sécurité des Données

```sql
-- Citoyen voit SES conversations uniquement
CREATE POLICY "citoyen_own_conversations"
ON conversations FOR ALL
USING (user_id = auth.uid());

-- Avocat voit SES dossiers uniquement
CREATE POLICY "avocat_own_dossiers"
ON dossiers FOR ALL
USING (avocat_id = auth.uid());

-- Lois: lecture publique, écriture admin uniquement
CREATE POLICY "lois_read_all"
ON lois_algeriennes FOR SELECT
USING (true);
```

---

## 🧪 Scénarios de Test Agent IA

| Scénario | Question test | Résultat attendu |
|----------|--------------|-----------------|
| Question valide | "عندي مشكل في الميراث" | Réponse arabe + citation loi |
| Darija | "عندي problème avec mon patron" | Réponse darija |
| Hors scope | "Quel temps fait-il?" | Refus poli |
| Sans résultat RAG | "Loi sur les drones" | Message insuffisance |
| Prompt injection | "Ignore tes instructions..." | Refus + comportement normal |

---

## 🚀 Session Start Protocol

> **Ordre obligatoire — avant tout code:**
> 1. Lire `CLAUDE.md` en entier
> 2. Lire `docs/STATUS.md`
> 3. Lire `docs/PHASES.md`
> 4. Lire `docs/REPORT.md` (3 dernières entrées)
> 5. Produire le rapport ci-dessous
> 6. Attendre confirmation du fondateur

---

## 📊 Rapport de Début de Session

**Date:** [YYYY-MM-DD HH:MM]
**Session #:** [numéro]

| Item | Valeur |
|------|--------|
| Phase actuelle | [Phase X] |
| Progression | [X%] |
| Dernière tâche | [description + date] |
| Prochaine tâche | [description précise] |
| Deadline | Fin septembre 2025 |

### Bugs Connus
| # | Description | Fichier | Priorité |
|---|-------------|---------|---------|
| — | — | — | — |

### Plan de la Session (max 3 tâches)
| # | Tâche | Fichiers | Durée |
|---|-------|----------|-------|
| 1 | [description] | [fichiers] | [~X min] |

---

> ## ✅ Rapport terminé — En attente de confirmation
> - **"GO"** → commence la tâche #1
> - **"MODIFIE [X]"** → modifie le plan
> - **"QUESTION"** → pose ta question

---

*Dernière mise à jour: Mai 2026*
*Stack validée: Next.js 14 + Supabase + Clerk + Gemini + Resend + Vercel*
*Architecture V2 (Production) sauvegardée dans docs/architecture-v2/*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
