# [L4D2] AutoBhop Improved

Plugin de **SourceMod para Left 4 Dead 2** que proporciona AutoBhop exclusivamente al **host de un Listen Server**.

La versión `2.0` está diseñada para que el host pueda activar o desactivar el AutoBhop mediante comandos, mientras que los demás jugadores no pueden utilizar ni controlar esta función.

## Características

- AutoBhop exclusivo para el host del Listen Server.
- No funciona para jugadores normales.
- No funciona en servidores dedicados.
- Activación y desactivación mediante:
  - `!bhp`
  - `!autobhop`
- Recordatorio periódico para el host cuando AutoBhop está desactivado.
- El intervalo del recordatorio es configurable.
- Permite desactivar completamente el plugin mediante ConVar.
- El salto se mantiene con la tecla de salto presionada:
  - En el aire, el plugin elimina `IN_JUMP`.
  - Al tocar el suelo, `IN_JUMP` vuelve a estar disponible.
  - Esto permite bunny hopping continuo sin tener que pulsar repetidamente la tecla.
- No interviene cuando el jugador está:
  - En una escalera.
  - En noclip.
  - En modo espectador.
- Comprueba que el jugador esté conectado y vivo antes de modificar los botones.
- Limpieza automática del temporizador al cambiar/finalizar el mapa o descargar el plugin.
- Comprobación de compatibilidad exclusiva con Left 4 Dead 2.

## Requisitos

- Left 4 Dead 2
- SourceMod
- SDKTools

Librerías utilizadas:

```sourcepawn
#include <sourcemod>
#include <sdktools>
```

## Instalación

1. Compila:

```text
l4d2_autobhop.sp
```

2. Copia el archivo compilado:

```text
l4d2_autobhop.smx
```

a:

```text
left4dead2/addons/sourcemod/plugins/
```

3. Si utilizas el sistema de traducciones incluido, coloca:

```text
l4d2_autobhop.phrases.txt
```

en:

```text
left4dead2/addons/sourcemod/translations/
```

El plugin carga las traducciones mediante:

```sourcepawn
LoadTranslations("l4d2_autobhop.phrases");
```

## Uso

### Activar AutoBhop

Si eres el **host del Listen Server**, escribe en el chat:

```text
!bhp
```

o:

```text
!autobhop
```

También puedes utilizar los comandos desde la consola:

```text
sm_bhp
sm_autobhop
```

Al activarlo, el plugin muestra al host un mensaje de estado mediante chat y Hint.

### Desactivar AutoBhop

Utiliza nuevamente:

```text
!bhp
```

o:

```text
!autobhop
```

El estado funciona como un interruptor:

```text
OFF → ON
ON  → OFF
```

## Restricción exclusiva al Host

Esta es una característica importante del plugin.

El plugin identifica al host del Listen Server utilizando el cliente `1`:

```sourcepawn
if (IsValidClient(1) && !IsFakeClient(1))
{
    return 1;
}
```

Por lo tanto:

- **Host del Listen Server:** puede utilizar AutoBhop.
- **Otros jugadores:** no pueden activarlo.
- **Bots:** no son tratados como host.
- **Servidor dedicado:** no dispone de un Listen Server Host y el plugin no ejecuta AutoBhop.

Si un jugador que no es el host intenta utilizar:

```text
!bhp
```

o:

```text
!autobhop
```

recibirá el mensaje de restricción correspondiente.

## Funcionamiento del AutoBhop

El plugin utiliza:

```sourcepawn
OnPlayerRunCmd()
```

para revisar los botones enviados por el host.

Cuando el host está en el aire y mantiene presionado el salto:

```sourcepawn
if ((buttons & IN_JUMP) != 0 && (GetEntityFlags(client) & FL_ONGROUND) == 0)
{
    buttons &= ~IN_JUMP;
    return Plugin_Changed;
}
```

El comando de salto se elimina mientras el jugador está en el aire.

Cuando vuelve a tocar el suelo, el botón `IN_JUMP` deja de ser eliminado y el juego puede procesar nuevamente el salto.

Esto permite mantener presionada la tecla de salto para realizar bunny hopping continuo.

## Entidades de movimiento excluidas

El plugin no modifica el comando de salto cuando el host está utilizando:

```text
MOVETYPE_LADDER
MOVETYPE_NOCLIP
MOVETYPE_OBSERVER
```

Esto evita interferencias con:

- Escaleras.
- Noclip.
- Espectador.

## ConVars

El plugin crea dos ConVars.

### `l4d2_autobhop_enabled`

Activa o desactiva globalmente el plugin.

Valor predeterminado:

```cfg
l4d2_autobhop_enabled "1"
```

Rango:

```text
0 = Desactivado
1 = Activado
```

Ejemplo:

```cfg
l4d2_autobhop_enabled "0"
```

Con esta opción en `0`, AutoBhop queda completamente desactivado aunque el estado interno esté activado.

### `l4d2_autobhop_reminder`

Define cada cuántos segundos el host recibe un recordatorio cuando AutoBhop está desactivado.

Valor predeterminado:

```cfg
l4d2_autobhop_reminder "60.0"
```

Ejemplo:

```cfg
l4d2_autobhop_reminder "120.0"
```

Esto muestra el recordatorio cada 120 segundos.

Para desactivar los recordatorios:

```cfg
l4d2_autobhop_reminder "0"
```

## Generación de configuración

Las ConVars utilizan `CreateConVar()`, por lo que SourceMod puede incorporarlas a su configuración normal.

Puedes establecerlas desde:

```text
cfg/server.cfg
```

o desde la consola del servidor.

Ejemplo:

```cfg
l4d2_autobhop_enabled "1"
l4d2_autobhop_reminder "60.0"
```

## Recordatorio

Cuando AutoBhop está desactivado y el recordatorio está habilitado, el plugin busca al host y ejecuta:

```sourcepawn
PrintToChat(host, "%T", "Bhop_Reminder", host);
```

Los textos mostrados dependen del archivo de traducciones:

```text
l4d2_autobhop.phrases.txt
```

## Mensajes de traducción

El código utiliza estas claves de traducción:

```text
Bhop_Reminder
Host_Only
Bhop_Disabled
Bhop_Hint_On
Bhop_Chat_On
Bhop_Hint_Off
Bhop_Chat_Off
```

Por ello, el archivo de frases debe contener esas claves para que los mensajes se muestren correctamente.

## Ciclo de vida

El plugin administra el temporizador de recordatorio en:

```text
OnPluginStart()
OnPluginEnd()
OnMapStart()
OnMapEnd()
```

Cuando cambia el mapa, el temporizador se reinicia.

Cuando termina el mapa o se descarga el plugin, el temporizador se elimina.

También se reinicia automáticamente cuando cambia:

```text
l4d2_autobhop_reminder
```

## Compatibilidad

El plugin comprueba durante la carga:

```sourcepawn
GetEngineVersion() != Engine_Left4Dead2
```

Si el juego no es Left 4 Dead 2, el plugin rechaza la carga.

## Comandos

| Comando | Función | Acceso |
|---|---|---|
| `!bhp` | Activa/desactiva AutoBhop | Host del Listen Server |
| `!autobhop` | Activa/desactiva AutoBhop | Host del Listen Server |
| `sm_bhp` | Versión de consola de `!bhp` | Host del Listen Server |
| `sm_autobhop` | Versión de consola de `!autobhop` | Host del Listen Server |

## Flujo de funcionamiento

```text
Jugador ejecuta !bhp
        │
        ▼
¿Es el Host del Listen Server?
        │
   ┌────┴────┐
   │         │
  NO        SÍ
   │         │
   ▼         ▼
Mensaje    ¿Plugin habilitado?
Host Only       │
           ┌────┴────┐
           │         │
          NO        SÍ
           │         │
           ▼         ▼
       Mensaje    Cambia estado
       Disabled   ON/OFF
                     │
                     ▼
               OnPlayerRunCmd
                     │
                     ▼
               ¿Host está vivo?
                     │
                     ▼
              ¿Está en el aire?
                     │
                     ▼
             Elimina IN_JUMP
                     │
                     ▼
               Toca el suelo
                     │
                     ▼
             Puede volver a saltar
```

## Notas

Este plugin **no otorga AutoBhop a todos los jugadores**. Su objetivo específico es proporcionar la función únicamente al jugador que actúa como host de un Listen Server.

Tampoco utiliza timers por tick para forzar la velocidad del jugador ni modifica directamente la velocidad horizontal. La implementación se basa en modificar el comando `IN_JUMP` mientras el jugador está en el aire.

## Información del plugin

```text
Nombre:        L4D2 AutoBhop Improved
Versión:       2.0
Autor:         Shadow L4d2 / Rewritten
Motor:         Left 4 Dead 2
Framework:     SourceMod
Dependencias:  SDKTools
Tipo:          AutoBhop para Listen Server Host
```
