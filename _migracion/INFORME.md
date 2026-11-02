# Informe de migración: vía C de Resonancia → ClaudeDo

Fecha: 2 de noviembre de 2026. Origen: `me1catrr/resonancia`, commit `f677c80` (los commits
posteriores de `main` no tocan `claude/`). Nota de trabajo: no se publica (prefijo `_`).

## Qué se ha hecho

| Paso | Commit | Contenido |
|---|---|---|
| Importación literal | `Importa la vía C desde resonancia@f677c80` | `git archive` de los ficheros versionados necesarios, con sus rutas originales |
| Reorganización | `Reorganiza la vía C en la raíz del sitio` | `git mv` de todo `claude/` a la raíz (unidades, portada, hoja, `descargas/`, `_curso/`, `_versiones.yml`) |
| Rutas | `Adapta las rutas de la vía C a un sitio autónomo` | `adaptar.jl`: 27 sustituciones explícitas con recuento comprobado; 24 rutas `claude/…` citadas en las instrucciones |
| Sitio | `Configura ClaudeDo como sitio Quarto autónomo` | `_quarto.yml`, `temario.yml` (solo C, con áreas), navegación, identidad violeta, bibliografía (46 de 136), scripts de C, `Pkg.rm("Resonancia")` |
| Documentación | `Adapta la documentación a ClaudeDo` | README, CLAUDE.md, «Acerca de», CITATION.cff, plantilla de erratas |
| Tema | `Pasa los acentos de ClaudeDo a un tema SCSS` | `marca.scss` en lugar de `_brand.yml` (evita ids repetidos en el `<head>`) |

Mapa: `claude/<unidad>/` → `<unidad>/` (URL: `/resonancia/claude/c4-claude-code/` →
`/claudedo/c4-claude-code/`). Identificadores C0–C9 y slugs sin cambios (decisión del 23/10/2026).

No se tocan las rutas con «../» que son contenido didáctico: `../../CLAUDE` y `../../secreto` (C7),
`../viga-otro` (C3), `../ruta` (hoja de consulta) y las del proyecto de ejemplo de C2.

**Áreas.** Fundamental (C0–C1), Aplicado (C2–C6) y Avanzado (C7–C9): son los itinerarios que ya
tenía la portada original. Agrupan la barra lateral sin cambiar carpetas; `CLAUDE.md` explica cómo
añadir un área futura.

## Comprobaciones (todas en local)

| Comprobación | Resultado |
|---|---|
| Ficheros de `claude/` con destino | 111 de 111 |
| Datos `datos/sinteticos/curso-claude/` | idénticos byte a byte a los de Resonancia |
| Recuentos | 10 unidades, 10 diapositivas, 100 ejercicios, 11 TikZ, 10 portadas |
| `quarto render` completo | sin avisos (ninguna página ejecuta código) |
| `pruebas/web` (Playwright: 5 anchuras, accesibilidad, enlaces, simulaciones C0 y C4) | 97 pasan |
| pytest de `_ejemplo/` | C2 6, C5 10, C6 8, C7 6, C9 26: todas pasan |
| Julia de `_ejemplo/` | C5 y C6 `runtests.jl` y C9 `puente.jl` (4): pasan |
| `probar_hooks.sh` (C7) y `probar_tarea.sh` (C8) | 14 y 15 OK |
| Deno (`recursos/js/`, componentes, `no_publicar_docs`) | 33 pasan |
| `auditar_claude.jl --comprobar` | correcta, con 2 avisos previos (`gh-pr` y `gsd` pendientes de verificar) |
| `generar_hoja.jl`, `generar_bibliografia.jl`, `generar_estructura.jl`, `compilar_tikz.jl` (`--comprobar`) | al día; 10 de 10 cabeceras coinciden con el temario |

Las pruebas de Playwright, las de `_ejemplo/` que descargan `mcp` o `anthropic` y los dos scripts de
shell se ejecutaron fuera del sandbox de Claude Code: Chromium, `mktemp -d` y PyPI no funcionan dentro
de él en este equipo. No es un problema del proyecto.

## Incidencias

- **Corregida al migrar:** el ejemplo de pytest de la hoja de consulta apuntaba a una carpeta que no
  existe (`claude/c5-programacion/python`); ahora es `c5-programar/_ejemplo/python`.
- **Corregida al migrar:** con `_brand.yml`, Quarto repetía `id="quarto-bootstrap"` (lo detectó
  `test_accesibilidad`).
- `Pkg.rm` hizo además la limpieza automática del depósito de Julia (29 paquetes sin uso); los entornos
  de Resonancia y JuliaDo siguen completos.
- Las notas de `_curso/` anteriores a la separación citan rutas con el prefijo `claude/`: se conservan
  como registro histórico.

## Pendiente

- Crear el repositorio `me1catrr/claudedo` (privado) y hacer push: requiere autorización expresa.
- GitHub Pages: publicar junto con JuliaDo y la nueva versión de Resonancia.
- Decidir si matematicado se añade a los sitios hermanos (`curso.hermanos` de `temario.yml`).
