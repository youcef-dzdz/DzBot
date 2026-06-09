'use client'

import { useLanguage, type Locale } from '@/context/LanguageContext'

const LOCALES: { code: Locale; label: string }[] = [
  { code: 'fr', label: 'FR' },
  { code: 'en', label: 'EN' },
  { code: 'ar', label: 'عر' },
]

/**
 * Sélecteur de langue compact (FR / EN / عر) — persiste le choix en localStorage via LanguageContext.
 * Accessible à tous les visiteurs depuis la navbar, change la langue et la direction du texte instantanément.
 */
export default function LanguageSwitcher() {
  const { locale, setLocale } = useLanguage()

  return (
    <div className="flex items-center rounded-lg border border-border-base bg-bg-card p-0.5 gap-0.5">
      {LOCALES.map(({ code, label }) => (
        <button
          key={code}
          onClick={() => setLocale(code)}
          aria-label={`Changer la langue en ${code}`}
          aria-pressed={locale === code}
          className={`rounded-md px-2.5 py-1 text-xs font-medium transition-colors ${
            locale === code
              ? 'bg-primary-700 text-text-on-primary'
              : 'text-text-secondary hover:text-primary-700'
          }`}
        >
          {label}
        </button>
      ))}
    </div>
  )
}
