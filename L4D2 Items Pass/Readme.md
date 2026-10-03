# L4D2 Items Carry Pass Extended

Plugin para **Left 4 Dead 2** que permite pasar o intercambiar armas y objetos con otro superviviente mediante **SHIFT + CLICK DERECHO**.

## Versión

**v9.2**

## Características

- Pasa o intercambia armas y objetos entre supervivientes.
- Mecánica principal: **SHIFT + CLICK DERECHO** mirando al otro superviviente.
- Comprueba jugador, objetivo, distancia y obstáculos.
- Conserva la munición cuando corresponde.
- Soporta armas, objetos médicos, granadas y determinados objetos transportables.
- Evita transferencias inválidas.
- Usa HintText para los avisos principales.

## Avisos automáticos

Cada **10 segundos**, todos los jugadores reciben en el chat únicamente:

```text
[Pass] Comandos: !pass  !passhelp
```

También reciben el HintText:

```text
Presiona SHIFT+CLICK DERECHO
```

El HintText se muestra en el recuadro del juego para explicar la mecánica sin llenar el chat con mensajes adicionales.

## Comandos

### `!pass`

Muestra la ayuda del sistema mediante HintText.

### `!passhelp`

Muestra la ayuda del sistema mediante HintText.

### `!pass_toggle`

Se mantiene para el **Owner del Listen Server**.

- Solo el Owner puede utilizarlo.
- No se anuncia a los demás jugadores.
- El comando se muestra únicamente al Owner cada **60 segundos**.
- Permite activar o desactivar el sistema de pase.

## Cómo usarlo

1. Acércate a otro superviviente.
2. Mira directamente hacia él.
3. Mantén presionado **SHIFT**.
4. Pulsa **CLICK DERECHO**.
5. El plugin comprueba si la transferencia es válida.
6. Si es válida, el arma u objeto se entrega o se intercambia.

## Validaciones

El plugin comprueba que:

- El jugador esté conectado y vivo.
- El jugador pertenezca al equipo Supervivientes.
- El objetivo esté conectado y vivo.
- El objetivo pertenezca al equipo Supervivientes.
- El objetivo no sea el mismo jugador.
- La distancia sea válida.
- No haya un obstáculo entre ambos.
- El arma u objeto pueda transferirse correctamente.

## Instalación

Coloca el archivo `.sp` en:

```text
addons/sourcemod/scripting/
```

Compílalo con `spcomp` y coloca el `.smx` generado en:

```text
addons/sourcemod/plugins/
```

## Dependencias

Utiliza las librerías de SourceMod/SDKTools/SDKHooks requeridas por la implementación del plugin.

No requiere un archivo de traducciones adicional para los mensajes descritos en este README.

## Funcionamiento automático

Después de instalar el `.smx`, el sistema queda disponible automáticamente. No es necesario ejecutar un comando para utilizar la mecánica principal.

```text
SHIFT + CLICK DERECHO
```

## Compatibilidad

- Left 4 Dead 2
- SourceMod
- Listen Server y servidores dedicados compatibles.

## Créditos

**Plugin:** L4D2 Items Carry Pass Extended  
**Versión:** 9.2  
**Juego:** Left 4 Dead 2  
**Plataforma:** SourceMod
