/**
 * Section "Pour les citoyens et les professionnels" — compare les fonctionnalités par profil utilisateur.
 * Sert d'ancre de navigation ciblée par le lien "Fonctionnalités" de la navbar.
 */
export default function LandingFeatures() {
  const fonctionnalitesCitoyen = [
    'Chat IA multilingue',
    'Génération de documents',
    "Suggestion d'avocats",
    'Historique des conversations',
  ]

  const fonctionnalitesAvocat = [
    'Gestion de dossiers',
    'Génération de requêtes IA',
    "Rappels d'audiences",
    'Tableau de bord',
  ]

  return (
    <section id="fonctionnalites" className="scroll-mt-20 bg-bg-sidebar px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">
          Pour les citoyens et les professionnels
        </h2>

        <div className="mt-12 grid gap-6 md:grid-cols-2">
          <div className="rounded-xl border border-border-base bg-bg-card p-8 shadow-card">
            <span className="text-3xl" aria-hidden>👤</span>
            <h3 className="mt-3 text-lg font-semibold text-text-primary">Citoyen</h3>
            <ul className="mt-4 space-y-3">
              {fonctionnalitesCitoyen.map((fonctionnalite) => (
                <li key={fonctionnalite} className="flex items-center gap-2 text-sm text-text-secondary">
                  <span className="h-1.5 w-1.5 rounded-full bg-gold-500" aria-hidden />
                  {fonctionnalite}
                </li>
              ))}
            </ul>
          </div>

          <div className="rounded-xl border border-border-base bg-bg-card p-8 shadow-card">
            <span className="text-3xl" aria-hidden>⚖️</span>
            <h3 className="mt-3 text-lg font-semibold text-text-primary">Avocat</h3>
            <ul className="mt-4 space-y-3">
              {fonctionnalitesAvocat.map((fonctionnalite) => (
                <li key={fonctionnalite} className="flex items-center gap-2 text-sm text-text-secondary">
                  <span className="h-1.5 w-1.5 rounded-full bg-gold-500" aria-hidden />
                  {fonctionnalite}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </section>
  )
}
