import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import { LanguageProvider } from '@/context/LanguageContext'
import LocalizedClerkProvider from '@/components/shared/LocalizedClerkProvider'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'LegalBot DZ',
  description: 'Plateforme LegalTech multilingue pour le marché algérien',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="fr">
      <body className={inter.className}>
        <LanguageProvider>
          <LocalizedClerkProvider>
            {children}
          </LocalizedClerkProvider>
        </LanguageProvider>
      </body>
    </html>
  )
}