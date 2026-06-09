'use client'

import { useLanguage } from '@/context/LanguageContext'

/**
 * Section "Comment ça marche" — détaille le parcours utilisateur en 3 étapes numérotées.
 * Sert d'ancre de navigation ciblée par les liens "Comment ça marche" de la navbar et du héro.
 */
export default function LandingHowItWorks() {
  const { t } = useLanguage()

  const etapes = [
    { numero: '01', titreKey: 'how.step1_title', descKey: 'how.step1_desc' },
    { numero: '02', titreKey: 'how.step2_title', descKey: 'how.step2_desc' },
    { numero: '03', titreKey: 'how.step3_title', descKey: 'how.step3_desc' },
  ]

  return (
    <section id="comment-ca-marche" className="scroll-mt-20 bg-bg-base px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">{t('how.title')}</h2>

        <div className="mt-12 grid gap-8 md:grid-cols-3">
          {etapes.map((etape) => (
            <div key={etape.numero}>
              <span className="text-4xl font-bold text-gold-500">{etape.numero}</span>
              <h3 className="mt-3 text-lg font-semibold text-text-primary">{t(etape.titreKey)}</h3>
              <p className="mt-2 text-sm text-text-secondary">{t(etape.descKey)}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
