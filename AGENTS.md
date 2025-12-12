# DON repo rules (Arma 3 mission templates)

## Repo intent
- This repo contains MANY separate mission templates (folders by era/theme).
- Shared reusable code lives in /Framework.
- Compositions live in /Composiciones.

## Safety / change scope
- Never mass-edit multiple mission folders.
- Only modify the specific mission folder(s) explicitly mentioned in the task.
- Prefer adding new reusable features to /Framework, and optionally provide a small example in ONE template.
- Do NOT “synchronize” changes across all templates unless explicitly asked.

## Framework conventions
- All reusable systems must be modular and toggleable (true/false) from a simple config file.
- Avoid big refactors. Keep diffs small.
- If a change touches description.ext/CfgFunctions/RscTitles, ensure no duplicate class definitions.

## Third-party
- Do not copy huge third-party libraries into every template.
- Wrap third-party features as a DON module and document how the user installs the dependency.

## Definition of done
- Module wired with a simple toggle + safe defaults.
- README.md explaining usage “para tontos”.
- When disabled, it must not break anything.
