# GitHub Workflows

This directory contains GitHub Actions workflows for monitoring and scanning Azure Functions Core Tools releases.

## Workflows

### 1. Check Azure Functions Core Tools Latest Release (`check-azure-functions-release.yml`)

**Purpose:** Monitors the Azure Functions Core Tools repository for new releases.

**Triggers:**

- Manual execution via workflow_dispatch
- Daily schedule at 8 AM UTC

**Features:**

- Fetches latest release information from GitHub API
- Tracks release changes
- Displays release information in job summary
- Commits release tracking information
- Explicitly dispatches the scan workflow after successfully pushing a new release update

### 2. Download and Scan with VirusTotal (`virustotal-scan.yml`)

**Purpose:** Downloads Azure Functions Core Tools binaries and scans them with VirusTotal.

**Triggers:**

- Manual execution via workflow_dispatch
- Explicit workflow_dispatch from the release check workflow when a new release is detected and its tracking update is pushed successfully

**Features:**

- Downloads binaries for multiple platforms (Linux, Windows, macOS)
- Submits files to VirusTotal for scanning
- Automatically retries querying analysis status up to 10 times until completed
- Generates scan result summaries and detection statistics
- Uploads scan results and scanned files as artifacts

**Requirements:**

- `VTCLI_APIKEY` secret must be configured in the repository settings

## Setup

### VirusTotal API Key

To use the VirusTotal scanning functionality:

1. Get a VirusTotal API key from <https://www.virustotal.com/gui/join-us>
2. Add it as a repository secret named `VTCLI_APIKEY`:
   - Go to repository Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `VTCLI_APIKEY`
   - Value: Your VirusTotal API key

### Permissions

The workflows require the following permissions:

- `contents: write` (for committing release tracking files)
- `actions: write` in the release check workflow (for dispatching the scan workflow)

## Usage

### Manual Execution

Both workflows can be triggered manually:

1. Go to the "Actions" tab in your repository
2. Select the desired workflow
3. Click "Run workflow"

### Automatic Execution

- The release check workflow runs daily to monitor for new releases
- The VirusTotal scan workflow automatically triggers when new releases are detected
- Checks with no new release do not trigger a scan
- The check dispatches the scan on the same branch using `GITHUB_TOKEN`; explicit workflow_dispatch events are allowed even though pushes made with that token do not trigger workflows
- Commit, push, and dispatch failures fail the check workflow rather than being ignored

## Output

### Release Check Workflow

- Displays latest release information in the job summary
- Updates `last_release.txt` with the current release tag

### VirusTotal Scan Workflow

- Provides detailed scan results in the job summary (malicious, suspicious, undetected, harmless)
- Uploads scanned files as artifacts
- Implements automatic retry logic for analysis completion
- Links to full VirusTotal reports

## Customization

You can customize these workflows by:

- Modifying the schedule in the release check workflow
- Adding additional platforms to scan
- Implementing notification systems (Slack, email, etc.)
- Adding additional security scanning tools
- Creating issues automatically for new releases or security findings
