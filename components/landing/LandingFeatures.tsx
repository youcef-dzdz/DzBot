'use client'

import { useLanguage } from '@/context/LanguageContext'

/**
 * Section "Pour les citoyens et les professionnels" — compare les fonctionnalités par profil utilisateur.
 * Sert d'ancre de navigation ciblée par le lien "Fonctionnalités" de la navbar.
 */
export default function LandingFeatures() {
  const { t } = useLanguage()

  const fonctionnalitesCitoyen = [
    'features.citizen_f1',
    'features.citizen_f2',
    'features.citizen_f3',
    'features.citizen_f4',
  ]

  const fonctionnalitesAvocat = [
    'features.lawyer_f1',
    'features.lawyer_f2',
    'features.lawyer_f3',
    'features.lawyer_f4',
  ]

  return (
    <section id="fonctionnalites" className="scroll-mt-20 bg-bg-sidebar px-6 py-20">
      <div className="mx-auto max-w-6xl">
        <h2 className="text-center text-[28px] font-bold text-primary-700">
          {t('features.title')}
        </h2>

        <div className="mt-12 grid gap-6 md:grid-cols-2">
          <div className="rounded-xl border border-border-base bg-bg-card p-8 shadow-card">
            <span className="text-3xl" aria-hidden>👤</span>
            <h3 className="mt-3 text-lg font-semibold text-text-primary">{t('features.citizen_label')}</h3>
            <ul className="mt-4 space-y-3">
              {fonctionnalitesCitoyen.map((key) => (
                <li key={key} className="flex items-center gap-2 text-sm text-text-secondary">
                  <span className="h-1.5 w-1.5 rounded-full bg-gold-500" aria-hidden />
                  {t(key)}
                </li>
              ))}
            </ul>
          </div>

          <div className="rounded-xl border border-border-base bg-bg-card p-8 shadow-card">
            <span className="text-3xl" aria-hidden>⚖️</span>
            <h3 className="mt-3 text-lg font-semibold text-text-primary">{t('features.lawyer_label')}</h3>
            <ul className="mt-4 space-y-3">
              {fonctionnalitesAvocat.map((key) => (
                <li key={key} className="flex items-center gap-2 text-sm text-text-secondary">
                  <span className="h-1.5 w-1.5 rounded-full bg-gold-500" aria-hidden />
                  {t(key)}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </section>
  )
}
