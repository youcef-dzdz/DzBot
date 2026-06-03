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

*Les entrées de rapport commenceront ici après la première session de travail.*

---

*Dernière mise à jour: Mai 2026*
*Ce fichier est géré par Claude Code — ne pas modifier manuellement les entrées existantes.*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
