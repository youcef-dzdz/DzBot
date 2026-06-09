# STATUS.md — LegalBot DZ
> État courant du projet — mis à jour à chaque fin de session

---

## 📊 Tableau de bord

| Item | Valeur |
|------|--------|
| **Date** | 2026-06-10 |
| **Phase actuelle** | Phase 1 — Portail Citoyen (Chat RAG) |
| **Progression globale** | ~14% (1/7 phases terminées) |
| **Dernière tâche terminée** | Webhook Clerk → Supabase sync users |
| **Prochaine tâche** | Phase 1.1 — Client Gemini + RAG (`lib/gemini.ts`, `lib/rag.ts`) |
| **Deadline** | Fin septembre 2026 — soutenance startup |

---

## ✅ Phase 0 — Infrastructure & Auth — 100% COMPLÈTE

| Tâche | Statut | Date |
|-------|--------|------|
| Init Next.js 14 + TypeScript + Tailwind | ✅ | 2026-06-07 |
| Setup Clerk + Supabase + middleware | ✅ | 2026-06-07 |
| Landing page + pages auth + design system | ✅ | 2026-06-07 |
| Localisation Clerk arSA / frFR / enUS | ✅ | 2026-06-09 |
| Migrations SQL Supabase (001 + 002 + 003) | ✅ | 2026-06-09 |
| Webhook Clerk → Supabase (`user.created`) | ✅ | 2026-06-09 |
| **Gate 2 — Test webhook production** | ✅ | 2026-06-10 |

**Résultat Gate 2 :** utilisateur `mokhtari.yusif@gmail.com` inséré dans Supabase table `users` avec `role=citoyen`. Webhook opérationnel.

---

## 🔄 Phase 1 — Portail Citoyen — 0%

| Tâche | Statut |
|-------|--------|
| 1.1 — Client Gemini + RAG | ⏳ À faire |
| 1.2 — System prompt agent | ⏳ À faire |
| 1.3 — Route `/api/chat` streaming | ⏳ À faire |
| 1.4 — Hook `useStream.ts` | ⏳ À faire |
| 1.5 — Composants Chat UI | ⏳ À faire |
| 1.6 — Page `/chat` | ⏳ À faire |
| 1.7 — Service chat + historique | ⏳ À faire |
| 1.8 — Page `/historique` | ⏳ À faire |

---

## 🐛 Bugs connus

| # | Description | Fichier | Priorité |
|---|-------------|---------|---------|
| — | Aucun | — | — |

---

## 🔑 Variables d'environnement

| Variable | Statut |
|----------|--------|
| `NEXT_PUBLIC_SUPABASE_URL` | ✅ Configurée |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | ✅ Configurée |
| `SUPABASE_SERVICE_ROLE_KEY` | ✅ Configurée |
| `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` | ✅ Configurée |
| `CLERK_SECRET_KEY` | ✅ Configurée |
| `CLERK_WEBHOOK_SECRET` | ✅ Configurée |
| `GEMINI_API_KEY` | ⏳ Requis pour Phase 1 |
| `RESEND_API_KEY` | ⏳ Requis pour Phase 2+ |
| `NEXT_PUBLIC_APP_URL` | ⏳ Requis pour déploiement |

---

*Dernière mise à jour : 2026-06-10*
