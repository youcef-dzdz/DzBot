import Link from 'next/link'

/**
 * Section d'appel à l'action final — incite le visiteur à créer un compte gratuitement.
 * Affichée juste avant le footer, sur fond espresso pour marquer une rupture visuelle forte.
 */
export default function LandingCTA() {
  return (
    <section className="bg-primary-700 px-6 py-20">
      <div className="mx-auto flex max-w-3xl flex-col items-center text-center">
        <h2 className="text-[28px] font-bold text-text-on-primary">Prêt à comprendre vos droits ?</h2>
        <p className="mt-3 text-lg text-text-on-primary/80">
          Rejoignez LegalBot DZ — gratuit pour commencer.
        </p>
        <Link
          href="/sign-up"
          className="mt-8 rounded-lg bg-gold-500 px-6 py-3 text-sm font-medium text-text-on-primary transition-colors hover:bg-gold-400"
        >
          Créer mon compte
        </Link>
      </div>
    </section>
  )
}
