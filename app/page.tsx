'use client'

import LandingNavbar from '@/components/landing/LandingNavbar'
import LandingHero from '@/components/landing/LandingHero'
import LandingProblem from '@/components/landing/LandingProblem'
import LandingHowItWorks from '@/components/landing/LandingHowItWorks'
import LandingFeatures from '@/components/landing/LandingFeatures'
import LandingCTA from '@/components/landing/LandingCTA'
import LandingFooter from '@/components/landing/LandingFooter'

/**
 * Page d'accueil — landing page publique de LegalBot DZ.
 * Assemble les sections marketing dans l'ordre validé : navbar, héro, problème, fonctionnement, fonctionnalités, CTA, footer.
 */
export default function Home() {
  return (
    <main className="bg-bg-base">
      <LandingNavbar />
      <LandingHero />
      <LandingProblem />
      <LandingHowItWorks />
      <LandingFeatures />
      <LandingCTA />
      <LandingFooter />
    </main>
  )
}
