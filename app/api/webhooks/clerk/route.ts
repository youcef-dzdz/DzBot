// app/api/webhooks/clerk/route.ts
// Webhook Clerk → synchronisation des nouveaux utilisateurs vers Supabase
// Écoute l'événement user.created et insère le profil en base de données

import { NextRequest, NextResponse } from 'next/server'
import { Webhook } from 'svix'
import { createClient } from '@supabase/supabase-js'

// ============================================================
// TYPES — Payloads Clerk
// ============================================================

/** Données d'un utilisateur reçues dans l'événement user.created */
type DonneeUtilisateur = {
  id: string
  email_addresses: Array<{ email_address: string }>
  first_name: string | null
  last_name: string | null
}

/** Structure générique d'un événement webhook Clerk */
type EvenementWebhook = {
  type: string
  data: DonneeUtilisateur
}

// ============================================================
// CLIENT SUPABASE — Service Role (contourne le RLS)
// Utilisé côté serveur uniquement — jamais exposé au client
// ============================================================

const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
      detectSessionInUrl: false,
    },
  }
)

// ============================================================
// HELPERS
// ============================================================

/**
 * Vérifie la signature svix de la requête entrante.
 * Garantit que l'appel provient bien des serveurs Clerk et non d'un tiers malveillant.
 */
async function verifierSignature(req: NextRequest): Promise<EvenementWebhook> {
  const svixId = req.headers.get('svix-id')
  const svixTimestamp = req.headers.get('svix-timestamp')
  const svixSignature = req.headers.get('svix-signature')

  if (!svixId || !svixTimestamp || !svixSignature) {
    throw new Error('En-têtes svix absents de la requête')
  }

  const secret = process.env.CLERK_WEBHOOK_SECRET
  if (!secret) {
    throw new Error('Variable CLERK_WEBHOOK_SECRET non configurée')
  }

  // Lire le corps brut avant tout parsing — svix vérifie le payload exact reçu
  const corps = await req.text()
  const wh = new Webhook(secret)

  return wh.verify(corps, {
    'svix-id': svixId,
    'svix-timestamp': svixTimestamp,
    'svix-signature': svixSignature,
  }) as EvenementWebhook
}

/**
 * Insère un nouvel utilisateur dans la table users avec le rôle citoyen par défaut.
 * Appelé uniquement par le webhook système — jamais depuis l'interface utilisateur.
 */
async function syncUserCreated(data: DonneeUtilisateur): Promise<void> {
  const email = data.email_addresses?.[0]?.email_address ?? ''
  const nom =
    [data.first_name, data.last_name].filter(Boolean).join(' ') || null

  const { error } = await supabaseAdmin.from('users').insert({
    clerk_id: data.id,
    email,
    role: 'citoyen',
    nom,
  })

  if (error) throw error
}

// ============================================================
// HANDLER PRINCIPAL
// ============================================================

/**
 * Handler POST — reçoit tous les événements webhook envoyés par Clerk.
 * Seul user.created est traité ; les autres types sont ignorés silencieusement.
 */
export async function POST(req: NextRequest): Promise<NextResponse> {
  // Étape 1 — vérification de la signature svix (400 si invalide)
  let evenement: EvenementWebhook
  try {
    evenement = await verifierSignature(req)
  } catch {
    return NextResponse.json(
      { erreur: 'Signature webhook invalide ou en-têtes svix manquants' },
      { status: 400 }
    )
  }

  // Étape 2 — traitement de l'événement user.created uniquement
  try {
    if (evenement.type === 'user.created') {
      await syncUserCreated(evenement.data)
    }

    return NextResponse.json({ recu: true }, { status: 200 })
  } catch {
    return NextResponse.json(
      { erreur: 'Erreur interne — synchronisation vers Supabase échouée' },
      { status: 500 }
    )
  }
}
