# Ultimate Reply Guy Blueprint

The complete guide to mastering X (Twitter) replies, growing your audience, and monetizing as a reply guy.

## Quick Start

```bash
ruby server.rb
```

- **Landing / Sales Page:** `http://localhost:9191/`
- **The Guide (3 modules):** `http://localhost:9191/guide.html`
- **Resources & Tools:** `http://localhost:9191/resources.html`

## ⚠ Before Going Live

Replace the placeholder wallet addresses in `server.rb`:

```ruby
WALLETS = {
  'ETH' => 'YOUR_REAL_ETH_ADDRESS',
  'BTC' => 'YOUR_REAL_BTC_ADDRESS',
  'SOL' => 'YOUR_REAL_SOL_ADDRESS'
}
```

## Access Codes

Edit `ACCESS_CODES` in `server.rb` to add/remove codes as you sell:

```ruby
ACCESS_CODES = ['BLUEPRINT2026', 'REPLYGAMAX', 'ULTIMATE']
```

## How It Works

1. Customer lands on the sales page
2. Chooses ETH, BTC, or SOL payment
3. Sends $25 worth of crypto to your wallet
4. Contacts you with TX hash → you give them an access code
5. They enter the code on the guide/resources page → content unlocks
6. Access is saved in browser (localStorage)

## Deploy on Render

1. Push to GitHub
2. Create Web Service on Render, connect repo
3. Live at `https://reply-guy-blueprint.onrender.com/`

## Content

- **Module 1:** The Craft of Replying (structures, timing, psychology)
- **Module 2:** Audience Growth (pipeline, persona, daily quota)
- **Module 3:** Monetization (6 strategies, the monetization stack)
- **Resources:** Tools, templates, tracker, niche checklist