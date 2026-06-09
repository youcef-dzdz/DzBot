# PHASES.md — LegalBot DZ
> Feuille de route technique — Deadline : fin septembre 2026 (soutenance startup)

---

## Vue d'ensemble

| Phase | Nom | Statut | Progression |
|-------|-----|--------|-------------|
| 0 | Infrastructure & Auth | ✅ Terminée | 100% |
| 1 | Portail Citoyen — Chat RAG | 🔄 En cours | 0% |
| 2 | Portail Avocat — Gestion dossiers | ⏳ En attente | 0% |
| 3 | Portail Notaire | ⏳ En attente | 0% |
| 4 | Portail Admin | ⏳ En attente | 0% |
| 5 | RAG — Indexation lois algériennes | ⏳ En attente | 0% |
| 6 | Déploiement Vercel + QA finale | ⏳ En attente | 0% |

---

## ✅ Phase 0 — Infrastructure & Auth — TERMINÉE

**Objectif :** Poser les fondations techniques du projet — stack, auth, DB, design system.

| Tâche | Commit | Statut |
|-------|--------|--------|
| Init Next.js 14 + TypeScript + Tailwind | `c53793d` | ✅ |
| Setup Clerk + Supabase + middleware + layout | `f42a02c` | ✅ |
| Fix middleware publicRoutes + scroll-mt | `85ab1b4` | ✅ |
| Landing page + pages auth + design system | `7c8314f` | ✅ |
| Localisation Clerk arSA / frFR / enUS | `a8d741d` | ✅ |
| Webhook Clerk → Supabase sync users | `f38ff14` | ✅ |
| Migrations SQL Supabase (001 + 002 + 003) | `f38ff14` | ✅ |

**Gate 2 validé le 2026-06-10 :** webhook testé en production — utilisateur inséré dans Supabase avec `role=citoyen`.

---

## 🔄 Phase 1 — Portail Citoyen — Chat RAG

**Objectif :** Permettre à un citoyen connecté d'interroger les lois algériennes via l'agent IA avec RAG.

### Tâches

| # | Tâche | Fichiers cibles | Statut |
|---|-------|-----------------|--------|
| 1.1 | Client Gemini + RAG (embedding + similarity search) | `lib/gemini.ts`, `lib/rag.ts` | ⏳ |
| 1.2 | System prompt agent juridique | `lib/prompts.ts` | ⏳ |
| 1.3 | Route API `/api/chat` — streaming Gemini + RAG | `app/api/chat/route.ts` | ⏳ |
| 1.4 | Hook `useStream.ts` — AbortController + streaming | `hooks/useStream.ts` | ⏳ |
| 1.5 | Composants Chat UI | `components/chat/ChatWindow.tsx`, `ChatInput.tsx`, `MessageBubble.tsx`, `SourceTag.tsx` | ⏳ |
| 1.6 | Page `/chat` | `app/(citoyen)/chat/page.tsx` | ⏳ |
| 1.7 | Service chat + historique Supabase | `services/chatService.ts` | ⏳ |
| 1.8 | Page `/historique` | `app/(citoyen)/historique/page.tsx` | ⏳ |

**Prérequis :** Phase 0 ✅ — `GEMINI_API_KEY` configurée dans `.env.local`

---

## ⏳ Phase 2 — Portail Avocat — Gestion dossiers

**Objectif :** Permettre à un avocat de gérer ses dossiers clients, audiences et actes.

| # | Tâche | Fichiers cibles |
|---|-------|-----------------|
| 2.1 | Service dossiers CRUD | `services/dossierService.ts` |
| 2.2 | Dashboard avocat | `app/(avocat)/dashboard/page.tsx` |
| 2.3 | Liste dossiers + fiche dossier | `app/(avocat)/dossiers/page.tsx`, `[id]/page.tsx` |
| 2.4 | Gestion audiences | Composants dans `components/avocat/` |
| 2.5 | Mémoires / actes générés | `app/(avocat)/memoires/page.tsx` |
| 2.6 | Profil avocat | `app/(avocat)/profil/page.tsx` |

---

## ⏳ Phase 3 — Portail Notaire

**Objectif :** Permettre à un notaire de gérer ses dossiers, actes et biens immobiliers.

*(Détail des tâches à définir en Phase 2)*

---

## ⏳ Phase 4 — Portail Admin

**Objectif :** Permettre à l'admin de gérer les lois, utilisateurs, inscriptions et statistiques.

| # | Tâche | Fichiers cibles |
|---|-------|-----------------|
| 4.1 | Dashboard admin | `app/(admin)/dashboard/page.tsx` |
| 4.2 | Gestion lois | `app/(admin)/lois/page.tsx` |
| 4.3 | Validation inscriptions avocats/notaires | `app/(admin)/inscriptions/page.tsx` |

---

## ⏳ Phase 5 — RAG — Indexation lois algériennes

**Objectif :** Indexer les lois algériennes en PDF dans Supabase pgvector.

| # | Tâche | Fichiers cibles |
|---|-------|-----------------|
| 5.1 | Script d'extraction PDF → chunks | `scripts/ingest-laws.ts` |
| 5.2 | Embedding Gemini + INSERT pgvector | `scripts/ingest-laws.ts` |
| 5.3 | Seed données avocats test | `scripts/seed-lawyers.ts` |

---

## ⏳ Phase 6 — Déploiement Vercel + QA finale

**Objectif :** Déployer en production et valider tous les modules.

| # | Tâche |
|---|-------|
| 6.1 | Configuration Vercel + variables d'environnement |
| 6.2 | QA complète — tous les portails |
| 6.3 | Tests scénarios agent IA (CLAUDE.md §Scénarios de Test) |
| 6.4 | Préparation soutenance |

---

*Dernière mise à jour : 2026-06-10*
