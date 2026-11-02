# Adapta las rutas de la vía C tras moverla de resonancia/claude/ a la raíz de ClaudeDo.
#
# Todo baja un nivel de profundidad (claude/c0-fluidez/ pasa a c0-fluidez/). A diferencia
# de JuliaDo, aquí no se aplica una regla global: varias rutas con «../» son contenido
# didáctico (../../CLAUDE y ../../secreto en C7, ../viga-otro en C3, ../ruta en la hoja,
# el proyecto de ejemplo de C2) y no deben cambiar. Por eso cada sustitución se declara
# con su fichero y el número exacto de apariciones esperado; si no coincide, se detiene.
#
# Uso: julia _migracion/adaptar.jl            (aplica y resume)
#      julia _migracion/adaptar.jl --simular  (solo comprueba)
# Script de un solo uso: queda como registro de la migración.

const SIMULAR = "--simular" in ARGS
const UNIDADES = ["c0-fluidez", "c1-claude-web", "c2-terminal", "c3-git", "c4-claude-code",
    "c5-programar", "c6-informes", "c7-extender", "c8-automatizar", "c9-api"]

# (fichero, texto antiguo, texto nuevo, apariciones esperadas)
const CAMBIOS = Tuple{String,String,String,Int}[]

# Diapositivas: la hoja de estilos común está ahora un nivel más arriba.
for u in UNIDADES
    push!(CAMBIOS, ("$u/slides.qmd", "css: ../../styles.css", "css: ../styles.css", 1))
end

append!(CAMBIOS, [
    # Componentes interactivos de C0 y C4.
    ("c0-fluidez/index.qmd", "\"../../recursos/js/componentes/linea-temporal.js\"",
        "\"../recursos/js/componentes/linea-temporal.js\"", 1),
    ("c4-claude-code/index.qmd", "\"../../recursos/js/componentes/permisos.js\"",
        "\"../recursos/js/componentes/permisos.js\"", 1),
    # Enlace a la vía M: ahora es otro sitio.
    ("c0-fluidez/index.qmd", "](../../mse/m07-identificacion/index.qmd)",
        "](https://me1catrr.github.io/resonancia/mse/m07-identificacion/)", 1),
    # Informe de ejemplo de C6 (y su descripción en la unidad): bibliografía del sitio.
    ("c6-informes/_ejemplo/informe/informe.qmd", "bibliography: ../../../../recursos/bibliografia.bib",
        "bibliography: ../../../recursos/bibliografia.bib", 1),
    ("c6-informes/index.qmd", "bibliography: ../../../../recursos/bibliografia.bib",
        "bibliography: ../../../recursos/bibliografia.bib", 2),
    # Código de ejemplo que lee datos/sinteticos/curso-claude desde la raíz.
    ("c6-informes/_ejemplo/python/analisis.py", "Path(__file__).resolve().parents[4]",
        "Path(__file__).resolve().parents[3]", 1),
    ("c6-informes/_ejemplo/julia/lote.jl", "joinpath(@__DIR__, \"..\", \"..\", \"..\", \"..\", \"datos\"",
        "joinpath(@__DIR__, \"..\", \"..\", \"..\", \"datos\"", 1),
    ("c6-informes/_ejemplo/julia/analisis.jl", "joinpath(@__DIR__, \"..\", \"..\", \"..\", \"..\"))",
        "joinpath(@__DIR__, \"..\", \"..\", \"..\"))", 1),
    ("c7-extender/_ejemplo/test_ejemplos.py", "AQUI.parents[2] / \"datos\"", "AQUI.parents[1] / \"datos\"", 1),
    ("c7-extender/_ejemplo/mcp/servidor_csv.py", "Path(__file__).resolve().parents[4]",
        "Path(__file__).resolve().parents[3]", 1),
    ("c9-api/_ejemplo/proyecto/generar_informe.py", "AQUI.parents[3] / \"datos\"", "AQUI.parents[2] / \"datos\"", 1),
    # Comentarios de uso de los scripts de ejemplo.
    ("c6-informes/_ejemplo/julia/analisis.jl", "claude/c6-informes/", "c6-informes/", 1),
    ("c6-informes/_ejemplo/julia/lote.jl", "claude/c6-informes/", "c6-informes/", 1),
    ("c6-informes/_ejemplo/julia/figuras.jl", "claude/c6-informes/", "c6-informes/", 1),
    ("c6-informes/_ejemplo/julia/excel.jl", "claude/c6-informes/", "c6-informes/", 1),
    ("c9-api/_ejemplo/puente.jl", "claude/c9-api/", "c9-api/", 1),
    # Prueba del componente de línea temporal (importa los hitos de C0).
    ("recursos/js/componentes/linea-temporal.test.mjs", "\"../../../claude/c0-fluidez/hitos.js\"",
        "\"../../../c0-fluidez/hitos.js\"", 1),
])

function main()
    errores = String[]
    textos = Dict{String,String}()
    for (f, viejo, nuevo, n) in CAMBIOS
        t = get!(() -> read(f, String), textos, f)
        k = length(findall(viejo, t))
        k == n || push!(errores, "$f: «$viejo» aparece $k veces (se esperaban $n)")
        textos[f] = replace(t, viejo => nuevo)
    end
    isempty(errores) || error("No se aplica nada:\n  " * join(errores, "\n  "))
    SIMULAR || foreach(((f, t),) -> write(f, t), textos)
    println(SIMULAR ? "Simulación correcta" : "Aplicado", ": $(length(CAMBIOS)) sustituciones en $(length(textos)) ficheros.")
end

main()
