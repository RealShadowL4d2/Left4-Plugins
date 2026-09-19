# [L4D2] Epic Kill Rewards

## Description
Recompensa visualmente a los supervivientes cuando realizan jugadas heroicas o de alta dificultad en Left 4 Dead 2. Al conseguir una "muerte épica", el sistema genera el efecto de partícula nativo "achieved" (un trofeo brillante) sobre el jugador y fuerza un cambio de cámara cinemático a tercera persona durante exactamente 4 segundos. 

El código ha sido escrito con máxima optimización, utilizando validaciones estrictas de entidades y temporizadores seguros para evitar pérdidas de memoria y garantizar una estabilidad perfecta en tu servidor.

## Features
* **Bosses:** Se activa al matar a un Tank o a una Witch.
* **Charger:** Se activa al matar a un Charger con un arma cuerpo a cuerpo (melee) exactamente mientras está embistiendo (charge).
* **Smoker:** Se activa al cortar la lengua de un Smoker con un arma melee mientras está arrastrando a un superviviente.
* **Jockey:** Se activa al rescatar a un compañero de un Jockey en un tiempo récord (menos de 1.2 segundos desde el salto).
* **Nativo:** Efectos 100% visuales integrados de forma nativa (sin descargas extra para los clientes).

## Commands
* Ninguno. El plugin es automático y se enlaza a los eventos del motor.

## ConVars
* Es un plugin "Plug & Play". No requiere configuración adicional.

## Requirements
<details>
<summary><b> (instalación) - El motor de sourcemod,metamod</b></summary>

* [SourceMod](https://www.sourcemod.net/downloads.php?branch=stable) 1.11 o superior.
* [MetaMod](https://www.sourcemm.net/downloads.php?branch=stable) 1.11 o superior.
* [MetaMod.vdf(https://www.sourcemm.net/vdf)
</details>
## Notes
* Dado que el código utiliza la partícula nativa `"achieved"` del propio motor de Left 4 Dead 2, no se requiere pre-cachear ni configurar ningún archivo `.pcf` personalizado. 
* **Demo:** [Inserta tu enlace de YouTube aquí]

## Installation
1. Descarga el archivo `.smx`.
2. Coloca **l4d2_epic_kill_rewards.smx** en la carpeta `addons/sourcemod/plugins/`.
3. Reinicia tu servidor o escribe `sm plugins load l4d2_epic_kill_rewards` en la consola.

## Changelog

<details>
<summary><b>v1.1 (19-Sep-2026) - Actualización Mayor</b></summary>

* [Fix] Se reescribió y optimizó el código para utilizar el motor nativo de SourcePawn.
* [Add] Nuevo efecto de cámara en tercera persona cinemática durante 4 segundos.
* [Add] Partícula "achieved" añadida a las recompensas de Tank y Witch.
</details>

<details>
<summary><b>v1.0 (12-Sep-2026) - Lanzamiento Inicial</b></summary>

* Lanzamiento público del plugin.
* Soporte base para jugadas épicas contra Chargers, Smokers y Jockeys.
</details>
