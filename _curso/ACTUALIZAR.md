# Procedimiento: «Actualiza ClaudeDo»

Protocolo reproducible para poner ClaudeDo al día cuando Anthropic publica versiones nuevas de
Claude Code o de los modelos. Basta con pedir «Actualiza ClaudeDo» para que Claude Code lo siga
(lo indica `CLAUDE.md`). Se usó por primera vez en la edición 0.3.0 (25/11/2026).

**Principios.** Se integra, no se acumulan avisos. Se selecciona: el changelog no se copia. Lo
duradero (conceptos) se separa de lo dependiente de versión (comandos, opciones, precios). Nada se
declara comprobado en una versión en la que no se ejecutó. Nada se publica sin revisión humana.

## Fuentes de verdad (no crear registros paralelos)

| Qué | Dónde |
|---|---|
| Unidades, títulos, carpetas, menú | `temario.yml` (+ `scripts/generar_estructura.jl`) |
| Edición del curso, historial público, estado por unidad | `_versiones.yml` (`curso.historial`, `C0`…`C9`) |
| Fechas de revisión, versiones de Claude Code, datos de los modelos | `_variables.yml` (`revision`, `claude-code`, `novedades`, `modelos`) |
| Comandos verificados | `_curso/comandos.yml` (+ `scripts/generar_hoja.jl`) |
| Fuentes | `recursos/bibliografia.bib` (campo `verificado`) y `_curso/FUENTES.md` |
| Selección de novedades (integradas y descartadas, con evidencia) | `_curso/NOVEDADES.md` |
| Decisiones | `_curso/DECISIONES.md`; estado de trabajo en `_curso/ESTADO.md` |

## Pasos

1. **Consultar versiones y novedades oficiales.**
   - Última versión publicada: <https://github.com/anthropics/claude-code/releases> («Latest»).
   - Changelog: <https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md> (texto
     plano; también <https://code.claude.com/docs/en/changelog.md>). Si la sesión no puede
     descargarlo, pedir al responsable que lo guarde con
     `curl -sSL -o /tmp/claudedo-fuentes/CHANGELOG.md <url>` o leerlo por tramos con el lector web.
   - Modelos y precios: `platform.claude.com/docs/en/about-claude/{models/overview,pricing,model-deprecations}`
     y anuncios en <https://www.anthropic.com/news>.
   - Versiones locales: la de la sesión (`/status`; en la aplicación de escritorio, también la ruta
     de `$CLAUDE_CODE_EXECPATH`) y la de la terminal (`claude --version`, `which -a claude`). Son
     cosas distintas: se anotan las dos.
2. **Comparar con la última versión integrada**: `claude-code.integrada` de `_variables.yml` y
   `claude_code_documentada` de cada unidad en `_versiones.yml`.
3. **Identificar las unidades afectadas**: con el índice de secciones
   (`grep -n "^### " c*/index.qmd`) y `comandos.yml` (`unidades:` de cada comando).
4. **Seleccionar las novedades relevantes** en `_curso/NOVEDADES.md`, una tabla por edición:
   versión, novedad, unidad y sección, evidencia (E ejecución · S simulación · D documentación ·
   C changelog · P pendiente). Descartar con motivo lo que no tiene valor formativo (correcciones
   menores, proveedores de nube, funciones de organización, betas no documentadas). Contrastar cada
   seleccionada con la página vigente de `code.claude.com/docs/en/<página>.md`; si las fuentes
   discrepan, se dice en el texto.
5. **Actualizar contenido y ejemplos** en la sección correspondiente, con la plantilla y el orden de
   secciones intactos y sin cambiar anclas. Cada funcionalidad nueva responde, cuando proceda, a:
   qué es, para qué sirve, cómo se usa, un ejemplo y cómo se comprueba. Se actualizan también
   ejercicios, prácticas, diapositivas y la hoja de consulta. Los datos de modelos se cambian solo
   en `_variables.yml` (las páginas los leen con `{{< var modelos.… >}}`). Si algo no se puede
   integrar todavía, se señala con una caja `.novedad` («por incorporar», ver `CLAUDE.md`); al
   integrarlo, la caja desaparece.
6. **Comprobar comandos y funcionalidades** con el binario disponible, sin gastar ni llamar a la red
   salvo autorización: `claude --help`, `claude <subcomando> --help`, opciones aceptadas o rechazadas
   (`claude --bare -p --opción … ` sin clave falla en la autenticación, después del análisis de
   opciones), `claude doctor`. Lo ejecutado se registra en `comandos.yml` con
   `verificado_en: "Claude Code <binario> (instalado) · DD/MM/AAAA"`; lo contrastado solo con la
   documentación, con `(doc)`.
7. **Actualizar metadatos, bibliografía e historial**:
   - `_versiones.yml`: `curso` (edición, fecha, versiones consultada/integrada/comprobada, modelos) y
     una entrada nueva al principio de `curso.historial` con `cambios` (unidad, sección, texto,
     evidencia) y `pendientes`; en cada unidad tocada, `version`, `actualizado`,
     `claude_code_documentada`, `claude_code_instalada`, `nota` (conservando las limitaciones
     anteriores) e `historial`. `estado: verificado` solo tras ejecutar la comprobación.
   - `_variables.yml`: `revision` (fecha y versión de la sesión), `claude-code`, `novedades`,
     `modelos`. `creacion` no se toca.
   - `recursos/bibliografia.bib`: fechas de consulta y campo `verificado`; `_curso/FUENTES.md`.
   - Portada (`index.qmd`, sección «Novedades»: resumen de la última edición con enlace a
     «Actualizaciones»), `about.qmd` y `README.md` (a mano).
8. **Regenerar y comprobar la web**:
   ```
   julia --project=. scripts/generar_estructura.jl --comprobar
   julia --project=. scripts/auditar_claude.jl --comprobar
   julia --project=. scripts/generar_hoja.jl [--comprobar]
   julia --project=. scripts/generar_bibliografia.jl --comprobar
   quarto render
   ```
   y las pruebas afectadas: Deno (`deno test recursos/js/`), pytest y Julia de los `_ejemplo/`
   tocados, pruebas web (`uv run pytest pruebas/web`). Revisar en local con `quarto preview`.
9. **Revisar y publicar**: commits pequeños en español («Actualiza C4 a Claude Code 2.1.332»), con
   `_variables.yml` (`revision`) en el mismo commit que cierra la revisión. Se entrega un informe
   (versiones, modelos, unidades, novedades incorporadas y descartadas, pruebas y limitaciones,
   commits). **El `git push` y la publicación en GitHub Pages los autoriza el responsable después de
   revisar la web local.**

## Lecciones de la edición 0.3.0

- El changelog pesa más de 1 MB: el lector web devuelve resúmenes y citas cortas. Leer por tramos
  y no fiarse de un resumen que contradiga el texto literal (dos resúmenes afirmaron versiones
  inexistentes o ausentes).
- `--max-turns` no aparece en `claude --help` (2.1.330) pero el binario lo acepta y la referencia
  de la CLI lo documenta: comprobar aceptando la opción, no buscándola en la ayuda.
- Al arrancar, Claude Code avisa de reglas `allow` con comodines peligrosos en la configuración
  global del responsable: se informa, no se toca (configuración global).
