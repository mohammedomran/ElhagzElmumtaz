# الحجز الممتاز (Al-Hagz Al-Momtaz) — Premium Football Booking

A football (soccer) booking, team, and league platform for the Egyptian market.
Arabic-first, RTL, mobile-first UI.

## Tech stack

- **Framework:** ASP.NET Core **Razor Pages** (`AddRazorPages` in `Program.cs`)
- **Target:** .NET 10 (`net10.0`)
- **Language/UI:** Arabic (`lang="ar" dir="rtl"`), mobile-first
- **CSS:** Bootstrap 5.3 RTL (CDN) + custom `/wwwroot/css/styles.css`
- **Fonts:** IBM Plex Sans Arabic + Sora (Google Fonts), Font Awesome 7 icons
- **Database (planned):** SQL Server / T-SQL, **DB-first**, with ASP.NET Core **Identity**
- **Root namespace:** `ElhagzElmomtaz`; pages namespace `ElhagzElmomtaz.Pages`

## Current state (important)

This project is **UI mockups + DB schema only**. The backend is **not implemented yet**:

- Every page model (`*.cshtml.cs`) is an empty scaffold with just `OnGet()`.
- The `.cshtml` views are **static HTML with hardcoded sample data** (often Arabic).
- `Program.cs` only registers Razor Pages — **no DbContext, no EF entities, no
  Identity, no services, no DI** beyond the defaults.
- There are **no** `Models/`, `Data/`, `Services/`, or `Entities/` folders yet.
- `Database/Schema.sql` is **DB-first** and assumes Identity tables
  (`AspNetUsers`, `AspNetRoles`, ...) already exist; it only creates the domain
  tables and references `AspNetUsers(Id)` where a user link is needed.

When asked to "make a page work," expect to build the C# logic, EF entities,
data access, and Identity wiring from scratch — they do not exist.

## Project layout

```
app/
├─ Program.cs                 # minimal: AddRazorPages() + static assets
├─ Database/Schema.sql        # DB-first domain schema (run AFTER Identity tables)
├─ Pages/
│  ├─ Index.cshtml            # splash screen → auto-redirects to /signin (4.6s)
│  ├─ _ViewImports / _ViewStart
│  ├─ Shared/_Layout.cshtml   # RTL layout (Index uses Layout = null)
│  ├─ signin / signup / edit-profile / profile / status
│  ├─ create-team / team-details / team-manage / join-request-status
│  ├─ leagues / league-details / matches / match-details / tournaments / leaderboard
│  ├─ payment
│  └─ Admin/template/         # Tabler-style HTML dashboard template — for LATER, do not edit
└─ wwwroot/                   # css/styles.css, assets/logo.png, etc.
```

### Navigation
- `Index` is a splash screen that auto-redirects to `/signin`.
- Main app uses a bottom tab bar: ماتشات (matches), دوريات (leagues),
  بطولات (tournaments), حسابي (profile).
- `Pages/Admin/template/` is a third-party dashboard template reserved for future
  admin work. **Do not modify or use it unless explicitly asked.**

## Domain model (`Database/Schema.sql`)

DB-first, SQL Server / T-SQL. Conventions:
- Table names **singular**; every primary key column is `Id`.
- Arabic-capable text columns are `NVARCHAR`. Money: `DECIMAL(10,2)`.
- Timestamps: `DATETIME2(0)` defaulting to `SYSUTCDATETIME()`.
- Fixed enums via `CHECK` constraints (Arabic meaning in comments).
- FKs use `NO ACTION` by default to avoid multiple-cascade-path errors; owned
  children cascade.

Tables:
- **City** — cities (المدن)
- **Player** — 1:1 with `AspNetUsers`; football profile. `Tier`
  (Bronze/Silver/Gold/Platinum), `IsVerified` badge, optional `CityId`.
- **Stadium** — venues (الملاعب)
- **Team** — teams; optional `CaptainPlayerId`
- **TeamMember** — roster (Status: Active/Left/Removed); unique (TeamId, PlayerId)
- **TeamJoinRequest** — join requests (Pending/Approved/Rejected/Cancelled)
- **League** — "دوري الجمعة" (Friday league); `DayOfWeek`, times, `EntryFee`,
  Status (Upcoming/Open/Ongoing/Finished/Cancelled)
- **LeagueRegistration** — a team enters a league ("الدخول بفريق");
  Status (Pending/Confirmed/Cancelled); unique (LeagueId, TeamId)
- **Match** — `Type` int enum (0=Friendly, 1=League); home/away teams, score,
  Status (Scheduled/Live/Finished/Postponed/Cancelled); CHECK home ≠ away
- **MatchLineup** — who played (unique MatchId, PlayerId)
- **MatchEvent** — Goal/Assist/OwnGoal/YellowCard/RedCard/Penalty (+ optional assist)
- **Payment** — league entry fees; Method (Card/Wallet/Cash/Fawry/InstaPay),
  Status (Pending/Paid/Failed/Refunded), raw gateway JSON
- **Notification** — broadcast notices to all players

## Conventions & guidance

- **Keep everything Arabic + RTL.** User-facing text is Arabic; layouts are `dir="rtl"`.
- Match the existing CSS class vocabulary in views (`app-page`, `app-bar`,
  `app-content`, `tab-bar`, `league-card`, `section-head`, etc.) and `styles.css`.
- The DB is **DB-first** — if adding EF Core, scaffold/configure entities to match
  `Schema.sql` rather than relying on code-first migrations to define the schema.
- Player identity links through ASP.NET Core **Identity** (`AspNetUsers.Id` →
  `Player.UserId`, 1:1).
- **Do not touch `Pages/Admin/template/`** unless explicitly requested.

## Build & run

```powershell
dotnet build
dotnet run        # serves Razor Pages; visit the splash at /, redirects to /signin
```
