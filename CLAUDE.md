# ClaudeDo — instrucciones para Claude Code

## Qué es este proyecto
Web de autoformación en Quarto: *ClaudeDo — Aprende Claude haciendo*, IA aplicada al
trabajo profesional, la programación y la investigación con Claude y Claude Code.
Responsable único: Rafael Castro Triguero (GitHub `me1catrr`). Se publica en
https://me1catrr.github.io/claudedo/.

Diez unidades en la raíz (`c0-fluidez/` … `c9-api/`), agrupadas en áreas (Fundamental,
Aplicado, Avanzado) en `temario.yml`. Los identificadores C0–C9 y los slugs son rutas
públicas: no se cambian.

Es un proyecto independiente: las páginas hablan solo de ClaudeDo y no enlazan ni remiten
a otros cursos o sitios del autor (Resonancia, matematicado, JuliaDo). Si una unidad
necesita teoría de otra materia, se resume en la propia unidad o se cita bibliografía.

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

## Nombres heredados
El paquete TikZ `recursos/tikz/resonancia.sty` y el prefijo `resonancia:ej:` de las claves de
`localStorage` en `recursos/js/ejercicios.js` conservan su nombre de origen: cambiarlos obligaría
a tocar todas las figuras y borraría las respuestas ya guardadas. No son enlaces ni menciones
visibles. Estos ficheros ya no se sincronizan con otros repositorios.

## Estilos
- `marca.scss`: variables del tema (violeta `#5b34a8`, barra superior clara, colores de los
  callouts). `styles.css`: tokens CSS (`--sitio-acento…`, `--area-…`, `--novedad-…`) y
  componentes; se carga después del tema, así que los tokens se definen ahí y no en `marca.scss`.
- Acentos de las áreas: Fundamental azul `#1b6ca8`, Aplicado verde azulado `#2a9d8f`, Avanzado
  naranja `#d95f02`; con texto, sus variantes `--area-…-texto` (≥ 4,5:1). Código con filete
  violeta; resultados con rótulo «Resultado».
- La portada (`index.qmd`) usa `.acciones`, `.areas`/`.area`, `.piezas`, `.novedades-lista` y
  `.creditos`; sus estilos se activan con `body:has(.areas)`. El color de la cabecera va en su
  YAML (`title-block-banner: "#2e1a5c"`) para no depender de `styles.css` en caché. Cinco
  secciones: Tres áreas, Cómo es cada unidad, Novedades, Todas las unidades y Sobre el proyecto
  (lo demás, en «Acerca de»). Las cifras de las tarjetas (unidades, ejercicios) salen de
  `temario.yml` y de las unidades: se actualizan a mano.
- Subtítulo de unidad y diapositivas: «C4 · Área Aplicado» (lo genera `generar_estructura.jl`
  desde `areas`).
- `recursos/js/navbar-activo.html` deja activo en la barra superior solo el enlace de la página
  que se ve (Quarto marcaba siempre «Inicio»).

## Novedades de Claude Code por incorporar
Cuando se lee el changelog de una versión posterior a la documentada en `_versiones.yml`, lo que
afecta al curso se señala en la sección de la unidad con
`::: {.callout-note .novedad icon=false title="Novedad · Claude Code 2.1.3xx · por incorporar"}`,
citando `@anthropic-changelog` y cerrando con `[…]{.novedad-estado}` (leída, no ejecutada). Se
añade su línea en `.novedades-lista` de la portada y se actualiza `novedades` en
`_variables.yml`. Al integrar una novedad en el texto (y registrar el comando en
`_curso/comandos.yml`), se quita su caja y su línea.

## Figuras, cajas y bibliografía
- **Reparto de figuras.** TikZ para esquemas y diagramas; Makie u OJS para datos y
  simulaciones; FigureLabs solo para ilustraciones conceptuales (máximo 6 en el curso).
  Nada de capturas de páginas como sustituto del texto.
- **TikZ.** Fuente `fig/nombre.tex` con `\usepackage{resonancia}`. Se compila con
  `julia --project=. scripts/compilar_tikz.jl` y se commitean el `.tex` y el `.svg`.
- **Figuras en la página.** Pie, `{#fig-…}` y `fig-alt` obligatorios. El color nunca es la única señal.
- **Componentes interactivos** (`recursos/js/componentes/`): se construyen con la unidad que
  los usa y llevan prueba Deno.
- **Bibliografía.** Una sola fuente, `recursos/bibliografia.bib`, con `keywords` y
  `verificado`. Las páginas que citan llevan
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
- Créditos de IA: es un repositorio creado con Claude Code para aprender Claude Code. Al cerrar
  una revisión de la web hecha con Claude Code, actualiza `_variables.yml` (`revision.fecha` y
  `revision.claude-code`) en el mismo commit. La versión es la de la sesión (`/status`), que en
  la extensión de VS Code puede no coincidir con `claude --version`. `creacion` no se toca. Lo
  muestran el colofón de la portada, «Acerca de» y el README (este, a mano).

## Comandos útiles
- Vista previa: `quarto preview`
- Compilar una página: `quarto render c4-claude-code/index.qmd`
- Auditoría: `julia --project=. scripts/auditar_claude.jl --comprobar`
- Hoja de consulta: `julia --project=. scripts/generar_hoja.jl [--comprobar]`
