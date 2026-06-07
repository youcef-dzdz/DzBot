# uidesign.md — Système de Design UI — LegalBot DZ
> **Source de vérité absolue pour toute décision visuelle du projet.**
> Règle #8 de CLAUDE.md : aucune couleur, espacement ou ombre ne peut être hardcodé sans être listé ici.
> Toute valeur non listée = interdite. Toute nouvelle valeur = ajoutée ici AVANT d'être utilisée.

Dernière mise à jour: 2026-06-07
Palette validée par le fondateur: **Espresso + Crème Claude + Or**

---

## 1. 🎨 Philosophie Design

**Inspiration:** Anthropic / Claude.ai — chaud, humain, professionnel, optimiste.
**Direction:** Sobre, aéré, premium. Jamais froid, jamais sombre, jamais générique.
**Mots clés:** Chaleureux · Juridique · Algérien · Friendly · Premium · Accessible

**Ce qu'on évite absolument:**
- Bleu marine froid
- Noir pur agressif
- Gris froids génériques
- Dégradés et ombres lourdes
- Aspect "AI généré / PowerPoint"

---

## 2. 🖼️ Logo — LegalBot DZ

### Fichiers logo
```
frontend/public/
├── logo.png           ← Logo complet (Thémis + "LegalBot DZ") — usage général
├── logo-dark.png      ← Version inversée pour fond sombre (footer, slides)
└── favicon.ico        ← Silhouette Thémis seule, rognée carré 32×32
```

### Description du logo validé
- **Icône:** Silhouette Thémis (déesse de la justice) — espresso `#3B1E03`
- **Balance:** Or `#C4902A` — tenue dans la main droite levée
- **Épée:** Or `#C4902A` — tenue dans la main gauche abaissée
- **Bandeau:** Yeux bandés — impartialité
- **Wordmark:** "LegalBot" en espresso bold + "DZ" en or `#C4902A`
- **Fond:** Crème `#FAF9F7`

### Usage dans le code
```tsx
// Navigation — logo complet
<Image src="/logo.png" alt="LegalBot DZ" width={160} height={48} />

// Favicon — dans layout.tsx
<link rel="icon" href="/favicon.ico" />

// Footer fond sombre
<Image src="/logo-dark.png" alt="LegalBot DZ" width={140} height={42} />
```

### Règles logo
- Jamais déformer les proportions
- Espace minimum autour = 16px de chaque côté
- Fond clair/blanc → `logo.png`
- Fond espresso/sombre → `logo-dark.png`
- Taille minimum affichage = 120px de large

---

## 3. 🎨 Palette de Couleurs

### Couleur Principale — Espresso `#3B1E03`

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `primary-50` | `#F0E8DF` | `primary-50` | Fond hover, badges, fond cartes IA |
| `primary-100` | `#E4D5C3` | `primary-100` | Bordures actives légères |
| `primary-200` | `#D9C9B8` | `primary-200` | Bordures badges |
| `primary-600` | `#5C3208` | `primary-600` | Hover bouton principal |
| `primary-700` | `#3B1E03` | `primary-700` | **Couleur principale — boutons, liens, accents** |
| `primary-900` | `#2A1402` | `primary-900` | Pressed state |

### Accent Or — `#C4902A`

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `gold-50` | `#FBF4E4` | `gold-50` | Fond badge or léger |
| `gold-200` | `#EDD49A` | `gold-200` | Bordure or légère |
| `gold-400` | `#D4A843` | `gold-400` | Hover état or |
| `gold-500` | `#C4902A` | `gold-500` | **Accent or — "DZ", citations lois, éléments premium** |
| `gold-700` | `#9B7020` | `gold-700` | Or foncé sur fond clair |

### Fond & Surface — Crème Chaud

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `bg-base` | `#FAF9F7` | `bg-base` | **Fond de toutes les pages** |
| `bg-sidebar` | `#F2EDE6` | `bg-sidebar` | **Fond sidebar, panneaux secondaires** |
| `bg-card` | `#FFFFFF` | `bg-card` | Fond cartes, modals, inputs |
| `bg-hover` | `#F7F3EE` | `bg-hover` | Hover items liste |
| `bg-active` | `#F0E8DF` | `bg-active` | Item sélectionné sidebar/liste |

### Bulles de Chat

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `bubble-user` | `#EDE8DF` | `bubble-user` | **Bulle message utilisateur** |
| `bubble-user-border` | `#DDD7CC` | `bubble-user-border` | Bordure bulle utilisateur |
| `bubble-bot` | `#FFFFFF` | `bubble-bot` | Bulle message agent IA |
| `bubble-bot-border` | `#E8E3DC` | `bubble-bot-border` | Bordure bulle agent |

### Texte

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `text-primary` | `#1A1A1A` | `text-primary` | **Texte principal** |
| `text-secondary` | `#6B6660` | `text-secondary` | Sous-titres, descriptions |
| `text-muted` | `#9A9490` | `text-muted` | Timestamps, placeholders |
| `text-placeholder` | `#C9C3BB` | `text-placeholder` | Placeholder inputs |
| `text-on-primary` | `#FAF9F7` | `text-on-primary` | Texte sur fond espresso |
| `text-link` | `#3B1E03` | `text-link` | Liens cliquables |
| `text-gold` | `#C4902A` | `text-gold` | "DZ", citations, accents or |

### Bordures

| Token | HEX | Tailwind | Usage |
|-------|-----|----------|-------|
| `border-base` | `#E8E3DC` | `border-base` | **Bordure standard** |
| `border-light` | `#F2EDE6` | `border-light` | Séparateurs légers |
| `border-active` | `#D9C9B8` | `border-active` | Éléments actifs/focus |

### Couleurs Sémantiques

| Token | HEX | Usage |
|-------|-----|-------|
| `success-bg` | `#D1FAF0` | Badge succès fond |
| `success-text` | `#047857` | Badge succès texte |
| `success-main` | `#2A7A4B` | Boutons verts, tendances positives |
| `warning-bg` | `#FEF3E2` | Badge avertissement fond |
| `warning-text` | `#B45309` | Badge avertissement texte |
| `error-bg` | `#FEE2E2` | Badge erreur fond |
| `error-text` | `#B91C1C` | Badge erreur texte |
| `info-bg` | `#F0E8DF` | Fond source tag loi |
| `info-text` | `#3B1E03` | Texte source tag loi |
| `info-border` | `#D9C9B8` | Bordure source tag |
| `disclaimer-bg` | `#FFFBEB` | Fond disclaimer juridique |
| `disclaimer-border` | `#FCD34D` | Bordure disclaimer |
| `disclaimer-text` | `#92400E` | Texte disclaimer |

---

## 4. 🔤 Typographie

### Polices

| Contexte | Police | Fallback |
|----------|--------|----------|
| Latin (fr/en) | `Inter` | `system-ui, -apple-system, sans-serif` |
| Arabe RTL | `Noto Sans Arabic` | `'Segoe UI', Arial, sans-serif` |

```html
<!-- frontend/src/app/layout.tsx -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link
  href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Noto+Sans+Arabic:wght@400;500;600;700&display=swap"
  rel="stylesheet"
/>
```

### Échelle Typographique

| Token | Taille | Poids | Line-height | Usage |
|-------|--------|-------|-------------|-------|
| `text-hero` | `48px` | `700` | `1.15` | Titre principal hero landing (`LandingHero.tsx`) |
| `text-display` | `36px` | `700` | `1.2` | Hero title landing |
| `text-h1` | `28px` | `700` | `1.25` | Titre page principale |
| `text-h2` | `22px` | `700` | `1.3` | Section title |
| `text-h3` | `18px` | `600` | `1.35` | Card title, modal title |
| `text-h4` | `15px` | `600` | `1.4` | Sous-section |
| `text-body-lg` | `15px` | `400` | `1.75` | Corps principal |
| `text-body` | `13px` | `400` | `1.65` | Corps standard, bulles chat |
| `text-body-sm` | `12px` | `400` | `1.6` | Descriptions secondaires |
| `text-label` | `12px` | `500` | `1.4` | Labels formulaires |
| `text-caption` | `11px` | `400` | `1.5` | Timestamps, hints |
| `text-micro` | `10px` | `500` | `1.4` | Section labels uppercase |

> ⚠️ **Note:** `tailwind.config.ts` ne définit pas encore les utilitaires `fontSize` correspondant à cette échelle (`text-h1`, `text-display`, etc.). Les composants landing utilisent donc des valeurs arbitraires (`text-[28px]`, `text-[48px]`) qui correspondent aux tokens `text-h1` (28px) et `text-hero` (48px) ci-dessus. À corriger en ajoutant `fontSize` à la config Tailwind pour que les classes nommées soient utilisables directement.

### Règles RTL Arabe

```css
[lang="ar"], .rtl {
  direction: rtl;
  text-align: right;
  font-family: 'Noto Sans Arabic', 'Segoe UI', Arial, sans-serif;
}
.msg.user.rtl .bubble {
  border-radius: 14px 14px 14px 3px; /* inversé vs LTR */
}
```

---

## 5. 📐 Espacement (grille 4px)

| Token | Valeur | Tailwind | Usage |
|-------|--------|----------|-------|
| `space-1` | `4px` | `p-1` | Micro-espacement |
| `space-2` | `8px` | `p-2` | Gap compact |
| `space-3` | `12px` | `p-3` | Padding bouton sm |
| `space-4` | `16px` | `p-4` | Padding card |
| `space-5` | `20px` | `p-5` | Padding section |
| `space-6` | `24px` | `p-6` | Padding page |
| `space-8` | `32px` | `p-8` | Entre sections |
| `space-10` | `40px` | `p-10` | Section mobile |
| `space-14` | `56px` | `p-14` | Hero desktop |

---

## 6. 🔘 Border Radius

| Token | Valeur | Tailwind | Usage |
|-------|--------|----------|-------|
| `radius-sm` | `6px` | `rounded-md` | Badges |
| `radius-md` | `8px` | `rounded-lg` | Boutons, inputs |
| `radius-lg` | `10px` | `rounded-xl` | Cards |
| `radius-xl` | `14px` | `rounded-2xl` | Modals, bulles |
| `radius-full` | `9999px` | `rounded-full` | Pills, avatars |

---

## 7. 🌑 Ombres

| Token | Valeur CSS | Usage |
|-------|-----------|-------|
| `shadow-card` | `0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04)` | Cards repos |
| `shadow-card-hover` | `0 4px 12px rgba(0,0,0,0.08), 0 2px 4px rgba(0,0,0,0.04)` | Cards hover |
| `shadow-modal` | `0 20px 60px rgba(0,0,0,0.12), 0 8px 20px rgba(0,0,0,0.06)` | Modals |
| `shadow-focus` | `0 0 0 3px rgba(59,30,3,0.15)` | Focus ring espresso |

---

## 8. 🧩 Composants

### Boutons
```
primary   → bg #3B1E03, text #FAF9F7, hover #5C3208
secondary → bg #fff, text #1A1A1A, border 0.5px #C9C3BB
ghost     → bg #F0E8DF, text #3B1E03
gold      → bg #C4902A, text #FAF9F7
danger    → bg #FEE2E2, text #B91C1C

sm  → padding 6px 14px,  font 12px, radius 7px
md  → padding 9px 20px,  font 13px, radius 8px  ← défaut
lg  → padding 11px 24px, font 14px, radius 10px
```

### Inputs
```
bg #fff · border 1.5px solid #E8E3DC · radius 10px · padding 8px 12px
placeholder: #C9C3BB
focus: border #3B1E03 + shadow-focus
erreur: border #B91C1C + bg #FFF5F5
```

### Badges
```
font 11px · padding 3px 10px · radius full · font-weight 500
primary → bg #F0E8DF, text #3B1E03, border #D9C9B8
gold    → bg #FBF4E4, text #9B7020, border #EDD49A
success → bg #D1FAF0, text #047857
warning → bg #FEF3E2, text #B45309
error   → bg #FEE2E2, text #B91C1C
neutral → bg #F2EDE6, text #9A9490
```

### Cards
```
bg #fff · border 0.5px solid #E8E3DC · radius 11px
padding 14px 16px · shadow-card · hover: shadow-card-hover
```

### Sidebar
```
bg #F2EDE6 · border-right 0.5px solid #E8E3DC · width 200px

item repos  → font 12px, color #6B6660, padding 8px 14px
item actif  → bg #F0E8DF, color #3B1E03, font-weight 500, border-left 2px solid #3B1E03
section lbl → font 10px, uppercase, letter-spacing 0.08em, color #9A9490
```

### Bulles Chat
```
user → bg #EDE8DF · border 0.5px #DDD7CC · radius 14px 14px 3px 14px · align right
bot  → bg #fff    · border 0.5px #E8E3DC · radius 14px 14px 14px 3px · align left
avatar LB → 24px circle · bg #3B1E03 · text #FAF9F7 · font 10px 500
timestamp  → font 10px · color #C9C3BB · margin-top 3px
```

### Source Tag Loi
```
bg #F0E8DF · color #3B1E03 · border 0.5px #D9C9B8 · radius full
font 11px 500 · padding 3px 9px · inline-flex · gap 4px
```

### Disclaimer Juridique
```
bg #FFFBEB · border 0.5px #FCD34D · radius 8px
padding 7px 10px · font 11px · color #92400E · line-height 1.5
```

### KPI Cards Dashboard
```
bg #fff · border 0.5px #E8E3DC · radius 11px · padding 13px 14px
label  → 11px, #9A9490
value  → 24px, font-weight 500, #1A1A1A
trend+ → 11px, #2A7A4B
trend- → 11px, #B45309
```

---

## 9. 📱 Responsive

| Breakpoint | Largeur | Sidebar |
|-----------|---------|---------|
| mobile | `< 768px` | Bottom nav |
| tablet | `768px–1024px` | Icônes seules 60px |
| desktop | `> 1024px` | Complète 200px |

```
Layout: grid-template-columns: 200px 1fr
Fond global: background #FAF9F7, min-height 100dvh
Chat height: 100dvh
```

---

## 10. 🌙 Dark Mode

Dark mode = **Phase 4 uniquement**. Ne pas implémenter avant.

```css
/* Réservé Phase 4 */
.dark {
  --bg-base: #1C1917;
  --bg-sidebar: #171410;
  --bg-card: #292524;
  --text-primary: #F5F0E8;
  --text-secondary: #A8A29E;
  --border-base: #44403C;
}
```

---

## 11. ⚙️ Tailwind Config

```typescript
// frontend/tailwind.config.ts
import type { Config } from 'tailwindcss'

const config: Config = {
  content: ['./src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#F0E8DF', 100: '#E4D5C3', 200: '#D9C9B8',
          600: '#5C3208', 700: '#3B1E03', 900: '#2A1402',
        },
        gold: {
          50: '#FBF4E4', 200: '#EDD49A', 400: '#D4A843',
          500: '#C4902A', 700: '#9B7020',
        },
        'bg-base':    '#FAF9F7',
        'bg-sidebar': '#F2EDE6',
        'bg-card':    '#FFFFFF',
        'bg-hover':   '#F7F3EE',
        'bg-active':  '#F0E8DF',
        'bubble-user':        '#EDE8DF',
        'bubble-user-border': '#DDD7CC',
        'bubble-bot':         '#FFFFFF',
        'bubble-bot-border':  '#E8E3DC',
        'text-primary':     '#1A1A1A',
        'text-secondary':   '#6B6660',
        'text-muted':       '#9A9490',
        'text-placeholder': '#C9C3BB',
        'text-on-primary':  '#FAF9F7',
        'text-link':        '#3B1E03',
        'text-gold':        '#C4902A',
        'border-base':   '#E8E3DC',
        'border-light':  '#F2EDE6',
        'border-active': '#D9C9B8',
        'success-bg':   '#D1FAF0', 'success-text': '#047857', 'success-main': '#2A7A4B',
        'warning-bg':   '#FEF3E2', 'warning-text': '#B45309',
        'error-bg':     '#FEE2E2', 'error-text':   '#B91C1C',
        'info-bg':      '#F0E8DF', 'info-text':    '#3B1E03', 'info-border': '#D9C9B8',
        'disclaimer-bg':     '#FFFBEB',
        'disclaimer-border': '#FCD34D',
        'disclaimer-text':   '#92400E',
      },
      borderRadius: { 'xl': '14px', '2xl': '18px' },
      boxShadow: {
        'card':       '0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04)',
        'card-hover': '0 4px 12px rgba(0,0,0,0.08), 0 2px 4px rgba(0,0,0,0.04)',
        'modal':      '0 20px 60px rgba(0,0,0,0.12), 0 8px 20px rgba(0,0,0,0.06)',
        'focus':      '0 0 0 3px rgba(59,30,3,0.15)',
      },
      fontFamily: {
        sans:   ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
        arabic: ['Noto Sans Arabic', 'Segoe UI', 'Arial', 'sans-serif'],
      },
    },
  },
  plugins: [],
}

export default config
```

---

## 12. 🗂️ Pages — Référence Rapide

| Page | Route | Fond |
|------|-------|------|
| Landing | `/` | `#FAF9F7` |
| Login / Register | `/login` `/register` | `#F2EDE6` |
| Chat citoyen | `/citoyen/chat` | `#FAF9F7` |
| Historique | `/citoyen/historique` | `#FAF9F7` |
| Profil citoyen | `/citoyen/profil` | `#FAF9F7` |
| Dashboard avocat | `/avocat/dashboard` | `#FAF9F7` |
| Dossiers | `/avocat/dossiers` | `#FAF9F7` |
| Mémoires IA | `/avocat/memoires` | `#FAF9F7` |
| Admin lois | `/admin/lois` | `#FAF9F7` |

---

## 13. ✅ Règles Non Négociables

1. Jamais hardcoder une couleur — uniquement les tokens définis ici
2. Jamais `#000000` pur — utiliser `#1A1A1A`
3. Jamais de gris froids — uniquement les tokens warm
4. Sidebar toujours `#F2EDE6` — jamais blanc pur ni sombre
5. Bulles utilisateur → `#EDE8DF` uniquement — jamais espresso
6. Bouton principal → `#3B1E03` — seul CTA principal
7. "DZ" et accents premium → `#C4902A` uniquement
8. Focus ring → `shadow-focus` — jamais invisible
9. Dark mode → Phase 4 uniquement
10. Arabe → `font-arabic` + `dir="rtl"` sur le conteneur
11. Logo fond clair → `logo.png` / fond sombre → `logo-dark.png`
12. Nouvelle valeur → l'ajouter ici AVANT de l'utiliser

---

*Dernière mise à jour: 2026-06-07*
*Palette validée: Espresso #3B1E03 + Crème #FAF9F7 + Or #C4902A + Beige #F2EDE6*
*Logo validé: Thémis silhouette espresso, balance & épée or, wordmark "LegalBot DZ"*
*Tout agent modifiant ce fichier doit mettre à jour la date ci-dessus.*
