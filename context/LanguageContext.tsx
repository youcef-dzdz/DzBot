'use client'

import { createContext, useContext, useEffect, useState, ReactNode } from 'react'
import fr from '@/locales/fr.json'
import en from '@/locales/en.json'
import ar from '@/locales/ar.json'

export type Locale = 'fr' | 'en' | 'ar'

const TRANSLATIONS = { fr, en, ar }

interface LanguageContextValue {
  locale: Locale
  setLocale: (l: Locale) => void
  t: (key: string) => string
  dir: 'ltr' | 'rtl'
}

const LanguageContext = createContext<LanguageContextValue | null>(null)

/**
 * Résout une clé de traduction en notation pointée (ex: "nav.home") dans un objet imbriqué.
 * Retourne la clé elle-même si la valeur est introuvable, pour éviter les chaînes vides en UI.
 */
function resolve(obj: Record<string, unknown>, key: string): string {
  const result = key.split('.').reduce<unknown>((acc, part) => {
    if (acc !== null && acc !== undefined && typeof acc === 'object') {
      return (acc as Record<string, unknown>)[part]
    }
    return undefined
  }, obj)
  return typeof result === 'string' ? result : key
}

/**
 * Fournisseur du contexte de langue — persiste le choix en localStorage et synchronise dir/lang sur <html>.
 * Entoure l'arbre de l'application dans layout.tsx pour rendre t() disponible partout.
 */
export function LanguageProvider({ children }: { children: ReactNode }) {
  const [locale, setLocaleState] = useState<Locale>('fr')

  useEffect(() => {
    const saved = localStorage.getItem('locale')
    if (saved === 'fr' || saved === 'en' || saved === 'ar') setLocaleState(saved)
  }, [])

  useEffect(() => {
    document.documentElement.lang = locale
    document.documentElement.dir = locale === 'ar' ? 'rtl' : 'ltr'
    localStorage.setItem('locale', locale)
  }, [locale])

  const t = (key: string) =>
    resolve(TRANSLATIONS[locale] as Record<string, unknown>, key)

  const dir: 'ltr' | 'rtl' = locale === 'ar' ? 'rtl' : 'ltr'

  return (
    <LanguageContext.Provider value={{ locale, setLocale: setLocaleState, t, dir }}>
      {children}
    </LanguageContext.Provider>
  )
}

/**
 * Hook pour accéder à la langue courante, la fonction t() et la direction du texte.
 * Doit être utilisé uniquement dans des composants fils du LanguageProvider.
 */
export function useLanguage() {
  const ctx = useContext(LanguageContext)
  if (!ctx) throw new Error('useLanguage doit être utilisé dans un LanguageProvider')
  return ctx
}
