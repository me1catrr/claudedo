# ClaudeDo — instrucciones para Claude Code

## Qué es este proyecto
Web de autoformación en Quarto: *ClaudeDo — Aprende Claude haciendo*, IA aplicada al
trabajo profesional, la programación y la investigación con Claude y Claude Code.
Responsable único: Rafael Castro Triguero (GitHub `me1catrr`). Se publica en
https://me1catrr.github.io/claudedo/.

Diez unidades en la raíz (`c0-fluidez/` … `c9-api/`), agrupadas en áreas (Fundamental,
Aplicado, Avanzado) en `temario.yml`. Procede de la vía C de Resonancia
(https://github.com/me1catrr/resonancia), separada en noviembre de 2026; véase `_migracion/`.
Los identificadores C0–C9 y los slugs son rutas públicas: no se cambian.

Sitios hermanos: Resonancia (monitorización de la salud estructural, laboratorios y
recursos) y JuliaDo (Julia). Se enlazan con su URL publicada; no se copian contenidos.

## Seguimiento del curso
El plan, el estado, las decisiones, el modelo didáctico, las fuentes y el registro
verificado de comandos están en `_curso/` (no se publica). Léelo antes de seguir
trabajando en las unidades. Las notas anteriores a la separación citan rutas con el
prefijo `claude/`: son históricas.

## Fuente de verdad
`temario.yml` define identificadores, títulos, carpetas, prerrequisitos, perfiles, temas y
áreas. No inventes unidades ni identificadores. Si algo falta o cambia, propón primero el
cambio en `temario.yml` y espera aprobación.

**Áreas futuras.** Para añadir un área (por ejemplo, IA en ingeniería, en docencia o en
investigación): se declara en `areas` de `temario.yml`, se añaden sus unidades con id
nuevo (C10…) y su entrada en `_versiones.yml`, y se ejecuta
`julia --project=. scripts/generar_estructura.jl` (crea el esqueleto y la barra lateral).
No se crean páginas vacías de antemano.

## Conceptos frente a herramientas
- Los **conceptos** (cómo funciona un modelo, límites, delegar y verificar, privacidad,
  integridad) se redactan sin depender de una versión concreta.
- Las **instrucciones de herramienta** (comandos, opciones, menús, configuración) se
  comprueban contra la documentación oficial y se registran en `_curso/comandos.yml`; cada
  unidad declara en `_versiones.yml` su versión y su comprobación técnica, que
  `scripts/version_unidad.lua` muestra bajo el título. No marques «verificado» sin haber
  ejecutado la comprobación.

## Convenciones de contenido
- Español de España. Término técnico inglés entre paréntesis la primera vez.
- macOS (Terminal, Zsh) y Windows (PowerShell); WSL solo como nota cuando una herramienta
  lo exija.
- Ejemplos en Julia y Python (con `uv`); su versión probada vive en `_ejemplo/` de la unidad,
  con sus pruebas.
- No reproduzcas texto de libros ni de fuentes con copyright: redacta con palabras propias y
  cita con `recursos/bibliografia.bib`. No copies texto, figuras ni capturas de cursos o
  documentación de Anthropic (AI Fluency es CC BY-NC-SA, incompatible con CC BY-SA).

## Plantilla de unidad (orden fijo de secciones)
1. Objetivos y prerrequisitos
2. Teoría breve
3. Práctica guiada
4. «Pídeselo a Claude»: `.callout-tip` con el prompt y un apartado *Verifica*
5. Ejercicios
6. «La doy por superada si…»
Diapositivas: `slides.qmd` (reveal.js) en la misma carpeta de la unidad.

## Metadatos obligatorios en la cabecera de cada unidad
`id`, `title`, `via: C`, `nivel`, `requiere`, `perfil`, `estado` (borrador | revisado |
publicado) y `verificado` (versiones de Claude Code y Julia con las que se comprobó).

## Código y entornos
- Entorno Julia en la raíz (`Project.toml` + `Manifest.toml`) para scripts y ejemplos.
  Ninguna página del sitio ejecuta Julia al compilar.
- Python: entorno gestionado con `uv` (`pyproject.toml`). No uses conda.

## Base común con Resonancia y JuliaDo
`styles.css`, `recursos/tikz/resonancia.sty`, `recursos/js/ejercicios.js` (y sus tests),
`scripts/ejercicios.lua`, `scripts/referencias.lua`, `scripts/no_publicar_docs.ts` y
`scripts/generar_estructura.jl` son idénticos en los tres sitios. Un cambio en uno se copia a
los otros dos. Los acentos propios (violeta) van en `marca.scss`.

## Figuras, cajas y bibliografía
- **Reparto de figuras.** TikZ para esquemas y diagramas; Makie u OJS para datos y
  simulaciones; FigureLabs solo para ilustraciones conceptuales (máximo 6 en el curso).
  Nada de capturas de páginas como sustituto del texto.
- **TikZ.** Fuente `fig/nombre.tex` con `\usepackage{resonancia}`. Se compila con
  `julia --project=. scripts/compilar_tikz.jl` y se commitean el `.tex` y el `.svg`.
- **Figuras en la página.** Pie, `{#fig-…}` y `fig-alt` obligatorios. El color nunca es la única señal.
- **Componentes interactivos** (`recursos/js/componentes/`): se construyen con la unidad que
  los usa y llevan prueba Deno.
- **Bibliografía.** Una sola fuente, `recursos/bibliografia.bib` (subconjunto de la de
  Resonancia), con `keywords` y `verificado`. Las páginas que citan llevan
  `citation-location: margin`. Informe: `julia --project=. scripts/generar_bibliografia.jl`.
- **Historia y noticias.** Solo hechos comprobados en una fuente que se enlaza (con fecha de
  consulta); si hay discrepancia entre fuentes, se dice.
- **Licencias.** Contenido CC BY-SA 4.0; código MIT.

## Ejercicios intercalados
`::: {.ejercicio tipo="…" id="…" respuesta="…" tol="1%" unidad="…"}` con hijos `.pista`,
`.solucion`, `.opciones`, `.retro`, `.rubrica` y `.criterios`. Tipos: `vf`, `opcion`,
`numerico`, `abierta`, `programacion`, `investigacion` y `encuesta`. Todo ocurre en el
navegador y se guarda en `localStorage`; nada se envía (coherente con C0).

## Datos
- `datos/sinteticos/curso-claude/`: casos A–E, públicos, con ficha `.meta.toml`; se regeneran
  con `scripts/datos/generar_casos.jl`.
- `datos/privados/`: NUNCA lo leas, listes, copies ni menciones su contenido.

## Apuntes de consulta (solo locales)
`docs/` (ignorada por Git) puede guardar PDF de consulta. Consulta solo los necesarios cuando
el usuario lo pida; cita título y página; no enlaces ni copies los PDF.
`scripts/no_publicar_docs.ts` comprueba tras el render que `docs/` no llegue a la web.

## Forma de trabajar
- Antes de cambios que afecten a varios ficheros, presenta un plan y espera aprobación.
- Tras editar una página, compruébala con `quarto render <fichero>`.
- Nunca ejecutes `git push`, `quarto publish`, `gh repo create` ni cambies la configuración de
  GitHub sin petición explícita.
- Commits pequeños, mensaje en español en imperativo: «Añade la unidad C10».

## Comandos útiles
- Vista previa: `quarto preview`
- Compilar una página: `quarto render c4-claude-code/index.qmd`
- Auditoría: `julia --project=. scripts/auditar_claude.jl --comprobar`
- Hoja de consulta: `julia --project=. scripts/generar_hoja.jl [--comprobar]`
