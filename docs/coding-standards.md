# Coding Standards

## Product-Neutral Rule

Do not add product-specific code before product selection and MVP Gate approval.

## Language Standards

The language is part of the Default Stack Hypothesis in `docs/architecture.md` and is only final after a tech-stack ADR. If TypeScript is confirmed:

- strict mode
- avoid `any`
- validate external input
- separate business logic from UI

If another language is chosen, replace this section in the same ADR.

## Security

- no secrets in repository
- least privilege
- authorization checks near data access
- rate limit sensitive endpoints

## Testing

- unit tests for business logic
- integration tests for API/database
- E2E tests for critical flows

## Maintainability

- small modules
- explicit boundaries
- readable names
- minimal dependency surface
