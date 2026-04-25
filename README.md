# bt-applications

A fivem job application script. Players walk up to a terminal, fill out a form and it gets sent to discord. Thats basically it.

---

## Dependencies

you need these or it wont work

- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)

---

## install

1. drop the folder into your resources
   ```
   resources/[scripts]/bt-applications
   ```

2. add to server.cfg
   ```
   ensure bt-applications
   ```

3. configure config.lua (see below)

---

## Configuration

edit config.lua, its pretty self explanatory


to add a job just copy this and change the values:

```lua
["job1"] = {
    label = "Job Name",
    questions = {
        "Question 1",
        "Question 2",
        "Question 3",
    },
    location = vector3(0.0, 0.0, 0.0), -- coords for the terminal
    webhook = "https://discord.com/api/webhooks/your_webhook_id/your_webhook_token"
},
```

**dont share your webhook url**

### getting a webhook url
1. discord server settings > integrations > webhooks
2. new webhook, pick your channel, copy the url
3. paste it in config

---

## how it works

**client** - creates an ox_target zone at the coords you set. player walks up, interacts, fills in the questions and hits submit. sends the answers to the server.

**server** - checks the player isnt on cooldown, validates the answers, then builds a discord embed and posts it to the webhook. logs to console if the webhook fails.

### what the discord embed looks like

```
PlayerName - Job Name
Q1: Question 1
A1: their answer

Q2: Question 2
A2: their answer

ID: license:xxxxxxxx  |  2026-04-25T10:00:00Z
```

---

## files

```
bt-applications/
├── fxmanifest.lua
├── config.lua
├── client.lua
└── server.lua
```

---

free to use, do whatever with it
