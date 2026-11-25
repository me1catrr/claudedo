-- =============================================================================
-- actualizaciones.lua: historial público de actualizaciones (actualizaciones.qmd)
--
-- Rellena tres bloques vacíos de la página a partir de las fuentes de verdad, sin
-- duplicar datos:
--   ::: {#estado-actualizacion}      versiones.curso (_versiones.yml)
--   ::: {#historial-actualizaciones} versiones.curso.historial (_versiones.yml)
--   ::: {#unidades-actualizaciones}  versiones.C0…C9 (_versiones.yml) + temario.yml
-- _versiones.yml llega como metadatos del proyecto (clave «versiones»); temario.yml
-- se lee del disco. Si falta un dato imprescindible, falla de forma visible.
-- Solo actúa en páginas con «actualizaciones: true».
-- =============================================================================

local function txt(x)
  if x == nil then return "" end
  return pandoc.utils.stringify(x)
end

-- Texto de metadatos como Markdown: conserva el formato (código, cursiva, enlaces)
-- que pandoc ya interpretó al leer _versiones.yml.
local function mdtxt(x)
  if x == nil then return "" end
  local t = pandoc.utils.type(x)
  local bloques
  if t == "Inlines" then
    bloques = { pandoc.Plain(x) }
  elseif t == "Blocks" then
    bloques = x
  else
    return pandoc.utils.stringify(x)
  end
  local s = pandoc.write(pandoc.Pandoc(bloques), "markdown", { wrap_text = "none" })
  return (s:gsub("%s+$", ""))
end

local function falla(msg)
  io.stderr:write("ERROR actualizaciones.lua: " .. msg .. "\n")
  os.exit(1)
end

local function md(s)
  return pandoc.read(s, "markdown").blocks
end

-- Celda de tabla: sin saltos de línea ni barras verticales sueltas.
local function celda(s)
  return (s:gsub("\n", " "):gsub("|", "\\|"))
end

-- Unidades del temario: id -> {titulo, slug}, en orden.
local function leer_temario()
  local f = io.open("temario.yml", "r")
  if f == nil then falla("no se encuentra temario.yml") end
  local yaml = f:read("a")
  f:close()
  local meta = pandoc.read("---\n" .. yaml .. "\n---\n", "markdown").meta
  local orden, datos = {}, {}
  for _, via in ipairs(meta.vias or {}) do
    for _, u in ipairs(via.unidades or {}) do
      local id = txt(u.id)
      orden[#orden + 1] = id
      datos[id] = { titulo = txt(u.titulo), slug = txt(u.slug) }
    end
  end
  if #orden == 0 then falla("temario.yml no tiene unidades") end
  return orden, datos
end

local function estado(curso)
  local filas = {
    { "Edición de ClaudeDo", txt(curso.version) },
    { "Última actualización", txt(curso.actualizado) },
    { "Última versión de Claude Code consultada (changelog)", txt(curso.claude_code_consultada) },
    { "Versión de Claude Code integrada en el texto", txt(curso.claude_code_integrada) },
    { "Binario con el que se ejecutaron las comprobaciones", txt(curso.claude_code_comprobada) },
    { "Modelos contemplados", mdtxt(curso.modelos) },
  }
  local s = { "| Dato | Valor |", "|---|---|" }
  for _, f in ipairs(filas) do
    if f[2] == "" then falla("falta un dato de versiones.curso: " .. f[1]) end
    s[#s + 1] = "| " .. f[1] .. " | " .. celda(f[2]) .. " |"
  end
  return md(table.concat(s, "\n"))
end

local function historial(curso, datos)
  local h = curso.historial
  if h == nil or #h == 0 then falla("falta versiones.curso.historial") end
  local bloques = {}
  for _, e in ipairs(h) do
    local partes = {}
    partes[#partes + 1] = "### Edición " .. txt(e.version) .. " · " .. txt(e.fecha) .. " {.unnumbered}"
    local cc = txt(e.claude_code)
    local det = {}
    if cc ~= "" then det[#det + 1] = "Claude Code " .. cc end
    if txt(e.comprobada) ~= "" then det[#det + 1] = "comprobaciones con el binario " .. txt(e.comprobada) end
    if txt(e.modelos) ~= "" then det[#det + 1] = "modelos: " .. txt(e.modelos) end
    if #det > 0 then partes[#partes + 1] = "*" .. table.concat(det, " · ") .. "*" end
    partes[#partes + 1] = mdtxt(e.resumen)
    if e.cambios ~= nil and #e.cambios > 0 then
      local t = { "| Unidad · sección | Cambio | Evidencia |", "|---|---|---|" }
      for _, c in ipairs(e.cambios) do
        local u = txt(c.unidad)
        local sec = txt(c.seccion)
        local etiqueta = txt(c.etiqueta)
        if etiqueta == "" then etiqueta = u end
        local enlace
        if datos[u] ~= nil then
          enlace = "[" .. etiqueta .. "](" .. datos[u].slug .. "/index.qmd" .. (sec ~= "" and ("#" .. sec) or "") .. ")"
        else
          enlace = etiqueta  -- cambios transversales (portada, hoja de consulta…)
          if txt(c.enlace) ~= "" then enlace = "[" .. etiqueta .. "](" .. txt(c.enlace) .. ")" end
        end
        t[#t + 1] = "| " .. enlace .. " | " .. celda(mdtxt(c.texto)) .. " | " .. celda(mdtxt(c.evidencia)) .. " |"
      end
      partes[#partes + 1] = table.concat(t, "\n")
    end
    if e.pendientes ~= nil and #e.pendientes > 0 then
      local p = { "**Pendiente de comprobación:**", "" }
      for _, x in ipairs(e.pendientes) do p[#p + 1] = "- " .. mdtxt(x) end
      partes[#partes + 1] = table.concat(p, "\n")
    end
    for _, b in ipairs(md(table.concat(partes, "\n\n"))) do bloques[#bloques + 1] = b end
  end
  return bloques
end

local function unidades(versiones, orden, datos)
  local t = {
    "| Unidad | Versión | Texto editado | Comprobación técnica | Claude Code (doc.) | Binario usado | Estado |",
    "|---|---|---|---|---|---|---|",
  }
  for _, id in ipairs(orden) do
    local v = versiones[id]
    if v == nil then falla("falta la entrada «" .. id .. "» en _versiones.yml") end
    local d = datos[id]
    t[#t + 1] = "| [" .. id .. " · " .. celda(d.titulo) .. "](" .. d.slug .. "/index.qmd) | "
      .. txt(v.version) .. " | " .. txt(v.actualizado) .. " | " .. txt(v.verificacion) .. " | "
      .. txt(v.claude_code_documentada) .. " | " .. txt(v.claude_code_instalada) .. " | "
      .. txt(v.estado) .. " |"
  end
  return md(table.concat(t, "\n"))
end

function Pandoc(doc)
  if txt(doc.meta.actualizaciones) ~= "true" then return nil end
  local versiones = doc.meta.versiones
  if versiones == nil or versiones.curso == nil then falla("faltan los metadatos de _versiones.yml") end
  local orden, datos = leer_temario()
  doc.blocks = doc.blocks:walk({
    Div = function(div)
      if div.identifier == "estado-actualizacion" then
        div.content = estado(versiones.curso)
      elseif div.identifier == "historial-actualizaciones" then
        div.content = historial(versiones.curso, datos)
      elseif div.identifier == "unidades-actualizaciones" then
        div.content = unidades(versiones, orden, datos)
      else
        return nil
      end
      return div
    end,
  })
  return doc
end
