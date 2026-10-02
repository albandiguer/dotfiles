# graphify — code/doc knowledge graph

Builds a persistent knowledge graph (`graphify-out/`: `GRAPH_REPORT.md`, `graph.json`,
optionally `wiki/`) of a repo plus its docs, then answers architecture questions from the graph
instead of grepping. Installed as a uv tool (see `uv-tool-installs.md`).

```bash
graphify .                  # full build: code + docs, needs an LLM key (e.g. DEEPSEEK_API_KEY)
graphify . --code-only      # code only, local AST, no API key
graphify update .           # incremental re-extract after code changes, no LLM
graphify query "how does X relate to Y"
graphify path "A" "B"
graphify explain "X"
```

`graphify .` is shorthand for `graphify extract .`. Install the agent skill once with
`graphify install --platform pi`.

## Shell completion (fish)

graphify ships no completion generator, so it has no completion.
