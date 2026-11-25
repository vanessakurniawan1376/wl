# Lily Plastic — Cirebon Store Website

A real store website and learning project: public category catalogue, individual products, WhatsApp enquiries, and a protected owner editor for products, prices, images and appearance.

## Run on your computer

Install Node.js **24 or newer**, then:

```sh
git clone https://github.com/vanessakurniawan1376/wl.git
cd wl
npm run dev
```

Open `http://127.0.0.1:8787`. Open `/local-login` to try the local owner editor. This loopback-only learning server emulates the production database and uploads with Node SQLite and files in `.dev/`. It is **not** a production deployment server. Local changes don't update the hosted store. Restart the server after code changes.

No npm dependency installation is required.

```sh
npm run build
npm test
```

## Edit the website

| File | Purpose |
| --- | --- |
| `web/index.html` | Public page layout and responsive styles |
| `web/app.js` | Categories, product display, search, WhatsApp enquiries |
| `web/admin.html` | Owner editor forms |
| `web/admin.js` | Product, price, photo and appearance editing |
| `web/admin.css` | Owner editor styling |
| `web/drawings.js` | Category illustrations |
| `worker/index.js` | API, owner authorization, upload validation and HTTP routing |
| `worker/catalog.js` | Categories, default appearance, example variants, input validation |
| `drizzle/` | Versioned database schema migrations |
| `scripts/build.mjs` | Packages web assets into the Worker |
| `scripts/dev.mjs` | Local SQLite/filesystem adapter and learning server |
| `tests/worker.test.js` | API authorization, validation, persistence and concurrency tests |

## Owner editor

On the live website, open `/admin` and sign in with the same ChatGPT account that owns the store. Other accounts and anonymous visitors cannot save changes. The public shop stays open without login.

- **Products & prices:** add products; choose one of six categories; edit name, price in whole rupiah, unit, description and photo; show/hide products.
- **Appearance:** background colour of the main section, brand/button colour, accent colour, main heading, introductory text and hero photo.
- Upload JPG, PNG or WebP files up to 3 MB, or use HTTPS photo URLs.
- Changes become public only after pressing **Simpan**. Uploading a photo alone does not apply it.
- The initial variants are **explicitly labelled examples with no verified prices or inventory**. Replace them with real details and clear their example checkbox. Hiding a product preserves the record.
- An optimistic concurrency check prevents an old product form from overwriting newer edits.

This is a custom editor, not a drag-and-drop page builder. Change source files for layout and features.

## Architecture and hosting

The live app is hosted on ChatGPT Sites using a Cloudflare Worker, D1 database (`DB`) and R2 photo storage (`BUCKET`). Products and appearance persist in the database; customer browsers do not own the master data. Secrets and customer data are not stored in this repository.

The production owner is configured through the server-only `OWNER_EMAIL` runtime secret. Hosted identity comes from the platform's trusted authentication headers. Public write routes reject absent/wrong identity and require a same-origin request. **Never deploy this worker directly behind a host that lets clients spoof these identity headers**; configure an equivalent trusted identity boundary if migrating hosts.

`.openai/hosting.json` records the existing Site identity and bindings. The deploy workflow packages built Worker files and schema migrations, synchronizes the Sites source repository, saves a version and deploys it. **GitHub pushes alone do not currently deploy to the live Site.** The GitHub repo is the editable project source; ChatGPT Sites maintains its separate deployment source. Ask to publish changes from this repo, or configure your own hosting pipeline later.

GitHub Pages alone supports static files and cannot run this owner API/database. Use a Worker-capable host if migrating. A custom domain may be connected to the existing Site; register it in your own account.

## Learning milestones

1. Trace category clicks from `web/app.js` to `/api/catalog`.
2. Replace sample variants with actual shop products and units through the editor.
3. Change typography or card layout in `web/index.html` and run locally.
4. Read the server authorization and same-origin checks; run tests.
5. Add a bounded feature such as a stock-status field with a new schema migration.

No payments, automatic stock counts, delivery quotes or order management are implemented. WhatsApp orders still need shop confirmation.
