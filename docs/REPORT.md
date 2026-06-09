# REPORT.md — LegalBot DZ
> Journal de bord des tâches — format obligatoire CLAUDE.md Règle #16

---

## [2026-06-09 — Session 1] Webhook Clerk → Supabase

### Avant
| Item | État |
|------|------|
| `app/api/webhooks/clerk/route.ts` | Absent |
| `svix` dans package.json | Absent |
| Route webhook dans middleware publicRoutes | Absent |
| `docs/REPORT.md` | Absent |

### Après
| Item | État |
|------|------|
| `app/api/webhooks/clerk/route.ts` | Créé — 104 lignes |
| `svix@3.x` | Installé (4 packages ajoutés) |
| `/api/webhooks/clerk` ajouté à publicRoutes | Fait — `middleware.ts` ligne 5 |
| `docs/REPORT.md` | Créé |

### Fichiers modifiés
| Fichier | Action | Raison |
|---------|--------|--------|
| `app/api/webhooks/clerk/route.ts` | Créé | Webhook principal — synchronisation Clerk → Supabase |
| `middleware.ts` | Modifié | Ajout de `/api/webhooks/clerk` aux routes publiques |
| `package.json` | Modifié (npm) | Installation de `svix` |

### Journal des accidents
Aucun.

### Build
```
✓ Compiled successfully
✓ Linting and checking validity of types
✓ Generating static pages (6/6)
Route: ƒ /api/webhooks/clerk — 0 B (server-rendered on demand)
```
Zéro erreur TypeScript. Zéro warning.

### Architecture de la route

```
POST /api/webhooks/clerk
        ↓
verifierSignature()       ← svix — vérifie svix-id / svix-timestamp / svix-signature
        ↓ (400 si invalide)
evenement.type === 'user.created' ?
        ↓ oui
syncUserCreated()         ← supabaseAdmin (service role, bypass RLS)
        ↓
INSERT INTO users (clerk_id, email, role='citoyen', nom)
        ↓
200 { recu: true }
```

### Variables d'environnement requises
```env
NEXT_PUBLIC_SUPABASE_URL=       # déjà présent
SUPABASE_SERVICE_ROLE_KEY=      # requis — clé service role Supabase
CLERK_WEBHOOK_SECRET=           # requis — signing secret du webhook Clerk (whsec_...)
```

### Ce que le fondateur doit tester (Gate 1 — Règle #11)

1. **Configurer le webhook dans Clerk Dashboard :**
   - Aller dans Clerk Dashboard → Webhooks → Add Endpoint
   - URL : `https://<domaine>/api/webhooks/clerk`
   - Événements à cocher : `user.created`
   - Copier le Signing Secret → le coller dans `.env.local` sous `CLERK_WEBHOOK_SECRET`

2. **Tester en local avec ngrok ou Clerk CLI :**
   ```bash
   npx clerk webhooks listen --url http://localhost:3000/api/webhooks/clerk
   ```

3. **Créer un compte test** via `/sign-up` et vérifier dans Supabase :
   - Table `users` → doit contenir une nouvelle ligne avec `clerk_id`, `email`, `role='citoyen'`

4. **Tester le rejet de signature invalide :**
   ```bash
   curl -X POST http://localhost:3000/api/webhooks/clerk \
     -H "Content-Type: application/json" \
     -d '{"type":"user.created"}'
   # Réponse attendue : 400 { "erreur": "Signature webhook invalide..." }
   ```

---

## [2026-06-10 — Session 2] Gate 2 — Validation webhook + Mise à jour documentation

### Avant
| Item | État |
|------|------|
| `docs/STATUS.md` | Absent |
| `docs/PHASES.md` | Absent |
| Gate 2 webhook | Non validé |
| Phase 0 | Non marquée 100% |

### Après
| Item | État |
|------|------|
| `docs/STATUS.md` | Créé — état courant du projet |
| `docs/PHASES.md` | Créé — feuille de route complète 7 phases |
| Gate 2 webhook | ✅ Validé |
| Phase 0 | ✅ 100% complète |

### Fichiers modifiés
| Fichier | Action | Raison |
|---------|--------|--------|
| `docs/STATUS.md` | Créé | Tableau de bord session start protocol |
| `docs/PHASES.md` | Créé | Feuille de route 7 phases avec tâches détaillées |
| `docs/REPORT.md` | Modifié | Ajout entrée Gate 2 (cette entrée) |

### Journal des accidents
Aucun.

### Résultat du test Gate 2 — Webhook

| Champ | Valeur |
|-------|--------|
| Email inséré | `mokhtari.yusif@gmail.com` |
| Table | `users` |
| `role` | `citoyen` |
| `clerk_id` | Présent |
| `nom` | Présent |
| Signature svix | Vérifiée ✅ |
| Code retour | `200 { recu: true }` |

**Conclusion :** Le webhook Clerk → Supabase est opérationnel en production. Phase 0 validée à 100%.

### État des phases après cette session
| Phase | Progression |
|-------|-------------|
| Phase 0 — Infrastructure & Auth | ✅ 100% |
| Phase 1 — Portail Citoyen (Chat RAG) | 🔄 0% — prochaine |
| Phases 2–6 | ⏳ En attente |

---
