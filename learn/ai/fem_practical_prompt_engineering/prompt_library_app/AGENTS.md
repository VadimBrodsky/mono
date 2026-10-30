# Prompt Library app

- This is a standalone pnpm/Vite package inside the Bazel monorepo, not part of the root Cargo workspace. Run `pnpm dev` and `pnpm build` from this directory.
- `pnpm build` is the available focused verification; `package.json` defines no test or lint scripts.
- Bazel's `:app_sources` target includes `src/**` only; it does not run Vite or include the HTML entrypoint in that filegroup.
- Do not commit changes when work is complete; the user will review them manually before committing.
