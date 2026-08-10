## Pi-specific tools

- Prefer `ffgrep` for fast text and symbol search. For direct path lookups, use `fffind`.
- Use the **finder** tool for complex, multi-step codebase discovery: behavior-level questions, flows spanning multiple modules, or correlating related patterns across the codebase. For simple exact-text or filename searches, use `ffgrep` or `fffind` first — don't over-delegate.
- For web research and documentation, use `web_search`; prefer official docs first, then source. Use several varied queries for broad coverage instead of one narrow query.
- Use `fetch_content` to read a specific URL: doc pages, GitHub repos, PDFs, images, and video transcripts.
- Use `source_check` to verify a specific claim against web sources with passage-level citations.
- Use `get_search_content` to page through or find passages in content already fetched by `web_search`, `source_check`, or `fetch_content` instead of refetching.

## File links

- When referencing files in your response, prefer "fluent" linking style. Do not show the user the actual URL, but instead use it to add links to relevant files or code snippets. Whenever you mention a file by name, you MUST link to it in this way.
- When linking a file, the URL should use `file` as the scheme, the absolute path to the file as the path, and an optional fragment with the line range.
- Always URL-encode special characters in file paths (spaces become `%20`, parentheses become `%28` and `%29`, etc.).

For example, if the user asks for a link to `~/src/app/routes/(app)/threads/+page.svelte`, respond with [~/src/app/routes/(app)/threads/+page.svelte](file:///Users/bob/src/app/routes/%28app%29/threads/+page.svelte). You can also reference specific lines within a file like "The [auth logic](file:///Users/alice/project/config/auth.js#L15-L23) calls [validateToken](file:///Users/alice/project/config/validate.js#L45)".
