<p align="center">
  <img src="recursos/identidad/fig/banner.svg" alt="ClaudeDo: aprende Claude haciendo. IA aplicada con criterio." width="760">
</p>

# ClaudeDo

**Aprende Claude haciendo.**

ClaudeDo es una web de autoformación en inteligencia artificial aplicada al trabajo
profesional, la programación y la investigación con Claude y Claude Code. Funciona en macOS
(Terminal, Zsh) y Windows (PowerShell). Cada unidad indica la versión de Claude Code con la
que se comprobó.

Web: <https://me1catrr.github.io/claudedo/>

## Hecho con Claude Code, para aprender Claude Code

El curso es su propio ejemplo: se ha programado, redactado y comprobado con
[Claude Code](https://code.claude.com/docs), y el responsable revisa y decide cada cambio.

| | Fecha | Claude Code |
|---|---|---|
| Creación | octubre de 2026 | 2.1.300 a 2.1.311 |
| Documentación contrastada en las unidades | 23-10-2026 | 2.1.309 |
| Última versión analizada (changelog) | 03-11-2026 | 2.1.317 |
| Última revisión de la web | 03-11-2026 | 2.1.317 |

Las novedades de Claude Code posteriores a la 2.1.309 que aún no están integradas en el texto
aparecen en la web en cajas fucsia «✦ Novedad · por incorporar». Fuente de estas cifras:
`_variables.yml`.

## Unidades

| Área | Unidades |
|---|---|
| **Fundamental** | C0 Fluidez en IA · C1 Claude y el ecosistema Anthropic |
| **Aplicado** | C2 Terminal · C3 Git y worktrees · C4 Claude Code · C5 Programación asistida · C6 Datos e informes |
| **Avanzado** | C7 CLAUDE.md, skills, hooks y MCP · C8 Automatización y agentes · C9 API e investigación |

Cada unidad vive en su carpeta (`c0-fluidez/` … `c9-api/`) con `index.qmd`, `slides.qmd`,
figuras y, cuando procede, código de ejemplo probado en `_ejemplo/`.

Ficheros clave:

- `temario.yml`: fuente de verdad de identificadores, títulos, prerrequisitos, perfiles, temas y áreas.
- `_versiones.yml`: versión y comprobación de cada unidad (indicador bajo el título, `scripts/version_unidad.lua`).
- `_curso/`: plan, estado, decisiones, fuentes y registro verificado de comandos (`comandos.yml`). No se publica.
- `scripts/generar_hoja.jl`: genera la hoja de consulta desde `_curso/comandos.yml`.
- `scripts/auditar_claude.jl`: comprueba la coherencia de versiones y comandos.

Estilos: variables del tema en `marca.scss`; tokens y componentes en `styles.css`. El sitio es
autónomo: no descarga nada al compilar.

## Compilar en local

Requisitos: [Quarto](https://quarto.org/) 1.10. Julia 1.12 solo hace falta para los scripts y
los ejemplos de Julia; Python con [`uv`](https://docs.astral.sh/uv/) para los ejemplos y las
pruebas.

```sh
quarto preview      # vista previa
quarto render       # sitio completo en _site/
```

Ninguna página del sitio ejecuta código al compilar: la publicación no necesita Julia.

## Pruebas

```sh
julia --project=. scripts/auditar_claude.jl --comprobar
julia --project=. scripts/generar_hoja.jl --comprobar
julia --project=. scripts/generar_estructura.jl --comprobar
julia --project=. scripts/compilar_tikz.jl --comprobar
deno test --no-check --allow-read --allow-write recursos/js/ scripts/no_publicar_docs.test.ts
uv run pytest pruebas/web          # tras quarto render (Playwright)
```

Cada unidad indica en su texto cómo ejecutar las pruebas de su `_ejemplo/`.

## Licencias

- **Código:** MIT, véase [`LICENSE`](LICENSE).
- **Textos, diapositivas y figuras:** CC BY-SA 4.0, véase [`LICENSE-CONTENIDO`](LICENSE-CONTENIDO).
- **Datos:** cada conjunto de datos lleva la licencia indicada en su ficha `.meta.toml`.

## Errores, preguntas y sugerencias

Usa los [issues del repositorio](https://github.com/me1catrr/claudedo/issues).

## Aviso

ClaudeDo es un proyecto docente independiente, sin afiliación con Anthropic.
