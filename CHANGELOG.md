# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-08-01

### Added

- New-ModuleFolders now respects -NoTests, -NoDocs, -NoAnalyzer, and -NoScripts switches.
- Added comprehensive Pester tests for New-ModuleTemplate and New-ModuleFolders switch behavior.
- Added .gitattributes generation to normalize line endings and silence Git CRLF/LF warnings.

### Changed

- Updated Initialize-GitRepository to apply normalization using `git add --renormalize .`.
- Improved orchestrator logic for consistent folder creation across all scaffolding switches.

### Fixed

- Corrected `-and` operator parsing issue in New-ModuleTemplate.

## [1.0.0] - 2026-08-01

### Added

- Initial release.
