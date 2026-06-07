/**
 * Section "Pourquoi LegalBot DZ ?" — expose les problèmes que la plateforme résout via 3 cartes.
 * Affichée sur fond beige pour créer un contraste avec le héro et les sections voisines.
 */
export default function LandingProblem() {
  const problemes = [
    {
      icone: '⚖️',
      titre: 'Le droit algérien est complexe',
      description: 'Les textes juridiques sont difficiles à comprendre sans formation spécialisée.',
    },
    {
      icone: '💸',
      titre: 'Les consultations coûtent cher',
      description: 'Un rendez-vous chez un avocat représente une barrière pour beaucoup de citoyens.',
    },
    {
      icone: '🕐',
      titre: 'Le temps est précieux',
      description: 'Attendre des semaines pour une réponse juridique peut aggraver votre situation.',
    },
  ]

  return (
    <section className="bg-bg-sidebar px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">Pourquoi LegalBot DZ ?</h2>

        <div className="mt-12 grid gap-6 md:grid-cols-3">
          {problemes.map((probleme) => (
            <div key={probleme.titre} className="rounded-xl border border-border-base bg-bg-card p-6 shadow-card">
              <span className="text-3xl" aria-hidden>{probleme.icone}</span>
              <h3 className="mt-4 text-lg font-semibold text-text-primary">{probleme.titre}</h3>
              <p className="mt-2 text-sm text-text-secondary">{probleme.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
