Code for a personal academic website.

Run locally with Docker

Prerequisites: Docker Desktop (or another Docker runtime) and docker-compose.

From the repository root (PowerShell):

```powershell
# Build and start the site (rebuilds the image if Dockerfile changed)
docker-compose up --build

# If you prefer to run detached:
docker-compose up --build -d

# Stop the site (if running detached):
docker-compose down
```

Visit http://localhost:1313 to preview the site. The following pages were added as a basic academic scaffold:

- Home: `/`
- Research: `/research/`
- Teaching: `/teaching/`
- Publications (list via shortcode): `/publications/`
- Citations (formatted references): `/citations/`
- CV (PDF link): `/cv/` (points to `static/uploads/resume.pdf`)

If Hugo modules fail to download while building, run:

```powershell
docker-compose run --rm hugo hugo mod get -u
```

Troubleshooting: "no configuration file provided: not found"

- If you see: `no configuration file provided: not found` when running `docker-compose up --build`, it's usually because your Docker installation expects the Compose V2 CLI `docker compose` instead of the legacy `docker-compose`, or because no compose file was found in the current directory.
- This repository includes both `docker-compose.yml` and `docker-compose.yaml`. Use the newer command if available:

```powershell
docker compose up --build
```

- Or run the included PowerShell helper which detects the available command:

```powershell
.\run.ps1
```

