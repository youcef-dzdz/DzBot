'use client'
import { SignUp } from '@clerk/nextjs'
import Image from 'next/image'

// Page d'inscription — affiche le composant Clerk SignUp
// Accessible : utilisateurs non authentifiés uniquement
export default function SignUpPage() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-start pt-8 pb-8 bg-[#F2EDE6]">
      {/* Logo LegalBot DZ */}
      <div className="mb-2">
        <Image src="/logo.png" alt="LegalBot DZ" width={120} height={120} priority className="object-contain" />
      </div>
      {/* Composant Clerk SignUp */}
      <SignUp />
    </main>
  )
}
