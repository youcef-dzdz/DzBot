-- ============================================================
-- 003_rls_policies.sql — LegalBot DZ — Row Level Security
-- Prérequis : Supabase configuré pour accepter les JWT Clerk
--   → auth.uid() doit retourner users.id (UUID)
--   → Configurer via : Project Settings > Auth > JWT Secret (Clerk JWKS)
-- ============================================================

-- ============================================================
-- FONCTIONS HELPERS
-- ============================================================

-- Retourne le rôle de l'utilisateur connecté
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS role_enum
LANGUAGE sql STABLE SECURITY DEFINER
AS $$
  SELECT role FROM users WHERE id = auth.uid()
$$;

-- Vérifie si l'utilisateur connecté est admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN
LANGUAGE sql STABLE SECURITY DEFINER
AS $$
  SELECT EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
$$;

-- ============================================================
-- ACTIVATION RLS SUR TOUTES LES TABLES
-- ============================================================

ALTER TABLE users                     ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversations             ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE lois_algeriennes          ENABLE ROW LEVEL SECURITY;
ALTER TABLE codes_juridiques          ENABLE ROW LEVEL SECURITY;
ALTER TABLE sources_juridiques        ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents_generes         ENABLE ROW LEVEL SECURITY;
ALTER TABLE templates_documents       ENABLE ROW LEVEL SECURITY;
ALTER TABLE profils_avocats           ENABLE ROW LEVEL SECURITY;
ALTER TABLE profils_notaires          ENABLE ROW LEVEL SECURITY;
ALTER TABLE suggestions_avocats       ENABLE ROW LEVEL SECURITY;
ALTER TABLE rendez_vous               ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications             ENABLE ROW LEVEL SECURITY;
ALTER TABLE avis_reponses             ENABLE ROW LEVEL SECURITY;
ALTER TABLE juridictions              ENABLE ROW LEVEL SECURITY;
ALTER TABLE dossiers                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE parties_dossier           ENABLE ROW LEVEL SECURITY;
ALTER TABLE audiences                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents_dossier         ENABLE ROW LEVEL SECURITY;
ALTER TABLE modeles_actes             ENABLE ROW LEVEL SECURITY;
ALTER TABLE actes_generes             ENABLE ROW LEVEL SECURITY;
ALTER TABLE fiches_transmission       ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes_dossier             ENABLE ROW LEVEL SECURITY;
ALTER TABLE rappels                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE dossiers_notaire          ENABLE ROW LEVEL SECURITY;
ALTER TABLE parties_acte              ENABLE ROW LEVEL SECURITY;
ALTER TABLE actes_notaries            ENABLE ROW LEVEL SECURITY;
ALTER TABLE modeles_actes_notaire     ENABLE ROW LEVEL SECURITY;
ALTER TABLE actes_generes_notaire     ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents_dossier_notaire ENABLE ROW LEVEL SECURITY;
ALTER TABLE biens_immobiliers         ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes_dossier_notaire     ENABLE ROW LEVEL SECURITY;
ALTER TABLE rappels_notaire           ENABLE ROW LEVEL SECURITY;
ALTER TABLE demandes_inscription      ENABLE ROW LEVEL SECURITY;
ALTER TABLE abonnements               ENABLE ROW LEVEL SECURITY;
ALTER TABLE alertes_admin             ENABLE ROW LEVEL SECURITY;
ALTER TABLE signalements              ENABLE ROW LEVEL SECURITY;
ALTER TABLE statistiques              ENABLE ROW LEVEL SECURITY;
ALTER TABLE parametres_systeme        ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- TABLES PUBLIQUES — lecture sans authentification
-- ============================================================

CREATE POLICY "juridictions_read_public"
  ON juridictions FOR SELECT USING (true);

CREATE POLICY "lois_read_public"
  ON lois_algeriennes FOR SELECT USING (true);

CREATE POLICY "lois_write_admin"
  ON lois_algeriennes FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "codes_juridiques_read_public"
  ON codes_juridiques FOR SELECT USING (true);

CREATE POLICY "codes_juridiques_write_admin"
  ON codes_juridiques FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "sources_juridiques_read_public"
  ON sources_juridiques FOR SELECT USING (true);

CREATE POLICY "sources_juridiques_write_admin"
  ON sources_juridiques FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "templates_documents_read_auth"
  ON templates_documents FOR SELECT
  USING (auth.uid() IS NOT NULL);

CREATE POLICY "templates_documents_write_admin"
  ON templates_documents FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "modeles_actes_notaire_read_auth"
  ON modeles_actes_notaire FOR SELECT
  USING (auth.uid() IS NOT NULL AND get_user_role() IN ('notaire', 'admin'));

CREATE POLICY "modeles_actes_notaire_write_admin"
  ON modeles_actes_notaire FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

-- ============================================================
-- TABLE users
-- ============================================================

CREATE POLICY "users_own"
  ON users FOR ALL
  USING (id = auth.uid()) WITH CHECK (id = auth.uid());

CREATE POLICY "users_admin_all"
  ON users FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

-- Lecture des profils avocats/notaires actifs pour les suggestions
CREATE POLICY "users_pro_read"
  ON users FOR SELECT
  USING (role IN ('avocat', 'notaire') AND auth.uid() IS NOT NULL);

-- ============================================================
-- PORTAIL CITOYEN
-- ============================================================

CREATE POLICY "conversations_own"
  ON conversations FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "messages_own"
  ON messages FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM conversations
      WHERE conversations.id = messages.conversation_id
        AND conversations.user_id = auth.uid()
    )
  );

CREATE POLICY "documents_generes_own"
  ON documents_generes FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "notifications_own"
  ON notifications FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "abonnements_read_own"
  ON abonnements FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "abonnements_admin"
  ON abonnements FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "avis_reponses_own"
  ON avis_reponses FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "rendez_vous_participant"
  ON rendez_vous FOR ALL
  USING (citoyen_id = auth.uid() OR professionnel_id = auth.uid())
  WITH CHECK (citoyen_id = auth.uid() OR professionnel_id = auth.uid());

CREATE POLICY "suggestions_avocats_read"
  ON suggestions_avocats FOR SELECT
  USING (citoyen_id = auth.uid() OR avocat_id = auth.uid());

CREATE POLICY "suggestions_avocats_insert"
  ON suggestions_avocats FOR INSERT
  WITH CHECK (citoyen_id = auth.uid());

-- ============================================================
-- PROFILS PROFESSIONNELS
-- ============================================================

CREATE POLICY "profils_avocats_own"
  ON profils_avocats FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "profils_avocats_read_auth"
  ON profils_avocats FOR SELECT
  USING (auth.uid() IS NOT NULL AND statut = 'actif');

CREATE POLICY "profils_avocats_admin"
  ON profils_avocats FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "profils_notaires_own"
  ON profils_notaires FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "profils_notaires_read_auth"
  ON profils_notaires FOR SELECT
  USING (auth.uid() IS NOT NULL AND statut = 'actif');

CREATE POLICY "profils_notaires_admin"
  ON profils_notaires FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

-- ============================================================
-- PORTAIL AVOCAT
-- ============================================================

CREATE POLICY "dossiers_own_avocat"
  ON dossiers FOR ALL
  USING (avocat_id = auth.uid()) WITH CHECK (avocat_id = auth.uid());

CREATE POLICY "parties_dossier_own_avocat"
  ON parties_dossier FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers
      WHERE dossiers.id = parties_dossier.dossier_id
        AND dossiers.avocat_id = auth.uid()
    )
  );

CREATE POLICY "audiences_own_avocat"
  ON audiences FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers
      WHERE dossiers.id = audiences.dossier_id
        AND dossiers.avocat_id = auth.uid()
    )
  );

CREATE POLICY "documents_dossier_own_avocat"
  ON documents_dossier FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers
      WHERE dossiers.id = documents_dossier.dossier_id
        AND dossiers.avocat_id = auth.uid()
    )
  );

CREATE POLICY "notes_dossier_own_avocat"
  ON notes_dossier FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers
      WHERE dossiers.id = notes_dossier.dossier_id
        AND dossiers.avocat_id = auth.uid()
    )
  );

CREATE POLICY "actes_generes_own_avocat"
  ON actes_generes FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers
      WHERE dossiers.id = actes_generes.dossier_id
        AND dossiers.avocat_id = auth.uid()
    )
  );

-- Modèles publics (avocat_id IS NULL) lisibles par tous les avocats authentifiés
-- Modèles privés visibles uniquement par leur créateur
CREATE POLICY "modeles_actes_read"
  ON modeles_actes FOR SELECT
  USING (avocat_id IS NULL OR avocat_id = auth.uid() OR is_admin());

CREATE POLICY "modeles_actes_insert_own"
  ON modeles_actes FOR INSERT
  WITH CHECK (avocat_id = auth.uid());

CREATE POLICY "modeles_actes_update_own"
  ON modeles_actes FOR UPDATE
  USING (avocat_id = auth.uid() OR is_admin());

CREATE POLICY "modeles_actes_delete_own"
  ON modeles_actes FOR DELETE
  USING (avocat_id = auth.uid() OR is_admin());

CREATE POLICY "fiches_transmission_participant"
  ON fiches_transmission FOR ALL
  USING (
    avocat_id = auth.uid()
    OR EXISTS (
      SELECT 1 FROM conversations
      WHERE conversations.id = fiches_transmission.conversation_id
        AND conversations.user_id = auth.uid()
    )
  );

CREATE POLICY "rappels_own"
  ON rappels FOR ALL
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

-- ============================================================
-- PORTAIL NOTAIRE
-- ============================================================

CREATE POLICY "dossiers_notaire_own"
  ON dossiers_notaire FOR ALL
  USING (notaire_id = auth.uid()) WITH CHECK (notaire_id = auth.uid());

CREATE POLICY "parties_acte_own_notaire"
  ON parties_acte FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = parties_acte.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "actes_notaries_own"
  ON actes_notaries FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = actes_notaries.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "actes_generes_notaire_own"
  ON actes_generes_notaire FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = actes_generes_notaire.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "documents_dossier_notaire_own"
  ON documents_dossier_notaire FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = documents_dossier_notaire.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "biens_immobiliers_own_notaire"
  ON biens_immobiliers FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = biens_immobiliers.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "notes_dossier_notaire_own"
  ON notes_dossier_notaire FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM dossiers_notaire
      WHERE dossiers_notaire.id = notes_dossier_notaire.dossier_notaire_id
        AND dossiers_notaire.notaire_id = auth.uid()
    )
  );

CREATE POLICY "rappels_notaire_own"
  ON rappels_notaire FOR ALL
  USING (notaire_id = auth.uid()) WITH CHECK (notaire_id = auth.uid());

-- ============================================================
-- PORTAIL ADMIN
-- ============================================================

CREATE POLICY "demandes_inscription_read_own"
  ON demandes_inscription FOR SELECT
  USING (user_id = auth.uid() OR is_admin());

CREATE POLICY "demandes_inscription_insert_own"
  ON demandes_inscription FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "demandes_inscription_update_admin"
  ON demandes_inscription FOR UPDATE
  USING (is_admin());

CREATE POLICY "alertes_admin_only"
  ON alertes_admin FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "statistiques_admin_only"
  ON statistiques FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "parametres_systeme_read_auth"
  ON parametres_systeme FOR SELECT
  USING (auth.uid() IS NOT NULL);

CREATE POLICY "parametres_systeme_write_admin"
  ON parametres_systeme FOR ALL
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "signalements_insert_own"
  ON signalements FOR INSERT
  WITH CHECK (signale_par = auth.uid());

CREATE POLICY "signalements_read_own_or_admin"
  ON signalements FOR SELECT
  USING (signale_par = auth.uid() OR is_admin());

CREATE POLICY "signalements_update_admin"
  ON signalements FOR UPDATE
  USING (is_admin());
