# Elección del framework CSS (Tarea 7)

En esta tarea hemos decidido cómo vamos a dar estilo al frontend de MindSprint. Lo más importante para nosotros era que la aplicación se viera igual que el diseño que hicimos en Figma, así que hemos comparado las opciones pensando sobre todo en eso.

## 1. Comparativa

Estudiamos las tres opciones más habituales:

| Opción | Cómo funciona | Lo que nos gustó | Lo que no nos convenció |
|---|---|---|---|
| Bootstrap | Trae componentes ya hechos (botones, formularios, tarjetas, ventanas) que se usan poniendo clases como `btn btn-primary` | Es rápido de empezar y se adapta solo al móvil | Si no se personaliza, todas las webs se parecen. Para que se viera como nuestro Figma teníamos que sobrescribir muchas de sus variables, y eso acababa siendo más lío que escribir los estilos nosotros |
| Tailwind CSS | Clases pequeñas que se combinan en el HTML (`bg-blue-600 px-4 rounded-lg`) | Permite ser muy fiel al diseño de Figma | Necesita Node.js y un paso de compilación, y nuestro frontend es HTML, CSS y JavaScript sin herramientas. Además, el HTML se llena de clases y cuesta leerlo |
| **CSS propio** | Escribimos nuestras propias hojas de estilo | Control total: la app queda exactamente igual que en Figma. Entendemos cada línea porque la hemos escrito nosotros. No hay que instalar nada | Es más lento, porque hay que hacer a mano cosas que otros frameworks ya traen hechas |

## 2. Decisión: CSS propio

Al final hemos elegido **escribir nuestro propio CSS**. Estos son los motivos:

1. **Queríamos que se viera igual que en Figma.** Nuestro diseño tiene un estilo muy concreto: el azul `#304DF8`, el panel oscuro del login, la tipografía Space Grotesk en los números grandes y las tarjetas con las esquinas redondeadas. Con CSS propio lo podemos copiar tal cual, sin pelearnos con los estilos que trae un framework por defecto.
2. **Es lo que encaja con nuestro stack.** En la primera entrega dijimos que el frontend sería HTML, CSS y JavaScript (apartado 5.1). Con CSS propio no tenemos que instalar Node.js ni compilar nada: basta con enlazar un archivo `.css`.
3. **Necesitamos pocos componentes.** La app tiene pocas pantallas y los componentes se repiten mucho: botones, campos, tarjetas y la ventana de pausa. Son pocas clases y las podemos reutilizar en todas las páginas.
4. **Lo entendemos todo.** Como lo hemos escrito nosotros, sabemos explicar cada línea, y eso nos ayuda a la hora de cambiar algo o de presentarlo en la demo.

Para que no sea más lento de lo necesario, lo hemos organizado como lo haría un framework: **todos los colores, fuentes y tamaños están guardados en variables CSS** al principio del archivo. Así, si cambiamos algo en Figma, solo hay que tocarlo en un sitio y se actualiza en toda la aplicación.

## 3. Cómo lo hemos configurado

Todo está en `frontend/css/estilos.css`, que tiene cuatro partes:

1. **Variables de la guía de estilo**: colores, tipografías, tamaños de letra, espacios y esquinas, sacados de Figma.
2. **Base**: los estilos generales de la página (fondo, color del texto, fuentes de los títulos…).
3. **Clases de ayuda**: `.contenedor`, `.texto-portada`, `.texto-numero`, `.texto-suave`…
4. **Móvil**: con un `@media` reducimos los tamaños de letra en pantallas estrechas, porque la app tiene que funcionar también en el móvil (apartado 1.1).

Las fuentes **Space Grotesk** e **Inter** las cargamos desde Google Fonts.

En la tarea 8 añadiremos los componentes (botones, campos y tarjetas) en un archivo aparte, `css/componentes.css`, usando estas mismas variables.

### Colores de la guía de estilo

| Uso | Variable | Valor |
|---|---|---|
| Primario: botones principales, logo, reto del día | `--color-primario` | #304DF8 |
| Oscuro: texto, panel del login, tarjeta de puntuación | `--color-oscuro` | #13172A |
| Texto secundario | `--color-texto-suave` | #59607E |
| Fondo de la página | `--color-fondo` | #F2F4FA |
| Tarjetas y botón secundario | `--color-blanco` | #FFFFFF |
| Bordes | `--color-borde` | #DCE0ED |
| Opciones de respuesta y desactivado | `--color-gris` | #E4E6ED |
| Acierto | `--color-acierto` | #00B270 |
| Fallo | `--color-fallo` | #F64155 |
| Aviso de error (fondo / texto) | `--color-fallo-fondo` / `--color-fallo-texto` | #FEECEE / #BF2E41 |
| Temporizador, reto del día, puntuación | `--color-amarillo` | #FFC24C |
| Categoría Memoria | `--color-memoria` | #8B5CF0 |
| Categoría Cálculo | `--color-calculo` | #FFC24C |
| Categoría Atención | `--color-atencion` | #00B8AF |
| Categoría Agilidad verbal y racha | `--color-verbal` | #FF7960 |

### Tipografías y tamaños

| Uso | Variable | Valor |
|---|---|---|
| Fuente de títulos y números grandes | `--fuente-titulos` | Space Grotesk |
| Fuente de textos, botones y formularios | `--fuente-texto` | Inter |
| Puntuación final ("1.625") | `--texto-numero` | 96px |
| Título de portada ("60 segundos para…") | `--texto-portada` | 48px |
| Títulos grandes ("Partida en pausa") | `--texto-h1` | 36px |
| Saludo del Dashboard | `--texto-h2` | 28px |
| Títulos de sección y tarjetas | `--texto-h3` | 20px |
| Texto normal | `--texto-normal` | 16px |
| Descripciones y etiquetas | `--texto-pequeno` | 14px |
| Ayudas de los campos | `--texto-mini` | 12px |
| Esquinas de botones y campos | `--radio` | 10px |
| Esquinas de tarjetas y ventanas | `--radio-tarjeta` | 16px |

## 4. Cómo comprobarlo

Abrid `frontend/index.html` en el navegador. Es una página de prueba donde se ven todos los colores y tipografías de la guía de estilo ya aplicados.
