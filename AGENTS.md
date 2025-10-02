# Repository Guidelines

## Project Structure & Module Organization
- `init.lua` boots core options and lazy.nvim; wire new high-level features here to keep startup deterministic.
- `lua/configs/` hosts runtime settings such as `options.lua` and `keymaps.lua`; place additional configuration modules beside them and require them explicitly.
- `lua/plugins/` groups lazy.nvim specs by topic (UI, LSP, tooling); each file must return a table of plugin definitions to keep auto-loading predictable.
- `lazy-lock.json` pins plugin versions and should change only after a successful `Lazy sync`; review `KEYS.md` when adjusting bindings documented there.

## Build, Test, and Development Commands
- `nvim --headless "+Lazy sync" +qa` installs or updates plugins to match the specs in `lua/plugins`.
- `nvim --headless "+Lazy clean" +qa` prunes plugins no longer declared; run it before committing the lockfile.
- `nvim --headless "+MasonUpdate" +qa` refreshes language servers and debuggers listed in `mason-lspconfig`.
- Run `:checkhealth` and `:Mason` after major changes to confirm external tools stay available.

## Coding Style & Naming Conventions
- Use four-space indentation in Lua files and keep module names lowercase snake_case (e.g., `configs.keymaps`).
- Require dependencies at the top, return tables from plugin modules, and keep inline functions concise with descriptive locals (`map`, `opts`).
- Preserve existing non-ASCII comments but author new guidance in English; prefer succinct, purposeful comments.
- Formatting is handled through `conform.nvim` and `stylua` (when configured); add formatter options under `lua/configs` rather than inlined per file.

## Testing Guidelines
- Smoke-test startup with `nvim --clean -u init.lua` to ensure the config bootstraps without user overrides.
- Trigger `:Lazy health` and `:checkhealth mason` to surface missing binaries or plugin errors after dependency updates.
- When introducing keymaps or commands, verify they appear in `KEYS.md` and exercise them in a throwaway buffer before shipping.

## Commit & Pull Request Guidelines
- Follow the concise prefixes seen in `git log` (`new:`, `fix:`, `opt.`) followed by a brief imperative summary.
- Limit commits to one logical change; include `lazy-lock.json` updates only when plugin revisions are intentional.
- Pull requests should outline the motivation, affected modules, manual verification steps, and link any related issues.
- Attach screenshots or terminal captures when tweaks affect UI elements like lualine, bufferline, or Telescope layouts.

## Security & Configuration Tips
- Avoid committing machine-specific secrets or API tokens; prefer environment variables consumed by plugins at runtime.
- Review `lazy-lock.json` diffs carefully to ensure third-party updates originate from trusted sources before merging.
