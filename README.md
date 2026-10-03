# Hugo for Zed

Highlighting for Hugo templates: Go template syntax with HTML injected around it.
Function lists and snippets are derived from
[language-hugo-vscode](https://github.com/theNewDynamic/language-hugo-vscode) (Apache-2.0).

## Setup

1. In `extension.toml`, set `rev` to a real commit SHA of tree-sitter-go-template.
2. Install Rust (rustup), then in Zed: Extensions -> Install Dev Extension -> pick this folder.
3. Map your layouts to the language in Zed `settings.json`:

```json
{
  "file_types": {
    "Hugo": ["layouts/**/*.html", "themes/**/layouts/**/*.html"]
  }
}
```

4. Snippets load automatically from `snippets/hugo.json`; if they do not appear, run `snippets: configure snippets` and paste `snippets/manual-no-scope.json`
   into the HTML snippets file (and `snippets/markdown.json` into Markdown).

## Debugging

`zed: open log` shows query errors. A node name that doesn't exist in your
grammar revision invalidates the whole `.scm` file; compare against
`queries/highlights.scm` in the grammar repo and adjust.

## Known gaps

- `{{< shortcode >}}` / `{{% shortcode %}}` are not valid Go template syntax and will
  likely produce error nodes. Needs a grammar fork or extra handling.
- Markdown content files are not covered yet.
