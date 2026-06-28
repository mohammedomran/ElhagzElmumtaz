/* =============================================================================
   الحجز الممتاز — Database Schema (SQL Server / T-SQL)
   -----------------------------------------------------------------------------
   DB-FIRST. Run this AFTER ASP.NET Core Identity has created its own tables
   (AspNetUsers, AspNetRoles, ...). This script only creates the DOMAIN tables
   and references AspNetUsers(Id) where a user link is needed.

   Conventions:
     - Table names are singular. Every primary key column is "Id".
     - Arabic-capable text columns are NVARCHAR.
     - Money: DECIMAL(10,2).  Timestamps: DATETIME2(0), default SYSUTCDATETIME().
     - Fixed enums use CHECK constraints (Arabic meaning in comments).
     - FKs use NO ACTION by default to avoid SQL Server multiple-cascade-path
       errors; owned children cascade.
   ============================================================================= */

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

-- =============================================================================
-- 1) CITY  (المدن)
-- =============================================================================
CREATE TABLE dbo.City
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    Name        NVARCHAR(80)    NOT NULL,
    CreatedAt   DATETIME2(0)    NOT NULL CONSTRAINT DF_City_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_City PRIMARY KEY (Id)
);
GO

-- =============================================================================
-- 2) PLAYER  (1:1 with AspNetUsers — the football profile of a user)
-- =============================================================================
CREATE TABLE dbo.Player
(
    Id              INT             IDENTITY(1,1) NOT NULL,
    UserId          NVARCHAR(450)   NOT NULL,              -- FK -> AspNetUsers.Id (1:1)
    FullName        NVARCHAR(120)   NOT NULL,
    Nickname        NVARCHAR(60)    NULL,                  -- اسم الشهرة
    DateOfBirth     DATE            NULL,
    CityId          INT             NULL,
    Tier            NVARCHAR(20)    NOT NULL CONSTRAINT DF_Player_Tier DEFAULT N'Bronze', -- Bronze/Silver/Gold/Platinum (برونزي/فضي/ذهبي/بلاتينيوم)
    Avatar          NVARCHAR(400)   NULL,
    IsVerified      BIT             NOT NULL CONSTRAINT DF_Player_IsVerified DEFAULT (0), -- شارة التوثيق
    CreatedAt       DATETIME2(0)    NOT NULL CONSTRAINT DF_Player_CreatedAt  DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Player                PRIMARY KEY (Id),
    CONSTRAINT UQ_Player_UserId         UNIQUE (UserId),
    CONSTRAINT FK_Player_AspNetUsers    FOREIGN KEY (UserId) REFERENCES dbo.AspNetUsers (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Player_City           FOREIGN KEY (CityId) REFERENCES dbo.City (Id) ON DELETE SET NULL,
    CONSTRAINT CK_Player_Tier           CHECK (Tier IN (N'Bronze', N'Silver', N'Gold', N'Platinum'))
);
GO

-- =============================================================================
-- 3) STADIUM  (الملاعب)
-- =============================================================================
CREATE TABLE dbo.Stadium
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    Name        NVARCHAR(120)   NOT NULL,
    Address     NVARCHAR(250)   NULL,
    CityId      INT             NULL,
    CreatedAt   DATETIME2(0)    NOT NULL CONSTRAINT DF_Stadium_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Stadium       PRIMARY KEY (Id),
    CONSTRAINT FK_Stadium_City  FOREIGN KEY (CityId) REFERENCES dbo.City (Id) ON DELETE SET NULL
);
GO

-- =============================================================================
-- 4) TEAM  (الفرق)
-- =============================================================================
CREATE TABLE dbo.Team
(
    Id              INT             IDENTITY(1,1) NOT NULL,
    Name            NVARCHAR(120)   NOT NULL,
    Logo            NVARCHAR(400)   NULL,
    CityId          INT             NULL,
    Description     NVARCHAR(500)   NULL,
    CaptainPlayerId INT             NULL,              -- كابتن الفريق (nullable)
    CreatedAt       DATETIME2(0)    NOT NULL CONSTRAINT DF_Team_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Team          PRIMARY KEY (Id),
    CONSTRAINT FK_Team_City     FOREIGN KEY (CityId)          REFERENCES dbo.City   (Id) ON DELETE SET NULL,
    CONSTRAINT FK_Team_Captain  FOREIGN KEY (CaptainPlayerId) REFERENCES dbo.Player (Id) ON DELETE NO ACTION
);
GO

-- =============================================================================
-- 5) TEAM MEMBER  (لاعبو الفريق)
-- =============================================================================
CREATE TABLE dbo.TeamMember
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    TeamId      INT             NOT NULL,
    PlayerId    INT             NOT NULL,
    Status      NVARCHAR(20)    NOT NULL CONSTRAINT DF_TeamMember_Status DEFAULT N'Active', -- Active/Left/Removed
    JoinedAt    DATETIME2(0)    NOT NULL CONSTRAINT DF_TeamMember_JoinedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_TeamMember            PRIMARY KEY (Id),
    CONSTRAINT UQ_TeamMember_TeamPlayer UNIQUE (TeamId, PlayerId),
    CONSTRAINT FK_TeamMember_Team       FOREIGN KEY (TeamId)   REFERENCES dbo.Team   (Id) ON DELETE CASCADE,
    CONSTRAINT FK_TeamMember_Player     FOREIGN KEY (PlayerId) REFERENCES dbo.Player (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_TeamMember_Status     CHECK (Status IN (N'Active', N'Left', N'Removed'))
);
GO

-- =============================================================================
-- 6) TEAM JOIN REQUEST  (طلبات الانضمام)
-- =============================================================================
CREATE TABLE dbo.TeamJoinRequest
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    TeamId      INT             NOT NULL,
    PlayerId    INT             NOT NULL,          -- مقدم الطلب
    Status      NVARCHAR(20)    NOT NULL CONSTRAINT DF_JoinReq_Status DEFAULT N'Pending', -- Pending/Approved/Rejected/Cancelled
    CreatedAt   DATETIME2(0)    NOT NULL CONSTRAINT DF_JoinReq_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_TeamJoinRequest   PRIMARY KEY (Id),
    CONSTRAINT FK_JoinReq_Team      FOREIGN KEY (TeamId)   REFERENCES dbo.Team   (Id) ON DELETE CASCADE,
    CONSTRAINT FK_JoinReq_Player    FOREIGN KEY (PlayerId) REFERENCES dbo.Player (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_JoinReq_Status    CHECK (Status IN (N'Pending', N'Approved', N'Rejected', N'Cancelled'))
);
GO

-- =============================================================================
-- 7) LEAGUE  (الدوريات — دوري الجمعة)
-- =============================================================================
CREATE TABLE dbo.League
(
    Id              INT             IDENTITY(1,1) NOT NULL,
    Name            NVARCHAR(150)   NOT NULL,          -- دوري الجمعة — الموسم الأول
    SeasonNumber    INT             NULL,
    StadiumId       INT             NULL,
    CityId          INT             NULL,
    DayOfWeek       TINYINT         NULL,              -- 0=Sun .. 6=Sat (5 = الجمعة)
    StartTime       TIME(0)         NULL,              -- 20:00
    EndTime         TIME(0)         NULL,              -- 22:00
    EntryFee        DECIMAL(10,2)   NOT NULL CONSTRAINT DF_League_EntryFee DEFAULT (0),  -- 500
    TeamsNumber     INT             NULL,
    StartDate       DATE            NULL,
    EndDate         DATE            NULL,
    Status          NVARCHAR(20)    NOT NULL CONSTRAINT DF_League_Status DEFAULT N'Upcoming', -- Upcoming/Open/Ongoing/Finished/Cancelled
    Description     NVARCHAR(1000)  NULL,
    CreatedAt       DATETIME2(0)    NOT NULL CONSTRAINT DF_League_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_League        PRIMARY KEY (Id),
    CONSTRAINT FK_League_Stadium FOREIGN KEY (StadiumId) REFERENCES dbo.Stadium (Id) ON DELETE SET NULL,
    CONSTRAINT FK_League_City    FOREIGN KEY (CityId)    REFERENCES dbo.City    (Id) ON DELETE SET NULL,
    CONSTRAINT CK_League_Status  CHECK (Status IN (N'Upcoming', N'Open', N'Ongoing', N'Finished', N'Cancelled')),
    CONSTRAINT CK_League_Day     CHECK (DayOfWeek IS NULL OR DayOfWeek BETWEEN 0 AND 6)
);
GO

-- =============================================================================
-- 8) LEAGUE REGISTRATION  (تسجيل فريق في دوري — "الدخول بفريق")
-- =============================================================================
CREATE TABLE dbo.LeagueRegistration
(
    Id              INT             IDENTITY(1,1) NOT NULL,
    LeagueId        INT             NOT NULL,
    TeamId          INT             NOT NULL,
    Status          NVARCHAR(20)    NOT NULL CONSTRAINT DF_LeagueReg_Status DEFAULT N'Pending', -- Pending/Confirmed/Cancelled
    RegisteredAt    DATETIME2(0)    NOT NULL CONSTRAINT DF_LeagueReg_At DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_LeagueRegistration    PRIMARY KEY (Id),
    CONSTRAINT UQ_LeagueReg_LeagueTeam  UNIQUE (LeagueId, TeamId),
    CONSTRAINT FK_LeagueReg_League      FOREIGN KEY (LeagueId) REFERENCES dbo.League (Id) ON DELETE CASCADE,
    CONSTRAINT FK_LeagueReg_Team        FOREIGN KEY (TeamId)   REFERENCES dbo.Team   (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_LeagueReg_Status      CHECK (Status IN (N'Pending', N'Confirmed', N'Cancelled'))
);
GO

-- =============================================================================
-- 9) MATCH  (الماتشات — Type: 0=Friendly / 1=League, mapped via C# enum)
-- =============================================================================
CREATE TABLE dbo.[Match]
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    Type        INT             NOT NULL CONSTRAINT DF_Match_Type DEFAULT (0),  -- C# enum: Friendly / League
    LeagueId    INT             NULL,
    StadiumId   INT             NULL,
    HomeTeamId  INT             NOT NULL,
    AwayTeamId  INT             NOT NULL,
    ScheduledDate DATETIME2(0)  NOT NULL,
    MatchDay    INT             NULL,              -- جولة الدوري / round
    Status      NVARCHAR(20)    NOT NULL CONSTRAINT DF_Match_Status DEFAULT N'Scheduled', -- Scheduled/Live/Finished/Postponed/Cancelled
    HomeScore   TINYINT         NULL,
    AwayScore   TINYINT         NULL,
    CreatedAt   DATETIME2(0)    NOT NULL CONSTRAINT DF_Match_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Match             PRIMARY KEY (Id),
    CONSTRAINT FK_Match_League      FOREIGN KEY (LeagueId)   REFERENCES dbo.League  (Id) ON DELETE SET NULL,
    CONSTRAINT FK_Match_Stadium     FOREIGN KEY (StadiumId)  REFERENCES dbo.Stadium (Id) ON DELETE SET NULL,
    CONSTRAINT FK_Match_HomeTeam    FOREIGN KEY (HomeTeamId) REFERENCES dbo.Team    (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Match_AwayTeam    FOREIGN KEY (AwayTeamId) REFERENCES dbo.Team    (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_Match_Status      CHECK (Status IN (N'Scheduled', N'Live', N'Finished', N'Postponed', N'Cancelled')),
    CONSTRAINT CK_Match_DiffTeams   CHECK (HomeTeamId <> AwayTeamId)
);
GO

-- =============================================================================
-- 10) MATCH LINEUP  (من لعب في الماتش)
-- =============================================================================
CREATE TABLE dbo.MatchLineup
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    MatchId     INT             NOT NULL,
    TeamId      INT             NOT NULL,
    PlayerId    INT             NOT NULL,

    CONSTRAINT PK_MatchLineup           PRIMARY KEY (Id),
    CONSTRAINT UQ_Lineup_MatchPlayer    UNIQUE (MatchId, PlayerId),
    CONSTRAINT FK_Lineup_Match          FOREIGN KEY (MatchId)  REFERENCES dbo.[Match] (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Lineup_Team           FOREIGN KEY (TeamId)   REFERENCES dbo.Team    (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Lineup_Player         FOREIGN KEY (PlayerId) REFERENCES dbo.Player  (Id) ON DELETE NO ACTION
);
GO

-- =============================================================================
-- 11) MATCH EVENT  (أهداف / صناعة / كروت)
-- =============================================================================
CREATE TABLE dbo.MatchEvent
(
    Id              INT             IDENTITY(1,1) NOT NULL,
    MatchId         INT             NOT NULL,
    TeamId          INT             NOT NULL,
    PlayerId        INT             NOT NULL,          -- scorer / carded player
    AssistPlayerId  INT             NULL,              -- صانع الهدف
    EventType       NVARCHAR(20)    NOT NULL,          -- Goal/Assist/OwnGoal/YellowCard/RedCard/Penalty
    CreatedAt       DATETIME2(0)    NOT NULL CONSTRAINT DF_Event_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_MatchEvent    PRIMARY KEY (Id),
    CONSTRAINT FK_Event_Match   FOREIGN KEY (MatchId)        REFERENCES dbo.[Match] (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Event_Team    FOREIGN KEY (TeamId)         REFERENCES dbo.Team    (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Event_Player  FOREIGN KEY (PlayerId)       REFERENCES dbo.Player  (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Event_Assist  FOREIGN KEY (AssistPlayerId) REFERENCES dbo.Player  (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_Event_Type    CHECK (EventType IN (N'Goal', N'Assist', N'OwnGoal', N'YellowCard', N'RedCard', N'Penalty'))
);
GO

-- =============================================================================
-- 12) PAYMENT  (المدفوعات — رسوم دخول الدوري)
-- =============================================================================
CREATE TABLE dbo.Payment
(
    Id                  INT             IDENTITY(1,1) NOT NULL,
    PayerPlayerId       INT             NOT NULL,
    TeamId              INT             NULL,
    LeagueRegistrationId INT            NULL,
    Amount              DECIMAL(10,2)   NOT NULL,
    Method              NVARCHAR(20)    NOT NULL,          -- Card/Wallet/Cash/Fawry/InstaPay
    Status              NVARCHAR(20)    NOT NULL CONSTRAINT DF_Payment_Status DEFAULT N'Pending', -- Pending/Paid/Failed/Refunded
    ReferenceNumber     NVARCHAR(100)   NULL,              -- gateway transaction id
    PaymentResponse     NVARCHAR(MAX)   NULL,              -- raw JSON response from the gateway
    CreatedAt           DATETIME2(0)    NOT NULL CONSTRAINT DF_Payment_CreatedAt DEFAULT SYSUTCDATETIME(),
    PaidAt              DATETIME2(0)    NULL,

    CONSTRAINT PK_Payment           PRIMARY KEY (Id),
    CONSTRAINT FK_Payment_Player    FOREIGN KEY (PayerPlayerId)        REFERENCES dbo.Player             (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Payment_Team      FOREIGN KEY (TeamId)               REFERENCES dbo.Team               (Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Payment_LeagueReg FOREIGN KEY (LeagueRegistrationId) REFERENCES dbo.LeagueRegistration (Id) ON DELETE NO ACTION,
    CONSTRAINT CK_Payment_Method    CHECK (Method IN (N'Card', N'Wallet', N'Cash', N'Fawry', N'InstaPay')),
    CONSTRAINT CK_Payment_Status    CHECK (Status IN (N'Pending', N'Paid', N'Failed', N'Refunded'))
);
GO

-- =============================================================================
-- 13) NOTIFICATION  (إشعارات عامة لكل اللاعبين)
-- =============================================================================
CREATE TABLE dbo.Notification
(
    Id          INT             IDENTITY(1,1) NOT NULL,
    Title       NVARCHAR(150)   NOT NULL,
    Body        NVARCHAR(500)   NULL,
    Link        NVARCHAR(400)   NULL,
    CreatedAt   DATETIME2(0)    NOT NULL CONSTRAINT DF_Notification_CreatedAt DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Notification PRIMARY KEY (Id)
);
GO

PRINT N'الحجز الممتاز schema created successfully.';
GO
