# bt-applications

A FiveM job application script that lets players submit applications for in-game jobs directly through an interactive UI. Submissions are delivered to a Discord channel via webhook as a formatted embed.

---

## Features

- Interact with an in-world terminal using `ox_target` to open an application form
- Dynamically driven by config — add as many job types as you want
- Responses delivered to Discord as a formatted embed including the player's name, identifier, and timestamp
- Per-player cooldown to prevent spam submissions
- Server-side input validation and answer length capping

---

## Dependencies

| Dependency | Link |
|---|---|
| [ox_lib](https://github.com/overextended/ox_lib) | UI dialogs and notifications |
| [ox_target](https://github.com/overextended/ox_target) | In-world interaction zones |

---

## Installation

1. Download or clone this repository into your server's `resources` folder:
   ```
   resources/[scripts]/bt-applications/
   ```

2. Add the following to your `server.cfg`:
   ```
   ensure bt-applications
   ```

3. Open `config.lua` and configure your jobs (see below).

---

## Configuration

All configuration is done inside `config.lua`.

### Adding a Job

Each entry inside `Config.Applications` is one job type. Copy and paste the block below for each job you want to add:

```lua
Config.Applications = {
    ["job1"] = {
        label = "A cool job",           -- Displayed in the UI and Discord embed title
        questions = {
            "Question 1",               -- Add or remove questions as needed
            "Question 2",
            "Question 3",
        },
        location = vector3(0.0, 0.0, 0.0),  -- Coords of the in-world application terminal
        webhook = "https://discord.com/api/webhooks/your_webhook_id/your_webhook_token"
    },
}
```

> **Note:** Replace `location` with the actual in-game coordinates and `webhook` with a real Discord webhook URL. Never share your webhook URL publicly.

### Getting a Discord Webhook URL

1. Open your Discord server
2. Go to **Server Settings > Integrations > Webhooks**
3. Click **New Webhook**, select the channel, and copy the URL
4. Paste it into the `webhook` field in `config.lua`

---

## How It Works

### Client (`client.lua`)
- On resource start, iterates through `Config.Applications` and creates an `ox_target` box zone at each configured location
- When a player interacts with the zone, an `ox_lib` input dialog is shown with the configured questions
- On submit, the answers are sent to the server via `application:submit`

### Server (`server.lua`)
- Validates that the application exists, answers are the correct type and count, and the player is not on cooldown
- Sanitises each answer to the configured max length
- Builds a Discord embed containing the player's name, identifier, all Q&A pairs, and a UTC timestamp
- Sends the embed to the configured webhook via `PerformHttpRequest`

---

## Discord Embed Preview

```
PlayerName - A cool job
────────────────────────
Q1: Question 1
A1: Player's answer

Q2: Question 2
A2: Player's answer

ID: license:xxxxxxxxxxxxxxxx    |    2026-04-25T10:00:00Z
```

---

## File Structure

```
bt-applications/
├── fxmanifest.lua   — Resource manifest
├── config.lua       — All configuration (jobs, questions, webhooks)
├── client.lua       — Interaction zones and input dialog
└── server.lua       — Validation, cooldowns, and webhook delivery
```

---

## License

This resource is free to use and modify for personal or server use.
