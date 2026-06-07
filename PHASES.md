# PHASES.md — LegalBot DZ
Dernière mise à jour: Mai 2026
Stack: Next.js 14 + Supabase + Clerk + Gemini + Resend + Vercel

---

## Résumé des Phases

| Phase | Module | Durée | Statut |
|-------|--------|-------|--------|
| 0 | Setup + Landing + Auth (Clerk) | 1.5 semaine | 🔄 En cours (~40%) |
| 1 | RAG + Agent IA (Gemini + pgvector) | 2.5 semaines | ⏳ À commencer |
| 2 | Portail Citoyen | 2.5 semaines | ⏳ À commencer |
| 3 | Portail Avocat | 2.5 semaines | ⏳ À commencer |
| 4 | Intégration + QA + Démo | 2 semaines | ⏳ À commencer |

**Total estimé: ~11 semaines** — Deadline: fin septembre 2025 ✅

---

## Phase 0 — Setup + Landing Page + Auth
**Durée estimée: 1.5 semaine**

**Valeur:** La fondation. Sans une base propre, tout ce qui vient après sera instable. Clerk remplace 2 semaines de code Auth par 1 jour.

### Tâches

#### Setup Technique
- [ ] Initialiser Next.js 14 + TypeScript
- [ ] Configurer Tailwind CSS + `uidesign.md` tokens
- [ ] Installer et configurer Clerk
- [ ] Créer projet Supabase + activer pgvector
- [ ] Configurer `.env.local` + `.env.example`
- [ ] Configurer `.gitignore`
- [ ] Configurer i18n (fr.json, en.json, ar.json)
- [ ] Créer la structure complète des dossiers
- [ ] Configurer `middleware.ts` Clerk
- [ ] Déployer sur Vercel (version vide)

#### Supabase — Migrations
- [ ] `001_init.sql` — tables users, conversations, messages, dossiers, audiences
- [ ] `002_pgvector.sql` — extension + table lois_algeriennes
- [ ] `003_rls_policies.sql` — Row Level Security toutes les tables
- [ ] `004_webhook_sync.sql` — fonction sync Clerk → Supabase

#### Clerk — Auth
- [x] Pages sign-in / sign-up (Clerk components)
- [ ] Webhook Clerk → sync users vers Supabase (`/api/webhooks/clerk`)
- [ ] Attribution des rôles: `citoyen` / `avocat` / `admin`
- [ ] Redirection automatique selon le rôle après login
- [ ] Protection des routes dans `middleware.ts`

#### Landing Page (`src/app/page.tsx`)
- [x] Navbar avec logo Thémis + boutons connexion
- [x] Hero section + badge + CTA buttons
- [x] Section problème (3 cards)
- [x] Section "Comment ça marche" (3 étapes)
- [x] Section features (citoyen + avocat)
- [x] CTA final
- [x] Footer avec langues
- [x] Responsive mobile + desktop
- [ ] Trilingue (fr/ar/en) — i18n non câblé, prochaine tâche

### Gate 0 Sign-off ✅
- [ ] `npm run build` — 0 erreurs
- [ ] Landing page affichée correctement en fr/ar/en
- [ ] Citoyen peut s'inscrire, se connecter, accéder à son portail
- [ ] Avocat peut s'inscrire, se connecter, accéder à son portail
- [ ] Routes protégées refusent les accès non authentifiés
- [ ] `.env.local` non commité sur GitHub
- [ ] Vercel deployment fonctionnel

---

## Phase 1 — Agent IA + RAG + pgvector
**Durée estimée: 2.5 semaines**

**Valeur:** Le cerveau de LegalBot. C'est ce qui différencie LegalBot d'un simple chatbot. pgvector dans Supabase remplace ChromaDB — même puissance, zéro infrastructure supplémentaire.

### Tâches

#### Indexation des Lois (`scripts/ingest-laws.ts`)
- [ ] Collecter les PDFs:
  - Code Civil algérien
  - Code du Travail
  - Code Pénal
  - Code de la Famille
- [ ] Script extraction texte depuis PDF
- [ ] Découpage en chunks (500 tokens avec overlap)
- [ ] Gemini Embedding API → vecteurs 768 dimensions
- [ ] Insertion dans Supabase pgvector
- [ ] Vérification: requête de test fonctionne

#### RAG System (`src/lib/rag.ts`)
- [ ] Fonction `embedQuery(question)` → vecteur
- [ ] Fonction `searchLaws(vector, limit)` → articles pertinents
- [ ] Fonction `buildContext(articles)` → texte de contexte
- [ ] Fonction `sanitizeInput(message)` → protection injection
- [ ] Tests unitaires des 3 fonctions

#### System Prompt (`src/lib/prompts.ts`)
- [ ] System prompt principal (identité + limites + langue)
- [ ] Anti-jailbreak + anti-injection
- [ ] Instruction de citation obligatoire
- [ ] Instruction disclaimer juridique
- [ ] Instruction détection langue automatique

#### Agent IA (`src/lib/gemini.ts`)
- [ ] Client Gemini configuré
- [ ] Fonction `chat(messages, context)` → stream
- [ ] Gestion du streaming token par token
- [ ] Gestion timeout 30 secondes
- [ ] Gestion erreurs mid-stream

#### API Route Chat (`src/app/api/chat/route.ts`)
- [ ] POST `/api/chat` → streaming response
- [ ] Auth Clerk obligatoire
- [ ] Rate limiting (10 req/min par user)
- [ ] RAG → context → Gemini → stream
- [ ] Sauvegarde messages dans Supabase
- [ ] Logs métadonnées uniquement (jamais le contenu)

#### Hook Streaming (`src/hooks/useStream.ts`)
- [ ] AbortController intégré
- [ ] Gestion état: loading / streaming / error / done
- [ ] Annulation propre du stream

### Tests Agent IA — Obligatoires
- [ ] Question arabe → réponse arabe + citation loi
- [ ] Question darija → réponse darija
- [ ] Question française → réponse française
- [ ] Question hors scope → refus poli
- [ ] Question sans résultat RAG → message insuffisance
- [ ] Prompt injection → refus + comportement normal
- [ ] Disclaimer juridique présent dans chaque réponse
- [ ] Streaming fonctionne mot par mot

### Gate 1 Sign-off ✅
- [ ] RAG retourne des résultats pertinents (vérifier logs)
- [ ] Agent répond avec citations de lois
- [ ] Agent répond dans la langue de l'utilisateur
- [ ] Streaming fonctionne correctement
- [ ] `npm run build` — 0 erreurs

---

## Phase 2 — Portail Citoyen
**Durée estimée: 2.5 semaines**

**Valeur:** Ce que le jury verra en premier. Un citoyen pose une question en arabe et reçoit une réponse juridique professionnelle avec citation de loi — c'est le wow moment.

### Tâches

#### Interface Chat (`src/app/(citoyen)/chat/`)
- [ ] Page chat principale
- [ ] `ChatWindow.tsx` — affichage des messages
- [ ] `MessageBubble.tsx` — bulles user (beige) + bot (blanc)
- [ ] `SourceTag.tsx` — badge citation loi en or
- [ ] `ChatInput.tsx` — input + bouton mic + bouton envoi
- [ ] Indicateur "L'agent réfléchit..."
- [ ] Affichage disclaimer juridique
- [ ] Streaming mot par mot
- [ ] Support RTL arabe complet
- [ ] Bouton "Télécharger PDF"
- [ ] Bouton "Voir avocats recommandés"

#### Génération PDF (`src/services/pdfService.ts`)
- [ ] Extraction infos clés de la conversation
- [ ] Génération PDF structuré:
  - Problème juridique
  - Résumé situation
  - Lois applicables avec citations
  - Étapes recommandées
  - Disclaimer juridique
  - Date + référence
- [ ] Bouton téléchargement dans l'interface

#### Suggestion d'Avocat
- [ ] Afficher 2-3 avocats après la conversation
- [ ] Filtrage: type de cas + localisation
- [ ] Données avocats dans Supabase

#### Historique (`src/app/(citoyen)/historique/`)
- [ ] Liste des conversations (depuis Supabase)
- [ ] Rouvrir une conversation
- [ ] Supprimer une conversation
- [ ] Recherche dans l'historique

#### Profil Citoyen (`src/app/(citoyen)/profil/`)
- [ ] Afficher infos depuis Clerk
- [ ] Modifier: nom, langue préférée
- [ ] Changer mot de passe (via Clerk)

### Gate 2 Sign-off ✅
- [ ] Parcours complet citoyen A→Z sans bug
- [ ] Chat → streaming → réponse avec citation
- [ ] PDF généré et téléchargeable
- [ ] Suggestion avocat affichée
- [ ] Historique fonctionne
- [ ] Interface fr/ar/en
- [ ] RTL arabe correct
- [ ] Responsive mobile + desktop
- [ ] `npm run build` — 0 erreurs

---

## Phase 3 — Portail Avocat
**Durée estimée: 2.5 semaines**

**Valeur:** Ce qui convainc les avocats de payer. Un avocat qui voit que LegalBot lui économise 2-3 heures par jour — c'est un client acquis.

### Tâches

#### Dashboard (`src/app/(avocat)/dashboard/`)
- [ ] KPIs: dossiers actifs, en attente, audiences, mémoires IA
- [ ] Liste dossiers récents
- [ ] Prochaines audiences
- [ ] Section outils IA
- [ ] Notifications badge

#### Gestion Dossiers (`src/app/(avocat)/dossiers/`)
- [ ] Liste complète avec filtres (type, statut, date)
- [ ] Créer nouveau dossier
- [ ] Détail dossier: client, faits, documents, audiences
- [ ] Workflow: En attente → En cours → Clôturé
- [ ] Upload PDF dossier (Supabase Storage)

#### Audiences (`src/app/(avocat)/dossiers/[id]/`)
- [ ] Ajouter audience (tribunal, date, heure)
- [ ] Liste audiences par dossier
- [ ] Email de rappel automatique (Resend)

#### Mémoires IA (`src/app/(avocat)/memoires/`)
- [ ] L'avocat décrit son cas (texte)
- [ ] Gemini détecte le type (civil, pénal, travail, famille)
- [ ] Gemini remplit le template mémoire automatiquement
- [ ] L'avocat révise → valide → télécharge PDF
- [ ] Route: `POST /api/memoires/generate`

#### Resend — Emails Automatiques (`src/lib/resend.ts`)
- [ ] Email bienvenue à l'inscription
- [ ] Email rappel audience (J-1 à 8h00)
- [ ] Email notification nouveau dossier

#### Profil Avocat (`src/app/(avocat)/profil/`)
- [ ] Infos professionnelles: spécialité, ville, contact
- [ ] Disponibilité pour recommandations
- [ ] Modifier via Clerk + Supabase

### Gate 3 Sign-off ✅
- [ ] Dashboard affiche KPIs et dossiers
- [ ] CRUD dossiers complet
- [ ] Mémoire IA générée depuis description texte
- [ ] Email rappel audience envoyé (Resend)
- [ ] Upload PDF fonctionne (Supabase Storage)
- [ ] `npm run build` — 0 erreurs

---

## Phase 4 — Intégration + QA + Préparation Démo
**Durée estimée: 2 semaines**

**Valeur:** La différence entre "ça marche à peu près" et "c'est professionnel". Cette phase transforme le prototype en démo convaincante.

### Tâches

#### Admin (`src/app/(admin)/`)
- [ ] Dashboard stats système
- [ ] Upload nouvelle loi PDF → indexation automatique
- [ ] Liste utilisateurs

#### QA Complète
- [ ] Parcours citoyen A→Z — 0 bug
- [ ] Parcours avocat A→Z — 0 bug
- [ ] Parcours admin A→Z — 0 bug
- [ ] Tous les scénarios agent IA
- [ ] Tests mobile (responsive)
- [ ] Tests RTL arabe
- [ ] Tests trilingues (fr/ar/en)
- [ ] Security checklist complète

#### Préparation Démo Jury
- [ ] Données de test réalistes
- [ ] Script démonstration (citoyen + avocat)
- [ ] Vercel deployment stable
- [ ] Variables d'env production configurées
- [ ] Backup local en cas problème réseau

### Gate Final Sign-off ✅
- [ ] Parcours citoyen: 0 bug
- [ ] Parcours avocat: 0 bug
- [ ] Admin: 0 bug
- [ ] `npm run build` — 0 erreurs
- [ ] Vercel deployment: ✅ live
- [ ] ✅ PRÊT POUR LA SOUTENANCE

---

## ⛔ Post-Graduation Roadmap

> Sauvegardée dans `docs/architecture-v2/` — NE PAS implémenter avant la soutenance.

| Feature | Description |
|---------|-------------|
| Migration FastAPI | Python backend pour AI processing avancé |
| LangGraph Agent | Workflow agent complexe multi-étapes |
| Paiement | Stripe / CIB algérien |
| App mobile | iOS + Android |
| Toutes les professions | Notaire, Huissier, Expert judiciaire... |
| Multi-tenant SaaS | Infrastructure cloud scalable |
| OCR documents | Analyse automatique contrats |
| Vidéo-consultation | Rendez-vous en ligne |

---

*Dernière mise à jour: 2026-06-07*
*Stack: Next.js 14 + Supabase + Clerk + Gemini + Resend + Vercel*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
