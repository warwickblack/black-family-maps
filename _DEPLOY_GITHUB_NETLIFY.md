# Maps: always-latest from one link (GitHub + Netlify auto-deploy)

This sets up the family-history maps the same way as the Neurodevelopmental Hub: one link that
always shows the latest version, on any device, updated automatically whenever you push a change.

## What is already done
- One front door: `index.html` links to `pa-map.html` and `catrijn-map.html`.
- Cross-platform: the deployed maps are the mobile (responsive) variants, so they work on PC, Mac,
  iPhone, iPad and Android. The offline single-file versions are for emailing.
- Already live at https://black-family-maps.netlify.app/ (published from the Netlify CLI).

## What this changes
Right now updates only go live when you run `DEPLOY.sh` by hand. After this one-time setup, updates
go live automatically on `git push`, at the same URL. `DEPLOY.sh` stays as a manual fallback.

---

## One-time setup

### Note: the GitHub repo already exists
The repo `github.com/warwickblack/black-family-maps` is already there, but it was made by uploading
files through the GitHub website, not pushed from this folder. So this folder is not yet connected to
it, and the copy on GitHub is a week old (older than your current pa-map). The steps below connect this
folder to the existing repo and make this folder the source of truth.

### 1. Connect this folder to the existing repo and push the current files
Open Terminal and run, line by line:
```
cd "/Users/warwick/Dropbox/FAMILY HISTORY/black-family-maps-deploy"
git init
git branch -M main
git remote add origin https://github.com/warwickblack/black-family-maps.git
git add -A
git commit -m "Sync local maps bundle as the source of truth"
git push -u origin main --force
```
When it asks to sign in, use username **warwickblack** and your **personal access token** as the
password (the same token you made for the Hub still works, if it has not expired).

The `--force` is deliberate: it replaces the week-old website-uploaded copy on GitHub with your real
working folder, which has the latest maps. From now on, editing here and running `git push` updates
GitHub automatically. (If `git remote add` says origin already exists, run
`git remote set-url origin https://github.com/warwickblack/black-family-maps.git` instead.)

### 1b. Optional, keep the repo tidy
Before the commit you can add a `.gitignore` containing `.DS_Store`, `.netlify/` and `_prev/` so those
are not tracked. Not essential.

### 3. Connect the EXISTING Netlify site to the repo (keeps the URL)
This links your current `black-family-maps.netlify.app` site to GitHub, so the address stays the same.
- Go to app.netlify.com and open the **black-family-maps** project.
- **Site configuration** -> **Build & deploy** -> **Continuous deployment**.
- Under **Repository**, click **Link repository**, choose **GitHub**, and pick `black-family-maps`.
- Build command: leave **blank**. Publish directory: `.` (a single dot). Save.
- Netlify will do a first deploy from GitHub. After that, every push auto-publishes.

If Netlify will not link the existing site, the simple alternative is **Add new project -> Import from
GitHub -> black-family-maps**, then in the old site's settings rename or point your shared link to the
new one. Linking the existing site is preferred because the URL does not change.

### 3b. Pick ONE canonical link, to avoid two live copies
You currently have the maps live in two places: Netlify (black-family-maps.netlify.app) and GitHub
Pages (warwickblack.github.io/black-family-maps, switched on when the files were uploaded). Keep one.
- Recommended: keep **Netlify** (it is the link you have shared, and it matches the Hub). After linking
  the repo in step 3, turn GitHub Pages off in the repo: **Settings -> Pages -> Source -> None**.
- Or, if you would rather use GitHub Pages: skip step 3 entirely. Once step 1 has pushed your folder,
  Pages republishes on every push by itself, and your link becomes
  https://warwickblack.github.io/black-family-maps/ . Then retire the Netlify site.

### 4. Tidy (optional)
- The `.netlify` folder and `DEPLOY.sh` can stay; `DEPLOY.sh` remains a manual fallback.
- Add a `.gitignore` containing `.DS_Store` and `.netlify/` if you would rather not track them.

---

## Updating the maps later (always the latest at the same link)
After any edit, rebuild the variants per the maps skill, then:
```
cd "/Users/warwick/Dropbox/FAMILY HISTORY/black-family-maps-deploy"
git add -A
git commit -m "maps: describe what changed"
git push
```
Netlify rebuilds within a minute. Everyone with https://black-family-maps.netlify.app/ sees the
update. Record the version bump in the project changelog (memoir-document-types rule).

## Sending copies offline
For a copy that opens without setup, send the **offline single-file HTML**
(`pa-map-offline.html` / `catrijn-map-offline.html`). The table works offline; the map tiles still
need the internet. For a quick share, just send the Netlify link.

## Fallback: manual publish without a commit
```
cd "/Users/warwick/Dropbox/FAMILY HISTORY/black-family-maps-deploy"
./DEPLOY.sh
```
This uses the Netlify CLI and the existing site ID. Use it only if you need to publish without pushing
to GitHub.

---

## Review of the current files (25 June 2026)
- index.html: clean single front door, links to both maps, carries the copyright line. Working.
- pa-map.html: Leaflet 1.9.4 loads, map initialises, CARTO tiles, data arrays present, hover live-refresh
  present, all outbound links use target="_blank" rel="noopener". Working. Note: 3.7 MB single file, so
  it is a little slow to load on mobile, expected for the amount of data baked in.
- catrijn-map.html: Leaflet loads, map initialises, data and routes present, outbound link safe. Working.
  (No hover live-refresh in this map; baked enrichment and click popups only. Enhancement, not a fault.)
- Live site verified serving at black-family-maps.netlify.app, /pa-map.html and /catrijn-map.html.
