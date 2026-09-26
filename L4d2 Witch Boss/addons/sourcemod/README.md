<details>
<summary><b>L4D2 Witch Boss Advanced AI</b></summary>

Boss Witch avanzada para **Left 4 Dead 2**.

> **Compatibilidad:** funciona en el motor de **L4D2**, incluyendo las campañas originales de **Left 4 Dead 1 cuando se ejecutan dentro de L4D2**. No es un plugin para el ejecutable independiente de L4D1.
<details>

<details>
<summary><b>Cambios De Witch</b></summary>

- La Boss Witch se registra cuando una Witch es realmente despertada.
- Una segunda Witch no reemplaza a la Boss Witch activa.
- Evita que `witch_harasser_set` vuelva a inicializar la misma Boss Witch durante los cambios de objetivo.
- Los guardias ya no usan posiciones aleatorias manuales ni `z_spawn auto` como respaldo.
- Los guardias solicitan a Left4DHooks una posición válida de spawn antes de usar `L4D2_SpawnSpecial`.
- Se mantiene la selección de Hunter, Jockey, Charger y Smoker.
- La opción de Safe Room usa `L4D2_ExecVScriptCode` para modificar `DirectorOptions.AllowWitchesInCheckpoints`.
- El comando `sm_witch_reset` reinicia el estado de la IA y los efectos, pero **no elimina la entidad Witch**.
- Se agregaron comprobaciones de natives requeridas de Left4DHooks al iniciar el plugin.
- Limpieza adicional de handles al descargar el plugin.
<details>

<details>
<summary><b>Dependencias</b></summary>

- SourceMod
- SDKTools
- SDKHooks
- Left4DHooks actualizado

La versión 9.1 requiere estas natives de Left4DHooks:

```text
L4D2_SpawnSpecial
L4D_GetRandomPZSpawnPosition
L4D2_ExecVScriptCode
```

También utiliza el gamedata de Left4DHooks para:

```text
Witch::SetHarasser
```
<details>
<details>
<summary><b>Características</b></summary>

- Boss Witch de **2700 HP**.
- Objetivo inicial basado en el superviviente que despierta a la Witch.
- Persecución persistente.
- Retarget por muerte/incapacitación del objetivo.
- Cambio de objetivo cuando otro superviviente daña a la Boss Witch.
- Reelección de objetivo cuando el objetivo se aleja demasiado.
- Tres fases de furia.
- Guardias especiales en las fases de la Boss Witch.
- Apertura/desbloqueo de puertas `prop_door_rotating_checkpoint` cercanas durante la persecución cuando la opción está activada.
- Efecto de luz y partícula sobre la Boss Witch.
- Limpieza de efectos al terminar la ronda, mapa o Boss Witch.
- Comandos administrativos.
<details>

<details>
<summary><b>Safe Room / Checkpoint</b></summary>

```text
l4d_witch_boss_ignore_saferoom 1
```

Cuando está activado, el plugin establece:

```text
DirectorOptions.AllowWitchesInCheckpoints <- true
```

Esto permite que la Witch acceda a áreas nav marcadas como `CHECKPOINT`.

**Importante:** esta opción de Director no abre por sí sola las puertas. La apertura de puertas está controlada por separado mediante:

```text
l4d_witch_boss_break_doors 1
```
<details>

<details>
<summary><b>Guardias</b></summary>

La versión 9.1 no coloca los infectados mediante offsets aleatorios alrededor del jugador.

Para cada guardia, solicita a Left4DHooks una posición válida de aparición mediante:

```text
L4D_GetRandomPZSpawnPosition
```

y después utiliza:

```text
L4D2_SpawnSpecial
```

Clases utilizadas:

```text
Smoker
Hunter
Jockey
Charger
```

Si el motor no proporciona una posición válida, ese guardia no se genera. No se utiliza `z_spawn auto` para crear accidentalmente otro tipo de infectado.
<details>

<details>
<summary><b>Fases</b></summary>

### Fase 1 — Normal

```text
2700 - 1901 HP
```

1 guardia por oleada.

### Fase 2 — Furia

```text
1900 - 1101 HP
```

1 guardia normalmente, con posibilidad de una oleada de 2 guardias.

### Fase 3 — Enfurecida

```text
1100 - 1 HP
```

2 guardias por oleada y actualización más frecuente del objetivo.
<details>

<details>
<summary><b>CVars</b></summary>

```text
l4d_witch_boss_enable 1
l4d_witch_boss_ignore_saferoom 1
l4d_witch_boss_retarget 1
l4d_witch_boss_break_doors 1
l4d_witch_boss_guards 1
l4d_witch_boss_guard_cooldown 12.0
l4d_witch_boss_max_chase 3500.0
```
<details>

### `l4d_witch_boss_enable`

Activa o desactiva el sistema Boss Witch.

### `l4d_witch_boss_ignore_saferoom`

Permite el acceso de la Witch a áreas nav de Checkpoint mediante `DirectorOptions.AllowWitchesInCheckpoints`.

### `l4d_witch_boss_retarget`

Permite cambiar de objetivo cuando corresponde.

### `l4d_witch_boss_break_doors`

Permite abrir/desbloquear puertas `prop_door_rotating_checkpoint` dentro del radio de la Witch.

### `l4d_witch_boss_guards`

Activa las oleadas de infectados especiales.

### `l4d_witch_boss_guard_cooldown`

Tiempo mínimo entre oleadas de guardias.

### `l4d_witch_boss_max_chase`

Distancia máxima utilizada para decidir si se debe buscar otro superviviente.

## Comandos

### Estado

```text
sm_witch
```

También puede utilizarse en chat como:

```text
!sm_witch
```

Muestra el estado de la Boss Witch, la fase y el objetivo almacenado.

### Reiniciar IA

```text
sm_witch_reset
```

Requiere `ADMFLAG_ROOT`.

El comando limpia el estado de la Boss Witch y sus efectos, pero **no mata ni elimina la entidad Witch**.

## Instalación

Coloca el código fuente en:

```text
addons/sourcemod/scripting/
```

Compila con el compilador de SourceMod y coloca el `.smx` generado en:

```text
addons/sourcemod/plugins/
```

El plugin genera:

```text
cfg/sourcemod/l4d2_witch_boss_advanced.cfg
```

Asegúrate de tener el gamedata de Left4DHooks actualizado.

## Compatibilidad L4D1

No es necesario instalar una versión separada para L4D1 si las campañas se ejecutan dentro de L4D2.

Compatible como contenido de L4D2 con campañas como:

```text
No Mercy
Crash Course
Death Toll
Dead Air
Blood Harvest
The Sacrifice
```

No debe cargarse esperando compatibilidad con un servidor ejecutando el **Left 4 Dead 1 independiente**.

## Estado de verificación

La versión 9.1 fue revisada estáticamente contra el código fuente y contra la API/gamedata pública actual de Left4DHooks.

**No se ha realizado una compilación con `spcomp` ni una prueba dentro de un servidor L4D2 en este entorno**, por lo que esas dos comprobaciones todavía deben realizarse antes de distribuir una versión comercial.
