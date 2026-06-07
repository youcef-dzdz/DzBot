/**
 * Section "Comment ça marche" — détaille le parcours utilisateur en 3 étapes numérotées.
 * Sert d'ancre de navigation ciblée par les liens "Comment ça marche" de la navbar et du héro.
 */
export default function LandingHowItWorks() {
  const etapes = [
    {
      numero: '01',
      titre: 'Posez votre question',
      description: 'En français, arabe ou darija — LegalBot comprend toutes les langues.',
    },
    {
      numero: '02',
      titre: "L'IA analyse et cherche",
      description: 'Notre agent consulte les lois algériennes et trouve les articles pertinents.',
    },
    {
      numero: '03',
      titre: 'Recevez votre réponse',
      description: 'Une réponse claire avec les sources juridiques citées et un avertissement de responsabilité.',
    },
  ]

  return (
    <section id="comment-ca-marche" className="scroll-mt-20 bg-bg-base px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">Simple, rapide, fiable</h2>

        <div className="mt-12 grid gap-8 md:grid-cols-3">
          {etapes.map((etape) => (
            <div key={etape.numero}>
              <span className="text-4xl font-bold text-gold-500">{etape.numero}</span>
              <h3 className="mt-3 text-lg font-semibold text-text-primary">{etape.titre}</h3>
              <p className="mt-2 text-sm text-text-secondary">{etape.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
