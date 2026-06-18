---
name: Al-Hajz Al-Mumtaz
colors:
  surface: '#0d150f'
  surface-dim: '#0d150f'
  surface-bright: '#323b34'
  surface-container-lowest: '#08100a'
  surface-container-low: '#151e17'
  surface-container: '#19221b'
  surface-container-high: '#232c25'
  surface-container-highest: '#2e3730'
  on-surface: '#dbe5db'
  on-surface-variant: '#bacbbc'
  inverse-surface: '#dbe5db'
  inverse-on-surface: '#2a332c'
  outline: '#859587'
  outline-variant: '#3b4a3f'
  surface-tint: '#0de389'
  primary: '#79ffb0'
  on-primary: '#00391e'
  primary-container: '#19e68c'
  on-primary-container: '#006238'
  inverse-primary: '#006d3f'
  secondary: '#ffbd58'
  on-secondary: '#442b00'
  secondary-container: '#ea9f00'
  on-secondary-container: '#5b3b00'
  tertiary: '#ffe1c1'
  on-tertiary: '#472a00'
  tertiary-container: '#ffbd6c'
  on-tertiary-container: '#784a00'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#57ffa6'
  primary-fixed-dim: '#0de389'
  on-primary-fixed: '#00210f'
  on-primary-fixed-variant: '#00522e'
  secondary-fixed: '#ffddb1'
  secondary-fixed-dim: '#ffba4b'
  on-secondary-fixed: '#291800'
  on-secondary-fixed-variant: '#624000'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#fbba69'
  on-tertiary-fixed: '#2b1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#0A0E12'
  on-background: '#dbe5db'
  surface-variant: '#2e3730'
  surface-1: '#141A21'
  surface-2: '#1E262F'
  text-main: '#F5F7FA'
  text-muted: '#8B95A1'
  border: '#2A323C'
  danger: '#FF5A5F'
  tier-bronze: '#CD7F32'
  tier-silver: '#C7CDD4'
  tier-gold: '#FFD24A'
  tier-platinum: '#6FE3E1'
typography:
  stat-hero:
    fontFamily: Sora
    fontSize: 48px
    fontWeight: '800'
    lineHeight: 48px
  headline-lg:
    fontFamily: Sora
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-md:
    fontFamily: Sora
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  body-lg:
    fontFamily: IBM Plex Sans Arabic
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: IBM Plex Sans Arabic
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-bold:
    fontFamily: IBM Plex Sans Arabic
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-sm:
    fontFamily: IBM Plex Sans Arabic
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
  xxl: 32px
---

Brand Name
الحجز الممتاز
Brand personality
Energetic, premium, sporty, gamified. Inspired by EA Sports FC / FIFA Ultimate Team UI — dark, high-contrast, big bold stats, player-card energy. The whole point: make an amateur player feel like a pro.
Language & direction
Arabic (Egyptian) UI, full Right-to-Left (RTL) layout. All labels, buttons and navigation in Arabic. Numbers shown in Western Arabic numerals (0–9).
If RTL Arabic renders poorly, fall back to Franco-Arabic / English labels (e.g. "Matches", "7akam", "Mobtade2") — same approach Wady Le3b uses.
Color tokens


--bg: #0A0E12 (near-black background)

--surface: #141A21 (cards)

--surface-2: #1E262F (inputs, raised cards)

--primary: #19E68C (pitch green — primary actions & highlights)

--primary-press: #12B86F

--accent: #FFB020 (amber — Player of the Month, awards, premium)

--text: #F5F7FA

--text-muted: #8B95A1

--border: #2A323C

--danger: #FF5A5F (losses, errors)

Tier colors → Bronze #CD7F32 · Silver #C7CDD4 · Gold #FFD24A · Platinum #6FE3E1
Typography


Headings & stat numbers: bold condensed display sans (Sora / Space Grotesk), heavy weight.

Body & labels: clean sans (Inter, or IBM Plex Sans Arabic for Arabic).

Big stat numbers are the visual hero — large, bold, in white or primary green.
Shape & spacing


Radius: cards 16px · buttons & inputs 12px · avatars full circle.

Spacing scale: 4 / 8 / 12 / 16 / 24 / 32.

Generous padding inside cards, clear separation between sections.
Core components


Bottom tab bar — 4 tabs (RTL order): الماتشات · الإحصائيات · البطولات · حسابي. Dark surface, active icon in primary green.

Match card — day/time header, city + map-pin link, overlapping player avatars + "+N", spots-left indicator, price pill, green "انضم" button.

Player avatar chip — circular photo with a tier-colored ring + name.

Stat tile — icon + big number + small label.

Leaderboard row — rank, avatar, name, played, W/D/L, goals, assists, points (points emphasized).

Pill badges — skill level (مبتدئ / متوسط / صعب) and tier (Bronze→Platinum) using tier colors.

Primary button — filled primary green, dark text, bold, full-width, 12px radius.
Imagery
Real player photos in circular avatars. The dark UI lets photos and green accents pop. Subtle pitch-texture gradient allowed in headers only — never noisy.