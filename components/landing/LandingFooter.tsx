'use client'

import Link from 'next/link'
import { useLanguage } from '@/context/LanguageContext'

/**
 * Pied de page de la landing — logo, liens de navigation, copyright et avertissement légal.
 * Affiché en bas de toutes les sections, sur fond beige comme les sections secondaires.
 */
export default function LandingFooter() {
  const { t } = useLanguage()

  return (
    <footer className="bg-bg-sidebar px-6 py-12">
      <div className="mx-auto flex max-w-6xl flex-col items-center gap-6 text-center">
        <span className="text-xl font-bold">
          <span className="text-primary-700">LegalBot </span>
          <span className="text-gold-500">DZ</span>
        </span>

        <nav className="flex flex-wrap justify-center gap-6">
          <Link href="/" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('footer.home')}
          </Link>
          <Link href="/sign-in" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('footer.sign_in')}
          </Link>
          <Link href="/sign-up" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('footer.sign_up')}
          </Link>
        </nav>

        <p className="text-sm text-text-muted">{t('footer.copyright')}</p>

        <p className="max-w-2xl rounded-lg border border-disclaimer-border bg-disclaimer-bg px-4 py-3 text-xs text-disclaimer-text">
          {t('footer.disclaimer')}
        </p>
      </div>
    </footer>
  )
}
