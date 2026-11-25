# Decisiones del curso de la vía C

| Fecha | Decisión | Motivo |
|---|---|---|
| 23/10/2026 | Se conservan los identificadores C0–C9 y los slugs (rutas públicas); cambian títulos y temas | Encargo del responsable; no romper enlaces |
| 23/10/2026 | Typst fuera del itinerario; Quarto para web, HTML y PDF | Encargo del responsable |
| 23/10/2026 | C0 se reordena en 10 temas (historia primero); el antiguo C0.2 pasa a C0.5 y se actualizan sus menciones en M0, M5, M6 y M7 | Orden pedagógico |
| 23/10/2026 | Indicador de versión solo en la vía C | Decisión del responsable |
| 23/10/2026 | FigureLabs: máximo 6 generaciones en todo el curso | Decisión del responsable (gestión de créditos) |
| 23/10/2026 | Nada de texto, figuras ni capturas de Anthropic Academy o de la documentación: redacción propia, cita y enlace | Licencias (AI Fluency es CC BY-NC-SA; el sitio es CC BY-SA) |
| 23/10/2026 | Las funciones de las prácticas son didácticas y viven en cada unidad (`python/`, `julia/`), no en `Resonancia.jl` | No son reutilizables entre unidades |
| 23/10/2026 | Seguimiento en `claude/_curso/` (el prefijo `_` lo excluye de la web) | Continuidad entre sesiones sin publicar notas internas |
| 23/10/2026 | Al cerrar cada fase: integrar la rama en `main` por avance rápido (`git merge --ff-only`) y hacer `git push` de `main` y de la rama | Petición del responsable para ver la evolución en GitHub Pages; `publish.yml` solo publica desde `main` |
| 23/10/2026 | El repositorio no se sincroniza por iCloud; el otro Mac trabaja con un clon de GitHub | Riesgo de corrupción de `.git` y de sincronizar carpetas locales ignoradas (apuntes y datos protegidos) |
| 23/10/2026 | C2 cubre solo macOS (Terminal/Zsh) y Windows (PowerShell); WSL solo como nota donde una herramienta lo exija; Linux fuera | Prompt maestro del módulo C |
| 23/10/2026 | Se mantiene la integración en `main` y el `git push` al cerrar fase, pidiendo aprobación explícita en ese momento | Regla del proyecto: nunca push sin petición |
| 23/10/2026 | C6 mantiene los casos de empresa A–D y añade un caso científico de vibración, FFT y series temporales | Prompt maestro del módulo C |
| 23/10/2026 | Ajuste de anchura (`grid`) y CSS adaptable compartido por todo el sitio | Prompt maestro: tablas, código y simulaciones más anchos que el texto; pendiente de prueba visual en 5 anchuras |
| 23/10/2026 | Los componentes interactivos se construyen con la unidad que los usa, no en bloque en la fase 2 | Evita componentes sin uso docente; cada uno lleva prueba Deno |
| 25/11/2026 | Edición **0.3.0**: las novedades de Claude Code 2.1.310–2.1.332 se integran en el texto y desaparecen las cajas «por incorporar»; selección y descartes en `NOVEDADES.md` | Encargo del responsable: incorporar, no acumular avisos |
| 25/11/2026 | Página transversal `actualizaciones.qmd` (no es una unidad), en la barra superior vía `curso.menu` de `temario.yml`, generada desde `_versiones.yml` (`curso.historial`) con `scripts/actualizaciones.lua` | Historial público sin duplicar datos; misma fuente que el indicador de cada unidad |
| 25/11/2026 | Los datos de los modelos (nombre, identificador, precios, caché, esfuerzo) se centralizan en `modelos` de `_variables.yml` y se leen con `{{< var >}}` en C1, C9 y «Actualizaciones» | Un solo sitio que cambiar cuando salgan modelos o precios nuevos |
| 25/11/2026 | Procedimiento permanente `ACTUALIZAR.md`, invocable con «Actualiza ClaudeDo» (instrucción en `CLAUDE.md`) | Que el mantenimiento no exija rehacer el plan en cada versión |
| 25/11/2026 | Lo ejecutado con el binario 2.1.330 de la sesión no se declara comprobado en 2.1.332; `claude_code_instalada` de cada unidad registra el binario realmente usado | Distinguir versión documentada, versión de la sesión y versión de la terminal |
| 25/11/2026 | Typst sigue fuera del itinerario; Warp, Cursor y similares solo se mencionan donde tienen aplicación práctica y fuente; Lean 4 y Codex no se incorporan en esta edición | Encargo: no ampliar el alcance sin justificación |
