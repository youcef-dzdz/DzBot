-- ============================================================
-- 001_init.sql — LegalBot DZ — Initialisation des tables
-- 39 tables dans l'ordre des dépendances FK
-- Schema exact : LegalBot_DZ_Schema_FR.docx
-- ============================================================

-- pgvector requis pour lois_algeriennes.embedding
CREATE EXTENSION IF NOT EXISTS vector;

-- ============================================================
-- TYPES ENUM
-- ============================================================

CREATE TYPE role_enum               AS ENUM ('citoyen', 'avocat', 'notaire', 'admin');
CREATE TYPE langue_enum             AS ENUM ('fr', 'ar', 'en', 'darija');
CREATE TYPE langue_doc_enum         AS ENUM ('ar', 'fr', 'en');
CREATE TYPE statut_loi_enum         AS ENUM ('actif', 'modifie', 'abroge');
CREATE TYPE categorie_metier_enum   AS ENUM ('citoyen', 'avocat', 'notaire', 'tous');
CREATE TYPE type_source_enum        AS ENUM ('officiel', 'non_officiel');
CREATE TYPE statut_source_enum      AS ENUM ('actif', 'inactif');
CREATE TYPE role_message_enum       AS ENUM ('user', 'assistant');
CREATE TYPE statut_avocat_enum      AS ENUM ('actif', 'stagiaire', 'suspendu');
CREATE TYPE statut_rdv_enum         AS ENUM ('en_attente', 'confirme', 'annule');
CREATE TYPE juridiction_type_enum   AS ENUM ('tribunal', 'conseil', 'administratif');
CREATE TYPE statut_dossier_avocat_enum   AS ENUM ('actif', 'en_attente', 'cloture');
CREATE TYPE role_partie_enum        AS ENUM ('demandeur', 'defendeur', 'avocat_adverse', 'temoin');
CREATE TYPE statut_audience_enum    AS ENUM ('programmee', 'tenue', 'reportee', 'annulee');
CREATE TYPE juridiction_acte_enum   AS ENUM ('tribunal', 'conseil', 'cour_supreme');
CREATE TYPE statut_acte_avocat_enum AS ENUM ('brouillon', 'valide', 'envoye');
CREATE TYPE statut_fiche_enum       AS ENUM ('envoye', 'vu', 'accepte', 'refuse');
CREATE TYPE statut_notaire_enum     AS ENUM ('actif', 'suspendu', 'inactif');
CREATE TYPE statut_dossier_notaire_enum  AS ENUM ('en_cours', 'finalise', 'archive');
CREATE TYPE role_partie_acte_enum   AS ENUM ('vendeur', 'acheteur', 'temoin', 'traducteur');
CREATE TYPE statut_acte_notaire_enum AS ENUM ('brouillon', 'signe', 'enregistre');
CREATE TYPE role_demande_enum       AS ENUM ('avocat', 'notaire');
CREATE TYPE statut_inscription_enum AS ENUM ('en_attente', 'accepte', 'refuse');
CREATE TYPE type_abonnement_enum    AS ENUM ('gratuit', 'premium', 'pro');
CREATE TYPE statut_abonnement_enum  AS ENUM ('actif', 'expire', 'annule');
CREATE TYPE mode_paiement_enum      AS ENUM ('gratuit', 'dahabia', 'cib', 'virement');
CREATE TYPE type_changement_enum    AS ENUM ('nouveau', 'modification', 'abrogation');
CREATE TYPE statut_alerte_enum      AS ENUM ('a_traiter', 'traite');
CREATE TYPE statut_signalement_enum AS ENUM ('ouvert', 'en_traitement', 'resolu');

-- ============================================================
-- TIER 1 — Tables sans dépendances FK
-- ============================================================

-- Tribunaux algériens — 58 wilayas × types
CREATE TABLE juridictions (
  id        SERIAL PRIMARY KEY,
  nom       TEXT NOT NULL,
  type      juridiction_type_enum NOT NULL,
  wilaya    TEXT NOT NULL,
  ville     TEXT NOT NULL,
  latitude  FLOAT,
  longitude FLOAT
);

-- Codes juridiques algériens (Code Civil, Code Pénal...)
CREATE TABLE codes_juridiques (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom              TEXT NOT NULL,
  domaine          TEXT NOT NULL,
  url_ministere    TEXT,
  url_joradp       TEXT,
  date_mise_a_jour DATE
);

-- Sources des lois — gérées par l'Admin
CREATE TABLE sources_juridiques (
  id                         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom                        TEXT NOT NULL,
  url                        TEXT NOT NULL,
  type_source                type_source_enum NOT NULL,
  statut                     statut_source_enum NOT NULL DEFAULT 'actif',
  date_derniere_verification DATE
);

-- Modèles de documents pour le citoyen — gérés par Admin
CREATE TABLE templates_documents (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom                TEXT NOT NULL,
  type_document      TEXT NOT NULL,
  contenu_template   TEXT NOT NULL,
  variables_requises JSONB,
  wilaya_applicable  TEXT,
  langue             langue_doc_enum NOT NULL,
  actif              BOOLEAN NOT NULL DEFAULT true
);

-- Modèles d'actes notariaux — gérés par Admin
CREATE TABLE modeles_actes_notaire (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom                TEXT NOT NULL,
  type_acte          TEXT NOT NULL,
  contenu_template   TEXT NOT NULL,
  variables_requises JSONB,
  version            INT NOT NULL DEFAULT 1,
  actif              BOOLEAN NOT NULL DEFAULT true
);

-- Alertes de modification des lois depuis les sources externes
CREATE TABLE alertes_admin (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source          TEXT NOT NULL,
  type_changement type_changement_enum NOT NULL,
  details         TEXT,
  statut          statut_alerte_enum NOT NULL DEFAULT 'a_traiter',
  detected_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Statistiques journalières et mensuelles de la plateforme
CREATE TABLE statistiques (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date                 DATE NOT NULL UNIQUE,
  nb_conversations     INT NOT NULL DEFAULT 0,
  nb_documents_generes INT NOT NULL DEFAULT 0,
  nb_nouveaux_users    INT NOT NULL DEFAULT 0,
  nb_abonnements       INT NOT NULL DEFAULT 0,
  top_lois             JSONB,
  top_templates        JSONB
);

-- Paramètres de la plateforme — modifiables par l'Admin sans code
CREATE TABLE parametres_systeme (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cle         TEXT NOT NULL UNIQUE,
  valeur      TEXT NOT NULL,
  description TEXT,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- TIER 2 — Dépend de juridictions / codes_juridiques / sources_juridiques
-- ============================================================

-- Identité de l'utilisateur — partagée entre tous les rôles
CREATE TABLE users (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clerk_id        TEXT NOT NULL UNIQUE,
  email           TEXT NOT NULL,
  role            role_enum NOT NULL DEFAULT 'citoyen',
  nom             TEXT,
  langue_preferee langue_enum NOT NULL DEFAULT 'fr',
  wilaya_id       INT REFERENCES juridictions(id) ON DELETE SET NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Lois algériennes indexées pour le RAG — vector(768) Gemini Embedding
CREATE TABLE lois_algeriennes (
  id                         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code_juridique_id          UUID NOT NULL REFERENCES codes_juridiques(id) ON DELETE CASCADE,
  source_id                  UUID NOT NULL REFERENCES sources_juridiques(id) ON DELETE CASCADE,
  article                    TEXT NOT NULL,
  contenu                    TEXT NOT NULL,
  embedding                  vector(768),
  url_article                TEXT,
  statut                     statut_loi_enum NOT NULL DEFAULT 'actif',
  categories_metier          categorie_metier_enum[],
  date_derniere_verification DATE
);

-- ============================================================
-- TIER 3 — Dépend de users
-- ============================================================

-- Sessions de conversation avec l'IA
CREATE TABLE conversations (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  titre              TEXT,
  disclaimer_affiche BOOLEAN NOT NULL DEFAULT false,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Données professionnelles des avocats
CREATE TABLE profils_avocats (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  numero_barreau TEXT NOT NULL,
  specialite     TEXT,
  wilaya_id      INT REFERENCES juridictions(id) ON DELETE SET NULL,
  statut         statut_avocat_enum NOT NULL DEFAULT 'actif',
  whatsapp       TEXT,
  email_pro      TEXT
);

-- Données professionnelles des notaires
CREATE TABLE profils_notaires (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  numero_nomination TEXT NOT NULL,
  wilaya_id         INT REFERENCES juridictions(id) ON DELETE SET NULL,
  date_serment      DATE,
  statut            statut_notaire_enum NOT NULL DEFAULT 'actif',
  whatsapp          TEXT,
  email_pro         TEXT
);

-- Notifications internes à la plateforme
CREATE TABLE notifications (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type       TEXT NOT NULL,
  contenu    TEXT NOT NULL,
  lu         BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Abonnements des utilisateurs
CREATE TABLE abonnements (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type_abonnement type_abonnement_enum NOT NULL DEFAULT 'gratuit',
  date_debut      DATE NOT NULL,
  date_fin        DATE,
  statut          statut_abonnement_enum NOT NULL DEFAULT 'actif',
  mode_paiement   mode_paiement_enum NOT NULL DEFAULT 'gratuit'
);

-- Demandes d'inscription des avocats et notaires
CREATE TABLE demandes_inscription (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role_demande       role_demande_enum NOT NULL,
  numero_inscription TEXT NOT NULL,
  url_document       TEXT NOT NULL,
  statut             statut_inscription_enum NOT NULL DEFAULT 'en_attente',
  motif_refus        TEXT,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  traite_at          TIMESTAMPTZ
);

-- Signalements des utilisateurs
CREATE TABLE signalements (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  signale_par      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type_signalement TEXT NOT NULL,
  details          TEXT,
  statut           statut_signalement_enum NOT NULL DEFAULT 'ouvert',
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Documents juridiques générés pour le citoyen
CREATE TABLE documents_generes (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  template_id       UUID NOT NULL REFERENCES templates_documents(id) ON DELETE RESTRICT,
  type_document     TEXT NOT NULL,
  variables_saisies JSONB,
  url_pdf           TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Dossiers des affaires des avocats
CREATE TABLE dossiers (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  avocat_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  client_nom     TEXT NOT NULL,
  type_cas       TEXT NOT NULL,
  juridiction_id INT REFERENCES juridictions(id) ON DELETE SET NULL,
  statut         statut_dossier_avocat_enum NOT NULL DEFAULT 'actif',
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Dossiers des opérations notariales
CREATE TABLE dossiers_notaire (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notaire_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type_operation TEXT NOT NULL,
  statut         statut_dossier_notaire_enum NOT NULL DEFAULT 'en_cours',
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Modèles de requêtes pour avocats (avocat_id NULL = modèle public Admin)
CREATE TABLE modeles_actes (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  avocat_id          UUID REFERENCES users(id) ON DELETE SET NULL,
  nom                TEXT NOT NULL,
  type_acte          TEXT NOT NULL,
  juridiction_type   juridiction_acte_enum,
  contenu_template   TEXT NOT NULL,
  variables_requises JSONB,
  version            INT NOT NULL DEFAULT 1,
  source_url         TEXT,
  actif              BOOLEAN NOT NULL DEFAULT true
);

-- ============================================================
-- TIER 4 — Dépend de conversations, dossiers, dossiers_notaire
-- ============================================================

-- Messages dans chaque conversation
CREATE TABLE messages (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  role            role_message_enum NOT NULL,
  contenu         TEXT NOT NULL,
  sources         JSONB,
  langue_detectee langue_enum,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Historique des suggestions d'avocats — équité (تكافؤ الفرص)
CREATE TABLE suggestions_avocats (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  citoyen_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  avocat_id  UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type_cas   TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Demandes de rendez-vous avec avocats ou notaires
CREATE TABLE rendez_vous (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  citoyen_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  professionnel_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date_proposee    TIMESTAMPTZ NOT NULL,
  statut           statut_rdv_enum NOT NULL DEFAULT 'en_attente',
  notes            TEXT
);

-- Rappels automatiques (avocat)
CREATE TABLE rappels (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  dossier_id  UUID REFERENCES dossiers(id) ON DELETE SET NULL,
  type        TEXT NOT NULL,
  message     TEXT NOT NULL,
  date_rappel TIMESTAMPTZ NOT NULL,
  envoye      BOOLEAN NOT NULL DEFAULT false
);

-- Parties de chaque dossier
CREATE TABLE parties_dossier (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id UUID NOT NULL REFERENCES dossiers(id) ON DELETE CASCADE,
  nom        TEXT NOT NULL,
  role       role_partie_enum NOT NULL,
  contact    TEXT
);

-- Audiences de chaque dossier
CREATE TABLE audiences (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id         UUID NOT NULL REFERENCES dossiers(id) ON DELETE CASCADE,
  date_audience      TIMESTAMPTZ NOT NULL,
  chambre            TEXT,
  notes              TEXT,
  historique_renvois JSONB,
  statut             statut_audience_enum NOT NULL DEFAULT 'programmee'
);

-- Documents uploadés pour chaque dossier avocat
CREATE TABLE documents_dossier (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id    UUID NOT NULL REFERENCES dossiers(id) ON DELETE CASCADE,
  nom_fichier   TEXT NOT NULL,
  url_storage   TEXT NOT NULL,
  resume_ia     TEXT,
  type_document TEXT,
  uploaded_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Notes privées de l'avocat sur chaque dossier
CREATE TABLE notes_dossier (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id UUID NOT NULL REFERENCES dossiers(id) ON DELETE CASCADE,
  contenu    TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Fiche client générée depuis la conversation citoyen → transmise à l'avocat
CREATE TABLE fiches_transmission (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id  UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  avocat_id        UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  resume_situation TEXT,
  lois_applicables JSONB,
  type_procedure   TEXT,
  statut           statut_fiche_enum NOT NULL DEFAULT 'envoye',
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Requêtes générées par l'IA pour l'avocat
CREATE TABLE actes_generes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_id    UUID NOT NULL REFERENCES dossiers(id) ON DELETE CASCADE,
  modele_id     UUID REFERENCES modeles_actes(id) ON DELETE SET NULL,
  contenu_final TEXT NOT NULL,
  lois_citees   JSONB,
  url_pdf       TEXT,
  statut        statut_acte_avocat_enum NOT NULL DEFAULT 'brouillon',
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Parties de chaque acte notarial
CREATE TABLE parties_acte (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  nom                TEXT NOT NULL,
  role               role_partie_acte_enum NOT NULL,
  date_naissance     DATE,
  lieu_naissance     TEXT,
  nationalite        TEXT
);

-- Actes notariaux officiels
CREATE TABLE actes_notaries (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  numero_repertoire  TEXT NOT NULL,
  type_acte          TEXT NOT NULL,
  contenu            TEXT NOT NULL,
  date_signature     DATE,
  statut             statut_acte_notaire_enum NOT NULL DEFAULT 'brouillon',
  url_pdf            TEXT
);

-- Brouillons d'actes générés par l'IA pour le notaire
CREATE TABLE actes_generes_notaire (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  modele_id          UUID REFERENCES modeles_actes_notaire(id) ON DELETE SET NULL,
  contenu_brouillon  TEXT NOT NULL,
  lois_citees        JSONB,
  valide_par_notaire BOOLEAN NOT NULL DEFAULT false,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Documents uploadés pour chaque dossier notarial
CREATE TABLE documents_dossier_notaire (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  nom_fichier        TEXT NOT NULL,
  url_storage        TEXT NOT NULL,
  type_document      TEXT,
  resume_ia          TEXT,
  uploaded_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Biens immobiliers concernés par les opérations notariales
CREATE TABLE biens_immobiliers (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  numero_cadastral   TEXT,
  wilaya             TEXT NOT NULL,
  commune            TEXT NOT NULL,
  superficie         FLOAT,
  valeur             BIGINT,
  type_bien          TEXT NOT NULL
);

-- Notes privées du notaire sur chaque dossier
CREATE TABLE notes_dossier_notaire (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  dossier_notaire_id UUID NOT NULL REFERENCES dossiers_notaire(id) ON DELETE CASCADE,
  contenu            TEXT NOT NULL,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Rappels automatiques pour le notaire
CREATE TABLE rappels_notaire (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notaire_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  dossier_notaire_id UUID REFERENCES dossiers_notaire(id) ON DELETE SET NULL,
  type               TEXT NOT NULL,
  message            TEXT NOT NULL,
  date_rappel        TIMESTAMPTZ NOT NULL,
  envoye             BOOLEAN NOT NULL DEFAULT false
);

-- ============================================================
-- TIER 5 — Dépend de messages
-- ============================================================

-- Évaluation des réponses de l'IA — post-graduation
CREATE TABLE avis_reponses (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id  UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  note        BOOLEAN NOT NULL,
  commentaire TEXT
);
