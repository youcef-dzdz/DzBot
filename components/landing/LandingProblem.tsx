'use client'

import { useLanguage } from '@/context/LanguageContext'

/**
 * Section "Pourquoi LegalBot DZ ?" — expose les problèmes que la plateforme résout via 3 cartes.
 * Affichée sur fond beige pour créer un contraste avec le héro et les sections voisines.
 */
export default function LandingProblem() {
  const { t } = useLanguage()

  const problemes = [
    { icone: '⚖️', titreKey: 'problem.item1_title', descKey: 'problem.item1_desc' },
    { icone: '💸', titreKey: 'problem.item2_title', descKey: 'problem.item2_desc' },
    { icone: '🕐', titreKey: 'problem.item3_title', descKey: 'problem.item3_desc' },
  ]

  return (
    <section className="bg-bg-sidebar px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">{t('problem.title')}</h2>

        <div className="mt-12 grid gap-6 md:grid-cols-3">
          {problemes.map((p) => (
            <div key={p.titreKey} className="rounded-xl border border-border-base bg-bg-card p-6 shadow-card">
              <span className="text-3xl" aria-hidden>{p.icone}</span>
              <h3 className="mt-4 text-lg font-semibold text-text-primary">{t(p.titreKey)}</h3>
              <p className="mt-2 text-sm text-text-secondary">{t(p.descKey)}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
