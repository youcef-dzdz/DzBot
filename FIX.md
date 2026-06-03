# FIX.md — Protocole de Correction Précise — LegalBot DZ
> **Ce fichier est activé UNIQUEMENT quand le fondateur signale un bug ou une régression.**
> Ne PAS appliquer ce protocole pendant la construction normale — utiliser les règles de `CLAUDE.md`.
> Construction de features: suivre `CLAUDE.md`. Choses cassées: suivre ce fichier.

---

## Principes Fondamentaux

**Chirurgical, pas balayant.**
Corriger uniquement la chose cassée. Ne pas refactoriser, renommer, reformater, ou améliorer le code adjacent sauf si le bug en est directement causé.

**Cause racine, pas symptôme.**
Traiter le défaut sous-jacent, pas son effet visible. Si la cause racine ne peut pas être identifiée, le dire explicitement — ne jamais deviner silencieusement.

**Transparence sur l'hypothèse.**
Chaque jugement doit être énoncé. Si un compromis existe, le nommer. Si plusieurs approches sont valides, choisir la moins invasive et expliquer pourquoi.

**Réversibilité.**
Tous les changements doivent être annulables. Le backup doit exister avant que le premier fichier soit modifié.

---

## Workflow

Les Phases 0, 1, et 2 s'exécutent automatiquement en séquence — produire le résumé d'intention, l'analyse complète, et l'aperçu dry-run sans pause pour permission. Le seul gate est à la fin de la Phase 2: le fondateur décide d'appliquer ou non. Rien n'est écrit sur disque jusqu'à cette confirmation.

---

### Phase 0 — Confirmation d'Intention (automatique)

Avant de lire un seul fichier, énoncer en français simple:
- Ce que tu as compris être le problème (une phrase)
- Quels fichiers tu t'attends à devoir lire
- Ce que le fix impliquera probablement (préliminaire, pas un engagement)

Puis procéder immédiatement à la Phase 1.

---

### Phase 1 — Analyse (automatique — lecture seule, ne rien toucher)

Lire chaque fichier pertinent. Identifier la cause racine. Définir ce que le fix requiert. Produire le Rapport d'Analyse, puis procéder immédiatement à la Phase 2.

**Format du Rapport d'Analyse:**
```
## Rapport d'Analyse

**Problème:** [Ce qui est cassé et comment ça se manifeste — une phrase]
**Cause Racine:** [Le défaut sous-jacent, pas le symptôme — une phrase]
**Fichiers Affectés:**

| Fichier | Lignes Estimées | Risque |
|---------|----------------|--------|
| chemin/vers/fichier.ext | ~N lignes | 🟢 Faible / 🟡 Moyen / 🔴 Élevé |

**Clé de Risque:**
🟢 Faible   — isolé, pas de consommateurs en aval, facile à vérifier
🟡 Moyen    — code partagé, plusieurs call sites, ou logique non triviale
🔴 Élevé    — chemin critique, auth/sécurité/données, ou surface large
```

Si le fix touchera plus de 3 fichiers ou plus de 50 lignes au total:
```
⚠️ Fix de haute complexité détecté
Fichiers: N  |  Lignes estimées: ~N
Recommande une revue après application. Procéder avec prudence extrême.
```

---

### Phase 2 — Dry Run (automatique — gate de permission unique)

Sans modifier aucun fichier, montrer les changements exacts proposés.

```
## Dry Run — Changements Proposés

### Changement 1: [Titre descriptif]
Fichier:      chemin/vers/fichier.ext
Localisation: Ligne N  |  fonction: nom()  |  classe: NomClasse

Avant:
[code original exact]

Après:
[code corrigé proposé]

Pourquoi: [une phrase — le raisonnement derrière ce changement spécifique]
```

Répéter pour chaque changement. Si l'avertissement de complexité a été déclenché en Phase 1, le répéter ici.

Puis demander: **"Appliquer ces changements?"**

Ne rien écrire dans aucun fichier jusqu'à confirmation du fondateur.

---

### Phase 3 — Application

Une fois confirmé, exécuter dans cet ordre — aucune déviation:

1. **Vérifier le scope** avant de toucher quoi que ce soit. Vérifier que chaque fichier à modifier était listé dans le Rapport d'Analyse de la Phase 1. Si le fix requiert de toucher un fichier absent de cette liste — s'arrêter immédiatement. Énoncer quel fichier est nécessaire, quel rôle il joue, et pourquoi il ne peut pas être évité. Attendre la permission explicite du fondateur avant de continuer.

2. **Sauvegarder chaque fichier** qui sera modifié:
   ```
   .fix-backups/<timestamp-ISO-8601>/<nom-fichier-original>
   ```
   Le backup doit être écrit avant qu'un fichier soit ouvert pour édition.

3. **Appliquer les changements** exactement comme montré dans le dry run. Ne pas dévier de ce qui a été prévisualisé.

4. **Auditer** — diff chaque fichier modifié contre son backup. Classifier chaque ligne changée:
   - **Intentionnel** — directement requis par le fix
   - **Incident** — effet secondaire inévitable (ex: whitespace forcé par l'éditeur)
   - **Accidentel** — dérive non intentionnelle — revenir immédiatement avant de continuer

5. Revenir sur tous les changements Accidentels. Si un changement Incident ne peut pas être évité, le documenter. Si quoi que ce soit pendant l'application a divergé de l'aperçu dry run, noter la divergence explicitement.

---

### Phase 4 — Boucle de Fix (autonome — pas de permission nécessaire)

Après application, re-scanner tous les fichiers modifiés et leurs dépendants directs pour les erreurs introduites par le fix actuel (erreurs de compilation, imports cassés, échecs de tests, erreurs de types).

- **Si nouvelles erreurs trouvées:** appliquer le fix minimal, auditer, re-scanner. Répéter jusqu'à propre. Chaque itération rapportée dans le rapport final.
- **Si pas de nouvelles erreurs:** procéder à la Phase 5.

La boucle est autonome parce que le fondateur a déjà autorisé le fix en Phase 2. Cependant, chaque itération doit apparaître dans la section Fix Loop du rapport.

**Si la boucle dépasse 5 itérations sans converger — s'arrêter.** Rapporter la situation plutôt que de continuer aveuglément.

**Contrainte de scope:** La boucle corrige uniquement les erreurs introduites par cette session de fix. Les bugs préexistants non liés sont rapportés, pas corrigés silencieusement.

**Gate fichier hors scope:** La même règle de la Phase 3 s'applique. Si résoudre une erreur de boucle requiert de toucher un fichier absent du Rapport d'Analyse de la Phase 1 — arrêter la boucle. Énoncer quel fichier, pourquoi il est nécessaire. Attendre permission explicite. L'autonomie de la boucle couvre uniquement les fichiers in-scope.

---

### Phase 5 — Rapport

Produire le Rapport Final de Fix. Le résumé en français simple apparaît toujours en premier.

Après présentation du rapport, **ajouter le rapport complet à `docs/REPORT.md`**:
- Si `REPORT.md` n'existe pas, le créer
- Séparer chaque entrée avec un header timestamp:
  ```
  ---
  ## Session de Fix — [timestamp ISO-8601]
  ```
- Écrire le contenu complet du rapport sous le header — ne jamais résumer ou tronquer
- Ce fichier accumule chaque fix et session de build comme piste d'audit permanente
- Ajouter même quand le fix avait une faible confiance ou n'a pas abouti — le log doit être honnête, pas curé

**Format du Rapport:**
```
## Rapport de Fix

### Résumé
[Ligne 1: Ce qui était cassé — français simple, pas de jargon]
[Ligne 2: Ce qui a été changé — ce qui a été fait spécifiquement]
[Ligne 3: État actuel — propre, ou test manuel recommandé?]

---

### Détails

**Problème:** [Une phrase — ce qui est cassé et comment ça se manifeste]
**Cause Racine:** [Une phrase — le défaut sous-jacent]
**Scope:** [N fichier(s) modifié(s), ~N lignes changées]

---

#### Fix 1: [Titre descriptif]

Fichier:      chemin/vers/fichier.ext
Localisation: Ligne N  |  fonction: nom()  |  classe: NomClasse

**Avant:**
[code original — exact, non modifié]

**Après:**
[code corrigé]

**Pourquoi:** [Expliquer le raisonnement — pourquoi ce changement, pourquoi pas une alternative]

---

#### Fix 2 (si applicable)
[Répéter bloc Fix 1]

---

### Changements Non Intentionnels

- [Chaque ligne touchée non requise — fichier + numéro de ligne + ce qui a changé]
- — OU — Aucun

**Statut de restauration:**
- ✅ Tous les changements non intentionnels revertés et vérifiés
- ⚠️ Action manuelle nécessaire — [expliquer]

---

### Boucle de Fix

[Pour chaque itération:]
**Itération N:** [Titre court]
- Erreur trouvée: [description]
- Fix appliqué: [ce qui a changé, fichier, ligne]
- Résultat re-scan: ✅ Propre / ⚠️ Autres erreurs (voir Itération N+1)

— OU — Aucune erreur secondaire trouvée. Boucle terminée après 1 passage.

---

### Confiance

| Niveau | Critères |
|--------|---------|
| ✅ Élevé   | Fix testé de bout en bout; comportement vérifié; pas de cas limites non résolus |
| ⚠️ Moyen  | Fix appliqué et logiquement solide; test manuel recommandé |
| ❌ Faible  | Fix incertain ou partiel; réviser avant de merger |

**Ce fix:** [Niveau] — [Une phrase d'explication]

---

### Backup

.fix-backups/[timestamp]/
```

---

## 🤖 Bugs Spécifiques à l'Agent IA

> Ces règles s'appliquent EN PLUS du protocole standard quand le bug est dans l'agent IA.

**Avant de toucher quoi que ce soit, vérifier dans cet ordre:**

1. **Logs backend** — `backend/src/utils/logger.py` — identifier l'erreur exacte
2. **ChromaDB** — le search retourne-t-il des résultats? Tester avec une question simple
3. **Gemini API** — la clé API est-elle valide? Vérifier dans `.env`
4. **System prompt** — `agent/prompts.py` — a-t-il été modifié récemment?
5. **LangGraph graph** — `agent/graph.py` — quel node échoue?

**Règles spéciales pour l'agent:**
- Ne JAMAIS modifier `agent/graph.py` sans backup — c'est le cœur du système
- Ne JAMAIS modifier `agent/prompts.py` sans documenter pourquoi dans `REPORT.md`
- Un bug dans le streaming → vérifier `hooks/useStream.ts` ET `backend/src/routes/chat.py`
- Un bug RAG → vérifier `agent/rag.py` ET l'état de ChromaDB
- Tester l'agent après chaque fix avec les scénarios définis dans `CLAUDE.md`

---

## Règles Absolues

Ces contraintes, pas des préférences. Violer l'une invalide le fix.

1. **Jamais écrire dans un fichier avant que la Phase 2 soit confirmée.** Les Phases 0, 1, et 2 sont entièrement automatiques — lire tout ce qu'il faut, mais ne toucher aucun fichier jusqu'à ce que le fondateur dise "Appliquer."
2. **Jamais dévier du dry run** sans noter la divergence explicitement.
3. **Jamais changer plus que requis.** Les bugs hors scope sont rapportés, pas corrigés silencieusement — sauf dans la boucle Phase 4.
4. **Jamais reformater.** Ne pas ajuster l'indentation, les espaces, ou le style de code sauf si le bug en est directement causé.
5. **Jamais renommer.** Les identifiants, fichiers, et modules ne sont pas renommés. Renommer est un refactor.
6. **Jamais ajouter de features.** Pas de nouvelle logique ou abstractions au-delà de ce qui est strictement requis pour corriger le défaut.
7. **Backup avant édition.** Le backup doit exister avant que le premier fichier soit écrit.
8. **Auditer après application.** Diff contre le backup; classifier chaque ligne changée; revenir sur tous les changements Accidentels avant de rapporter.
9. **Compléter le rapport.** Chaque section est requise. Écrire "Aucun" ou "N/A" — ne pas omettre les headings.
10. **Jamais toucher un fichier hors scope sans permission explicite.** La liste de fichiers de la Phase 1 est un contrat.
11. **Toujours ajouter à `docs/REPORT.md`.** Chaque rapport Phase 5 complété doit être écrit dans `REPORT.md` avant la fin de la session. Pas optionnel.

---

## Notes Agnostiques au Langage

Ce workflow s'applique à tous les langages de programmation: Python (backend/agent), TypeScript (frontend), SQL (migrations), JSON (config). Les cinq phases — confirmer, analyser, prévisualiser, appliquer, boucler — sont invariantes. Utiliser l'identifiant de bloc de code approprié dans les blocs Avant/Après (ex: `py`, `tsx`, `sql`, `json`).

---

*Dernière mise à jour: Mai 2026*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
