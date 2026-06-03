// lib/supabase.ts
// Client Supabase — point d'entrée unique pour toutes les requêtes DB
// Utilisé côté client (composants React) uniquement

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)