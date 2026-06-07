import { SignIn } from '@clerk/nextjs'
import Image from 'next/image'

/**
 * Page d'authentification — connexion via Clerk.
 * Accessible à tous (route publique par défaut avec clerkMiddleware v5).
 */
export default function SignInPage() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-start pt-8 pb-8 bg-bg-sidebar">
      {/* Logo LegalBot DZ */}
      <div className="mb-2">
        <Image src="/logo.png" alt="LegalBot DZ" width={120} height={120} priority className="object-contain" />
      </div>

      {/* Composant Clerk — gère connexion, erreurs, redirections */}
      <SignIn />
    </main>
  )
}
