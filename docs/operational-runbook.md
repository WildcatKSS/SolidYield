# Operational Runbook

## Application Down

1. Check uptime monitor
2. Check hosting platform
3. Check recent deployments
4. Check logs
5. Roll back if needed

## Payment Issue

1. Check the billing provider dashboard (Stripe in the default stack hypothesis)
2. Check webhook logs
3. Check application logs
4. Retry or reconcile

## API Cost Spike

1. Check usage metrics
2. Enable stricter rate limits
3. Disable high-cost workflows if needed
4. Review unit economics

## Security Alert

1. Assess severity
2. Contain
3. Patch
4. Rotate secrets if needed
5. Document incident
