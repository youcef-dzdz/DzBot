'use client'

import Image from 'next/image'
import Link from 'next/link'
import { useLanguage } from '@/context/LanguageContext'
import LanguageSwitcher from '@/components/shared/LanguageSwitcher'

/**
 * Barre de navigation principale de la landing page — logo, liens d'ancrage, sélecteur de langue et CTA.
 * Visible par tous les visiteurs (connectés ou non), reste fixée en haut au défilement.
 */
export default function LandingNavbar() {
  const { t } = useLanguage()

  return (
    <header className="sticky top-0 z-50 border-b border-border-base bg-bg-base">
      <nav className="mx-auto flex max-w-6xl items-center justify-between px-6 py-2">
        <Link href="/" className="flex items-center">
          <Image src="/logo.png" alt="LegalBot DZ" width={160} height={48} className="object-contain" />
        </Link>

        <div className="hidden items-center gap-8 md:flex">
          <Link href="/" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('nav.home')}
          </Link>
          <Link href="#fonctionnalites" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('nav.features')}
          </Link>
          <Link href="#comment-ca-marche" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('nav.how_it_works')}
          </Link>
          <Link href="/sign-in" className="text-sm text-text-secondary transition-colors hover:text-primary-700">
            {t('nav.sign_in')}
          </Link>
        </div>

        <div className="flex items-center gap-3">
          <LanguageSwitcher />
          <Link
            href="/sign-up"
            className="rounded-lg bg-primary-700 px-5 py-2 text-sm font-medium text-text-on-primary transition-colors hover:bg-primary-600"
          >
            {t('nav.cta')}
          </Link>
        </div>
      </nav>
    </header>
  )
}
