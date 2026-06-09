-- ============================================================
-- 002_pgvector.sql — LegalBot DZ — pgvector index ivfflat
-- Extension activée dans 001_init.sql (IF NOT EXISTS = idempotent)
-- ============================================================

CREATE EXTENSION IF NOT EXISTS vector;

-- Index ivfflat — similarité cosinus pour le RAG (Gemini Embeddings 768d)
-- lists = 100 : recommandé pour 10k–100k vecteurs (lois algériennes)
-- Le planner utilise cet index uniquement si la table contient >= 10 lignes
CREATE INDEX IF NOT EXISTS idx_lois_embedding_ivfflat
  ON lois_algeriennes
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

-- Index classiques pour les filtres fréquents dans les requêtes RAG
CREATE INDEX IF NOT EXISTS idx_lois_code_juridique
  ON lois_algeriennes (code_juridique_id);

CREATE INDEX IF NOT EXISTS idx_lois_statut
  ON lois_algeriennes (statut);

CREATE INDEX IF NOT EXISTS idx_lois_categories
  ON lois_algeriennes USING gin (categories_metier);
