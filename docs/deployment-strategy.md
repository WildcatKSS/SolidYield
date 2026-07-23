# Deployment Strategy

## Status

TBD_AFTER_STACK_AND_PLATFORM_SELECTION

## Environments

- Local
- Preview
- Production

## Deployment Gate

- CI passed
- Security checks passed
- Migration reviewed
- Rollback path documented
- Monitoring configured

## Rollback

TBD_AFTER_PLATFORM_SELECTION

## Secrets

Use platform secrets. Never commit production secrets.

## Database Migrations

Require review before production deploy.
