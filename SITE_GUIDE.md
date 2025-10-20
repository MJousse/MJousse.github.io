# Site Guide — How to customize this academic website

This guide explains how to edit content, styles, and publish the site to GitHub Pages. The repository is a small static site with the following key files:

- `index.html` — homepage
- `about.html` — about page
- `publications.html` — publications list
- `assets/css/style.css` — site styles
- `cv.pdf` — PDF (CV) linked from the site
- `.nojekyll` — prevents GitHub Pages from ignoring files starting with `_`

## Editing content

1. Open the file you want to edit (e.g. `index.html`) in your editor.
2. Update headings, paragraphs, and links. These are plain HTML files — no templating required.
3. Save changes and preview locally by opening `index.html` in your browser, or run a local web server:

```powershell
# From repository root
# Python 3
python -m http.server 8000
# Now open http://localhost:8000 in your browser
```

## Styling

- Edit `assets/css/style.css` to change colors, spacing, fonts, etc.
- Add images to `assets/` (e.g. `assets/img/`) and reference them from HTML with `/assets/img/your-image.jpg`.

## Adding pages

1. Create a new file `my-page.html` at the repo root (or in a folder) and include a link to it from the nav in `index.html`.
2. Keep relative links consistent — when linking from the root, use `/my-page.html`.

## Publishing to GitHub Pages manually

### Option A — Quick manual update to `gh-pages` (force-overwrite)

This updates the `gh-pages` branch with your current files and overwrites history. Use when you're ready to publish and accept replacing remote branch content.

```powershell
git switch main
git add index.html about.html publications.html assets cv.pdf .nojekyll
git commit -m "Publish site updates" || Write-Host "No changes to commit"
# Force-push current HEAD to gh-pages branch (overwrites remote gh-pages)
git push origin HEAD:gh-pages --force
```

### Option B — Orphan branch (clean gh-pages history)

This creates a temporary orphan branch containing only site files, pushes it to `gh-pages` and deletes the temp branch.

```powershell
# Create an orphan branch
git switch --orphan publish-temp
git reset --hard
# Add only site files from working tree
git add index.html about.html publications.html assets cv.pdf .nojekyll
git commit -m "Publish site (orphan branch)"
git push origin publish-temp:gh-pages --force
git switch main
git branch -D publish-temp
```

## Remove GitHub Actions workflows (if needed)

If there are workflows in `.github/workflows/` you don't want to run, delete them and push the deletion:

```powershell
git rm .github/workflows/deploy-static.yml
git commit -m "Remove CI workflow"
git push origin main
```

Note: if the file doesn't exist locally, use `git status` and `git ls-files .github/workflows` to find the exact filename.

## Enable Pages

1. Go to your repository on GitHub → Settings → Pages.
2. Select the `gh-pages` branch and root folder (`/`). Save.
3. After a minute or two the site should be available at `https://<your-username>.github.io/<repo-name>/` (or `https://<your-username>.github.io/` for user repos named `<username>.github.io`).

## Troubleshooting

- 404 after publish: ensure `index.html` exists at the root of the `gh-pages` branch.
- Actions still running after deletion: confirm you committed and pushed the workflow removal. Removing the file locally is not enough; push the deletion.
- Page not updating: try clearing GitHub Pages cache by making a small commit and re-pushing, or wait a few minutes for GitHub to propagate changes.

If you want, I can:
- Add a simple template for publications loaded from `data/` files (CSV or YAML).
- Convert the static site into a small Hugo site so you can use templates and shortcodes.

If you run into any git errors while publishing, paste the terminal output here and I'll help fix it.
