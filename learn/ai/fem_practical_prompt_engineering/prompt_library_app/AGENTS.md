# Prompt Library app

- This is a standalone pnpm/Vite package inside the Bazel monorepo, not part of the root Cargo workspace. Run `pnpm dev` and `pnpm build` from this directory.
- `pnpm build` is the package-manager build; `bazel build //learn/ai/fem_practical_prompt_engineering/prompt_library_app:vite_build` runs the hermetic Vite build through `rules_js`. `package.json` defines no test or lint scripts.
- `:app_sources` includes only `src/**`; `:app_inputs` includes the HTML entrypoint and source files used by the Bazel build.
- Do not commit changes when work is complete; the user will review them manually before committing.
