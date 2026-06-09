'use client'

import { ClerkProvider } from '@clerk/nextjs'
import { arSA, frFR, enUS } from '@clerk/localizations'
import { useLanguage } from '@/context/LanguageContext'
import type { ReactNode } from 'react'

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const CLERK_LOCALIZATIONS: Record<string, any> = {
  fr: frFR,
  en: enUS,
  ar: arSA,
}

/**
 * Wrapper ClerkProvider sensible à la locale — passe la traduction correcte aux formulaires Clerk (sign-in/sign-up).
 * Doit être enfant de LanguageProvider pour lire useLanguage() et mettre à jour la locale Clerk en temps réel.
 */
export default function LocalizedClerkProvider({ children }: { children: ReactNode }) {
  const { locale } = useLanguage()
  return (
    <ClerkProvider localization={CLERK_LOCALIZATIONS[locale]}>
      {children}
    </ClerkProvider>
  )
}
