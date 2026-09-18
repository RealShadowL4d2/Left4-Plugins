[b][size=4]Description[/size][/b]
Este plugin recompensa visualmente a los supervivientes cuando realizan jugadas heroicas o de alta dificultad en Left 4 Dead 2. Al conseguir una "muerte épica", el sistema genera el efecto de partícula nativo "achieved" (un trofeo brillante) sobre el jugador y fuerza un cambio de cámara cinemático a tercera persona durante exactamente 4 segundos. El código ha sido escrito con máxima optimización, utilizando validaciones estrictas de entidades y temporizadores seguros para garantizar cero crasheos y una estabilidad perfecta en tu servidor.

[b][size=4]Features[/size][/b]
[list]
[*] Se activa al matar a un Tank o a una Witch.
[*] Se activa al matar a un Charger con un arma cuerpo a cuerpo (melee) exactamente mientras está embistiendo (charge).
[*] Se activa al cortar la lengua de un Smoker con un arma melee mientras está arrastrando a un superviviente.
[*] Se activa al rescatar a un compañero de un Jockey en un tiempo récord (menos de 1.2 segundos desde el salto).
[*] Efectos 100% visuales integrados de forma nativa (sin descargas molestas para los jugadores).
[/list]

[b][size=4]Commands[/size][/b]
[list]
[*] Ninguno. El plugin es automático y reacciona a los eventos internos del juego.
[/list]

[b][size=4]ConVars[/size][/b]
[list]
[*] Ninguna. Es un plugin "Plug & Play", diseñado para funcionar de inmediato sin requerir configuración adicional.
[/list]

[b][size=4]Requirements[/size][/b]
[list]
[*] Solo SourceMod estándar. No requiere dependencias adicionales.
[/list]

[b][size=4]Notes[/size][/b]
Dado que el código utiliza la partícula nativa "achieved" del propio motor de Left 4 Dead 2, no se requiere subir ni configurar ningún archivo `.pcf` adicional. 
Video de demostración: [Inserta tu enlace de YouTube aquí].

[b][size=4]Installation[/size][/b]
1. Put [b]l4d2_epic_kill_rewards.smx[/b] into your [i]addons/sourcemod/plugins/[/i] folder.
