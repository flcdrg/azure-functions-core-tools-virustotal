# Submit azure-functions-core-tools binaries to VirusTotal

Automatically submit new releases of the Azure Functions Core Tools releases to VirusTotal

## Overview

This repository provides GitHub Actions workflows that:

- Monitor the [Azure Functions Core Tools repository](https://github.com/Azure/azure-functions-core-tools) for new releases
- Automatically download new release binaries
- Submit binaries to VirusTotal for security scanning
- Generate detailed scan reports

## Features

- **🔍 Release Monitoring**: Daily checks for new Azure Functions Core Tools releases
- **📥 Automatic Downloads**: Downloads binaries for multiple platforms (Linux, Windows, macOS)
- **🛡️ Security Scanning**: Submits binaries to VirusTotal for malware detection
- **📊 Detailed Reports**: Provides comprehensive scan results and summaries
- **🔔 Change Tracking**: Tracks and reports when new releases are available

## Quick Start

### 1. Setup VirusTotal API

1. Get a free VirusTotal API key from [virustotal.com](https://www.virustotal.com/gui/join-us)
2. Add it as a repository secret:
   - Go to Settings → Secrets and variables → Actions
   - Create a new secret named `VTCLI_APIKEY`
   - Paste your API key as the value

### 2. Run Workflows

The workflows can be triggered:

- **Automatically**: Daily schedule checks for new releases
- **Manually**: From the Actions tab in GitHub

## Workflows

### Release Monitor (`check-azure-functions-release.yml`)

- Runs daily at 8 AM UTC
- Checks for new Azure Functions Core Tools releases
- Updates release tracking
- Triggers security scanning for new releases

### VirusTotal Scanner (`virustotal-scan.yml`)

- Downloads binaries from latest releases
- Scans files across multiple platforms
- Submits files to VirusTotal and automatically retries analysis status up to 10 times until completed
- Generates security reports and detection statistics
- Stores scan results and scanned files as artifacts

## Scan Results

Scan results include:

- VirusTotal detection statistics (malicious, suspicious, undetected, harmless)
- Links to full VirusTotal reports
- File hashes and metadata
- Platform-specific analysis
- Automatic retry logic for analysis completion

## Documentation

For detailed setup and usage instructions, see [`.github/workflows/README.md`](.github/workflows/README.md).
