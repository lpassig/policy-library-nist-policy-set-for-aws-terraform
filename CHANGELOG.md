# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.2] - 2026-04-27

### Added

- [docs/nist-control-mapping.md](docs/nist-control-mapping.md): traceability matrix for all `sentinel.hcl` policies (NIST SP 800-53 Rev 5 framing, plan-only rows for AC-1, AT-2, CA-2, IR-4, PS-3; per-policy rows with **Needs validation** until specific 800-53 control IDs are reviewer-approved).
- `scripts/check-docs-presence.sh`, `scripts/check-hcl-sources.sh`, `scripts/check-nist-mapping.sh` and `make hygiene` for local/CI validation.
- CI job `repo-hygiene` running the three scripts on every push/PR.

### Changed

- Replaced invalid `collection.filter` usage (not available in Sentinel 0.26) with the built-in `filter` form and small helper functions in seven policies so the full suite passes on Sentinel 0.26.x:
  - `policies/ecs/ecs-task-definitions-should-not-use-host-network-mode.sentinel`
  - `policies/cloudtrail/cloudtrail-lake-event-data-stores-should-be-encrypted-with-customer-managed-aws-kms-keys.sentinel`
  - `policies/cloudwatch/cloudwatch-log-groups-should-be-retained-for-a-specified-time-period.sentinel`
  - `policies/dynamodb/dynamodb-tables-should-be-present-in-a-backup-plan.sentinel`
  - `policies/rds/rds-for-mariadb-db-instances-should-publish-logs-to-cloudwatch-logs.sentinel`
  - `policies/rds/rds-for-sql-server-db-instances-should-publish-logs-to-cloudwatch-logs.sentinel`
  - `policies/redshiftserverless/redshift-serverless-namespaces-should-not-use-the-default-database-name.sentinel`

### Fixed

- [sentinel.hcl](sentinel.hcl): removed duplicate `min_password_reuse_prevention_param` key in `iam-password-policy-strong-configuration` params (effective value remains **24**).
- [.github/workflows/ci.yml](.github/workflows/ci.yml): install Sentinel with `hashicorp/setup-sentinel@v1` and version `0.26.4` (replaces unset `inputs.sentinel-version` on the previous installer).
- [docs/policies/s3-bucket-should-be-encrypted-at-rest.md](docs/policies/s3-bucket-should-be-encrypted-at-rest.md): corrected policy name typos (`s3-bucket=` to `s3-bucket-`).
- Renamed five policy docs so filenames match `sentinel.hcl` policy block names (RDS deletion protection and IAM-auth variants; CloudFront `tsl` to `tls` in the filename). README links updated accordingly.

### Removed

- `modules/.DS_Store` from version control; `.gitignore` now ignores `.DS_Store`.

[Unreleased]: https://github.com/hashicorp/policy-library-nist-policy-set-for-aws-terraform/compare/v1.0.2...HEAD
[1.0.2]: https://github.com/hashicorp/policy-library-nist-policy-set-for-aws-terraform/releases/tag/v1.0.2
