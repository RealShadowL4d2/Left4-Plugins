# L4D2 Items Carry Pass Extended

Plugin para **Left 4 Dead 2** que permite pasar o intercambiar armas, ítems y determinados objetos transportables entre supervivientes.

## Versión

**v9.2**

## Mecánica principal

Para pasar un arma o ítem:

1. Acércate al superviviente.
2. Míralo directamente.
3. Mantén **SHIFT**.
4. Pulsa **CLICK DERECHO**.
5. Si el objetivo y el objeto son válidos, se realiza el pase o intercambio.

No es necesario ejecutar ningún comando para utilizar la mecánica principal.

---

# Armas que se pueden pasar

## Pistolas

- Pistol
- Dual Pistols
- Magnum

## SMG

- SMG
- Silenced SMG
- MP5

## Rifles

- M16
- AK-47
- Desert Rifle
- SG552
- FN FAL
- Hunting Rifle
- Military Sniper
- Scout
- AWP

## Escopetas

- Pump Shotgun
- Chrome Shotgun
- Auto Shotgun
- SPAS Shotgun

## Armas especiales

- Grenade Launcher
- M60

## Armas cuerpo a cuerpo

El sistema también permite pasar las armas melee disponibles en Left 4 Dead 2, por ejemplo:

- Baseball Bat
- Cricket Bat
- Crowbar
- Electric Guitar
- Fire Axe
- Frying Pan
- Golf Club
- Katana
- Knife
- Machete
- Tonfa
- Pitchfork
- Shovel

La disponibilidad de determinadas armas melee depende del mapa y de la configuración del servidor.

---

# Ítems que se pueden pasar

## Objetos médicos

- First Aid Kit
- Defibrillator
- Pain Pills
- Adrenaline

## Throwables

- Molotov
- Pipe Bomb
- Vomitjar

## Munición especial

- Incendiary Ammo
- Explosive Ammo

---

# Objetos transportables

También se pueden transferir determinados objetos que el jugador puede llevar físicamente:

- Gascan
- Propane Tank
- Oxygen Tank
- Firework Crate
- Cola
- Gnome

Estos objetos se manejan de forma diferente a las armas normales porque son objetos transportables del juego.

---

# Intercambio de armas

Cuando el jugador receptor ya tiene un arma compatible en el mismo slot, el plugin puede realizar un **intercambio** en lugar de simplemente eliminar el arma del jugador que la entrega.

Cuando corresponde, se intenta conservar:

- Munición del cargador.
- Munición de reserva.
- El arma entregada.

El plugin realiza comprobaciones antes de completar la operación para reducir el riesgo de perder un arma durante el intercambio.

---

# Avisos para todos

Cada **10 segundos**, todos los jugadores reciben un aviso en el chat con únicamente:

```text
[Pass] Comandos: !pass  !passhelp
```

También reciben un **HintText en el recuadro negro del juego**:

```text
Presiona SHIFT+CLICK DERECHO
```

No se utilizan mensajes adicionales de chat para explicar la mecánica.

---

# Comandos

## !pass

Muestra la ayuda del sistema mediante HintText.

## !passhelp

Muestra la ayuda del sistema mediante HintText.

## !pass_toggle

Este comando se mantiene exclusivamente para el **Owner del Listen Server**.

- Solo el Owner puede utilizarlo.
- No se anuncia a los demás jugadores.
- El comando se muestra al Owner cada **60 segundos**.
- Permite activar o desactivar el sistema de pase.

---

# Validaciones

Antes de realizar un pase, el plugin comprueba:

- El jugador está conectado.
- El jugador está vivo.
- El jugador pertenece al equipo Supervivientes.
- El objetivo está conectado.
- El objetivo está vivo.
- El objetivo pertenece al equipo Supervivientes.
- El objetivo no es el mismo jugador.
- La distancia entre ambos está dentro del límite permitido.
- No existe un obstáculo entre ambos jugadores.
- El arma o ítem puede transferirse.
- El objeto transportable es válido para la operación.

---

# Instalación

## Plugin

Coloca el archivo fuente:

```text
l4d2_items_carry_pass_extended_v9_2.sp
```

en:

```text
addons/sourcemod/scripting/
```

Compílalo con `spcomp`.

Después coloca el archivo compilado:

```text
l4d2_items_carry_pass_extended_v9_2.smx
```

en:

```text
addons/sourcemod/plugins/
```

## Dependencias

El plugin utiliza las librerías de SourceMod necesarias para trabajar con entidades, armas y jugadores.

---

# Funcionamiento automático

Una vez cargado el plugin:

- El sistema está disponible automáticamente.
- No necesitas activar ningún comando para comenzar a pasar objetos.
- La combinación principal es:

```text
SHIFT + CLICK DERECHO
```

---

# Compatibilidad

Diseñado para:

- **Left 4 Dead 2**
- SourceMod
- Servidores dedicados.
- Listen Server.

---

# Notas

La disponibilidad de algunas armas melee, armas especiales y objetos depende del mapa, de la campaña y de la configuración del servidor.

El plugin no garantiza que un objeto pueda transferirse si el propio juego impide equiparlo o transportarlo en ese momento.

---

# Créditos

**Plugin:** L4D2 Items Carry Pass Extended  
**Versión:** 9.2  
**Juego:** Left 4 Dead 2  
**Plataforma:** SourceMod
