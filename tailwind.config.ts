import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        // Palette Espresso + Crème + Or — validée uidesign.md
        primary: {
          50:  "#F0E8DF",
          100: "#E4D5C3",
          200: "#D9C9B8",
          600: "#5C3208",
          700: "#3B1E03",
          900: "#2A1402",
        },
        gold: {
          50:  "#FBF4E4",
          200: "#EDD49A",
          400: "#D4A843",
          500: "#C4902A",
          700: "#9B7020",
        },
        "bg-base":    "#FAF9F7",
        "bg-sidebar": "#F2EDE6",
        "bg-card":    "#FFFFFF",
        "bg-hover":   "#F7F3EE",
        "bg-active":  "#F0E8DF",
        "bubble-user":        "#EDE8DF",
        "bubble-user-border": "#DDD7CC",
        "bubble-bot":         "#FFFFFF",
        "bubble-bot-border":  "#E8E3DC",
        "text-primary":     "#1A1A1A",
        "text-secondary":   "#6B6660",
        "text-muted":       "#9A9490",
        "text-placeholder": "#C9C3BB",
        "text-on-primary":  "#FAF9F7",
        "text-link":        "#3B1E03",
        "text-gold":        "#C4902A",
        "border-base":   "#E8E3DC",
        "border-light":  "#F2EDE6",
        "border-active": "#D9C9B8",
        "success-bg":   "#D1FAF0",
        "success-text": "#047857",
        "success-main": "#2A7A4B",
        "warning-bg":   "#FEF3E2",
        "warning-text": "#B45309",
        "error-bg":     "#FEE2E2",
        "error-text":   "#B91C1C",
        "info-bg":      "#F0E8DF",
        "info-text":    "#3B1E03",
        "info-border":  "#D9C9B8",
        "disclaimer-bg":     "#FFFBEB",
        "disclaimer-border": "#FCD34D",
        "disclaimer-text":   "#92400E",
      },
      borderRadius: {
        xl:  "14px",
        "2xl": "18px",
      },
      boxShadow: {
        card:       "0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04)",
        "card-hover": "0 4px 12px rgba(0,0,0,0.08), 0 2px 4px rgba(0,0,0,0.04)",
        modal:      "0 20px 60px rgba(0,0,0,0.12), 0 8px 20px rgba(0,0,0,0.06)",
        focus:      "0 0 0 3px rgba(59,30,3,0.15)",
      },
      fontFamily: {
        sans:   ["Inter", "system-ui", "-apple-system", "sans-serif"],
        arabic: ["Noto Sans Arabic", "Segoe UI", "Arial", "sans-serif"],
      },
    },
  },
  plugins: [],
};
export default config;
