'use client'

import Link from 'next/link'
import { useLanguage } from '@/context/LanguageContext'

/**
 * Section héro — badge, titre principal, sous-titre et appels à l'action de la landing page.
 * Première section visible par tout visiteur arrivant sur la page d'accueil.
 */
export default function LandingHero() {
  const { t } = useLanguage()

  return (
    <section className="bg-bg-base px-6 py-20">
      <style jsx global>{`
        @keyframes fadeIn {
          from { opacity: 0; }
          to { opacity: 1; }
        }
        @keyframes fadeInUp {
          from { opacity: 0; transform: translateY(20px); }
          to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in {
          animation: fadeIn 0.6s ease forwards;
          animation-delay: 0.2s;
          opacity: 0;
        }
        .animate-fade-in-up {
          animation: fadeInUp 0.6s ease forwards;
          opacity: 0;
        }
      `}</style>

      <div className="mx-auto flex max-w-3xl flex-col items-center text-center">
        <span className="animate-fade-in mb-4 inline-block rounded-full border border-gold-200 bg-gold-50 px-4 py-1 text-xs font-medium text-gold-700">
          {t('hero.badge')}
        </span>

        <h1 className="animate-fade-in-up text-[48px] font-bold leading-tight text-primary-700">
          {t('hero.title')}
        </h1>

        <p className="animate-fade-in-up mt-5 text-lg text-text-secondary">
          {t('hero.subtitle')}
        </p>

        <div className="mt-8 flex flex-col gap-4 sm:flex-row">
          <Link
            href="/sign-up"
            className="rounded-lg bg-primary-700 px-6 py-3 text-sm font-medium text-text-on-primary transition-colors hover:bg-primary-600"
          >
            {t('hero.cta_primary')}
          </Link>
          <Link
            href="#comment-ca-marche"
            className="rounded-lg border border-border-active bg-bg-card px-6 py-3 text-sm font-medium text-text-primary transition-colors hover:bg-bg-hover"
          >
            {t('hero.cta_secondary')}
          </Link>
        </div>
      </div>
    </section>
  )
}
