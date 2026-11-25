# Selección de novedades de Claude Code y de los modelos

Registro de trabajo (no se publica). Una tabla por actualización: qué se leyó, qué se
integra en el curso, dónde y con qué evidencia, y qué se descarta y por qué. La página
pública `actualizaciones.qmd` muestra solo el resumen (desde `_versiones.yml`).

**Evidencia.** E = ejecución real (binario y versión indicados) · S = simulación o prueba
fuera de Claude Code · D = contrastada con la documentación oficial vigente · C = solo
changelog · P = pendiente de comprobación.

## Actualización 0.3.0 · 25/11/2026

- **Leído:** changelog de 2.1.310 a 2.1.332 (`raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md`
  y `code.claude.com/docs/en/changelog.md`, 25/11/2026). La 2.1.332 es la última (GitHub
  «Latest», 25/11/2026). No tienen entrada 2.1.313, 2.1.315, 2.1.320 ni 2.1.324. La lectura se
  hizo con el lector web, por tramos: citas literales cortas y paráfrasis; el texto completo
  no se descargó (descarga bloqueada en la sesión).
- **Documentación vigente contrastada (25/11/2026):** cli-reference, permission-modes,
  permissions, settings, hooks, commands, mcp, plugins-reference, model-config, costs,
  sub-agents, scheduled-tasks y headless (`code.claude.com/docs/en/*.md`); modelos, precios y
  retiradas (`platform.claude.com/docs/en/about-claude/{models/overview,pricing,model-deprecations}`).
- **Binarios:** sesión de esta revisión 2.1.330 (aplicación de escritorio); terminal 2.1.304
  (`~/.local/bin`) y 2.1.300 (Homebrew). Lo marcado E se ejecutó con el binario 2.1.330 de la
  sesión y **no** se declara comprobado en 2.1.332.

### Integradas

| Versión | Novedad | Unidad · sección | Evidencia |
|---|---|---|---|
| — | Fable 5.2 (`claude-fable-5-2`, 9/11/2026) sustituye a Fable 5.1 como Fable por defecto; precios 8 $/40 $; Fable 5.1 sigue activa | C1.1, C1.4, C9.2 | D |
| — | Contexto de 1M y salida de 128K en los cuatro modelos vigentes; esfuerzo por defecto (Fable y Sonnet `high`, Opus y Haiku `medium`) | C1.1, C9.2 | D |
| — | Precios de caché (lectura 0,025× en Fable 5.2; 0,05× en Opus/Sonnet 5.5) y lotes al 50 % | C9.2 | D |
| — | Retiradas: Sonnet 4.5 el 30/11/2026; Opus 4.5 obsoleta (retiro 22/1/2027) | C1.1 | D |
| 2.1.321 | Las elecciones guardadas de Fable 5.1 pasan al alias `fable`; «More models» en `/model` | C4.7 | D (migración, model-config.md), C («More models») |
| 2.1.311, 2.1.316 | `ultrathink` sube el turno a esfuerzo `xhigh`; `CLAUDE_CODE_DISABLE_ULTRATHINK` | C4.7 | D |
| 2.1.312 | Ventana de uso de cinco horas («5-hour limit» en los avisos) | C4.7 | D («rolling five-hour window») |
| 2.1.316 | Modo rápido de Opus 4.8 retirado el 30/11/2026 | C4.7 | D (fast-mode.md) |
| — | Niveles de esfuerzo `low`…`max` (y `ultracode` en `--effort`); dependen del modelo | C4.7 | E (`--help` 2.1.330: `low, medium, high, xhigh, max`), D |
| — | Modos de permiso: `default` se muestra como *Manual* (`manual` es alias); `dontAsk`; en terminal y VS Code el modo inicial integrado es `auto` | C4.3 | E (`--permission-mode manual` y `default` aceptados, 2.1.330), D |
| 2.1.314 | `permissions.blockWritesOutsideWorkingDirectories` | C4.3, C8.8 | D |
| 2.1.314 | Pestaña *Recently blocked* de `/permissions` | C4.3 | D (permission-modes.md) |
| 2.1.319 | `permissions.denyInsteadOfPrompting` (desatendido: lo que preguntaría se deniega) | C4.3, C8.1, C8.8 | D |
| 2.1.323, 2.1.326 | Aviso al arrancar por reglas `allow` con comodines peligrosos (`Bash(git -C * status *)`) | C4.3 | E (aviso real en 2.1.330) |
| 2.1.325 | Bash en sandbox sigue el flujo normal de permisos; `sandbox.autoAllowBashIfSandboxed` para aprobarlo | C8.8 | D |
| 2.1.323 | En el sandbox, `git worktree add/move/remove` fallan (sistema de ficheros de solo lectura) | C3.10, C8.4 | C (observado también en el entorno de esta sesión) |
| 2.1.327 | `ExitWorktree` pregunta antes de borrar un worktree con trabajo sin guardar | C3.10, C8.4 | C |
| 2.1.329 | `/code-review` sin objetivo revisa toda la rama frente a la rama por defecto; con número de PR usa `gh pr diff` | C5.4 | D (commands.md), C |
| 2.1.329 | `/tasks` lista el trabajo en segundo plano de la sesión | C8.2 | D |
| 2.1.330 | Tareas recurrentes y `/loop` duran hasta 30 días (antes 7) | C8.1 | D (scheduled-tasks.md) |
| 2.1.319 | `/loop` autorregulado termina si un turno no lo reprograma | C8.1 | C |
| 2.1.314, 2.1.317, 2.1.319, 2.1.330 | `claude -p` sale con 1 cuando falla el arranque, no puede guardar o el modo auto rechaza acciones (antes salía con 0) | C8.1 | C; D solo «0 éxito, distinto de 0 fallo» |
| 2.1.316, 2.1.317 | `CLAUDE_CODE_SUBAGENT_EFFORT` y esfuerzo por modelo de subagentes | C8.2 | D |
| 2.1.312, 2.1.314, 2.1.316 | Hooks: `exit 2` en PowerShell; Monitor y *matcher* `Bash`; límite de hooks *prompt/agent* simultáneos | C7.5 | C; D da **12** simultáneos (el changelog de 2.1.312 decía 24): discrepancia declarada |
| 2.1.332 | Evento `PreSkillShellCommand` (rechaza las órdenes de shell de una skill al cargarla) | C7.5 | D |
| 2.1.295+ | Campo `onFailure` (`continue`/`block`) en hooks | C7.5 | D |
| 2.1.329 | El diálogo de confianza dice dónde se declaran los hooks de la carpeta | C7.9 | C |
| 2.1.327 | `claude mcp add-json <nombre> -` lee el JSON por la entrada estándar | C7.6 | D (resumen de mcp.md) |
| 2.1.319 | Tareas MCP (*MCP tasks*) en la terminal | C7.6 | D |
| 2.1.323 | `engines["claude-code"]` en `plugin.json`; `claude plugin validate` | C7.8 | D |
| 2.1.317, 2.1.321 | Claude Code pregunta antes de enviar a la red el correo de tu cuenta | C1.5 | C |
| 2.1.331 | `claude doctor` comprueba la conectividad con la API | C2.9 | C; `doctor` D |
| 2.1.318 | `claude auth status` muestra cuándo caduca el inicio de sesión (`loginExpiresAt`) | C2.9 | C |
| 2.1.314, 2.1.319 | La *skill* `claude-api` se actualizó; nuevo `/claude-api latency-optimize` | C9 (referencias) | C |
| — | `--max-turns` sigue existiendo aunque no aparece en `claude --help` | C8.1 | E (aceptado por 2.1.330), D |

### Descartadas (con motivo)

| Versión | Novedad | Motivo |
|---|---|---|
| 2.1.323 | *Code Mode* (experimental, opcional) | Experimental; se menciona solo como aviso en C8 si procede, sin enseñarlo |
| 2.1.326 | `/help <comando>` | No consta en commands.md vigente |
| 2.1.331 | `optionalDependencies` en plugins | No consta en plugins-reference.md vigente |
| 2.1.332 | Skills de servidores MCP como `server:skill` | Beta; la documentación no muestra ese formato |
| 2.1.322–2.1.332 | Bedrock, Vertex, Foundry, pasarelas, *self-hosted runners*, Remote Control, organizaciones Enterprise, OpenTelemetry | Fuera del alcance del curso (uso individual y de equipo pequeño) |
| 2.1.310–2.1.332 | Correcciones de interfaz, rendimiento y errores puntuales | Sin valor formativo |
| 2.1.330 | *mod* `easel` y `/workflows`, `/fork` de VS Code | Específicos de superficie o de plan; no aportan a las prácticas |
| 2.1.331 | Marketplaces gestionadas con actualización automática (desde el 30/11/2026) | Solo configuración gestionada de organizaciones |

### Discrepancias declaradas en el texto

| Tema | Fuentes | Cómo se resolvió |
|---|---|---|
| Esfuerzo por defecto | Página de modelos y skill `claude-api` (API): `high` en Fable y Sonnet, `medium` en Opus 5.5 y Haiku 5.5. model-config.md (Claude Code): los cuatro empiezan en `medium` | C1.4 distingue API y Claude Code; C4.7 no da valor por defecto y enseña a comprobarlo |
| Hooks *prompt/agent* simultáneos | Changelog 2.1.312: 24; hooks.md vigente: 12 | C7.5 da ambos datos |
| Qué revisa `/code-review` sin objetivo | code-review-local.md: commits por delante de la rama remota y cambios sin confirmar; changelog 2.1.329: toda la rama frente a la rama por defecto | C5.4 da ambas y aconseja indicar un rango |
| Nombre del límite de cinco horas | Changelog 2.1.312: *5-hour limit*; errors.md aún dice *session limit* | C4.7 dice que pueden aparecer los dos |

### Añadidos al catálogo durante la integración

| Novedad | Unidad · sección | Evidencia |
|---|---|---|
| Warp como aplicación de terminal (misma Zsh o PowerShell) | C2.1 | D (concepto general) |
| Extensión de Claude Code en Cursor y derivados de VS Code (enlace propio, Open VSX) | C2.8 | D (vs-code.md); no probado |
| Actualizar según el método de instalación; dos instalaciones en PATH (`which -a`, `where.exe`) | C2.9 | D (setup.md, troubleshoot-install.md); E (`claude --version` 2.1.330) |
| Limpieza de worktrees al salir y con `claude -p` | C3.10 | D (worktrees.md) |
| PDF con Typst desde Quarto (alternativa, no usada) | C6.6 | D (quarto.org); no probado |
| `--enable-auto-mode` eliminado (2.1.111) | C4.9 | D (cli-reference.md) |
