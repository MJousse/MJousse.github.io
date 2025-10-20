Param(
	[string]$Service = 'hugo'
)

Write-Host "Starting Hugo via Docker Compose..."

# Prefer `docker compose` (Compose V2) if available
try {
	$composeV2Check = docker compose version 2>&1
	if ($LASTEXITCODE -eq 0) {
		Write-Host "Using 'docker compose' (v2+)"
		docker compose up --build $Service
		exit $LASTEXITCODE
	}
} catch {
	# ignore
}

# Fallback to docker-compose
if (Get-Command 'docker-compose' -ErrorAction SilentlyContinue) {
	Write-Host "Using 'docker-compose' (v1)"
	docker-compose up --build $Service
	exit $LASTEXITCODE
}

Write-Error "Neither 'docker compose' nor 'docker-compose' is available. Please install Docker Desktop with Compose support."
