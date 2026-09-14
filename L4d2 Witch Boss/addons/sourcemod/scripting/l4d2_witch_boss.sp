#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <left4dhooks> 

#define PLUGIN_VERSION "8.2"
#define SOUND_WITCH "npc/witch/voice/attack/witch_attack_01.wav"

ConVar g_cvEnabled;
bool g_bIsL4D2;
int g_iWitchLight = INVALID_ENT_REFERENCE;
int g_iWitchParticle = INVALID_ENT_REFERENCE;
float g_fGuardCooldown[MAXPLAYERS + 1];

public Plugin myinfo = 
{
    name = "Witch Boss",
    author = "Shadow L4D2",
    description = "Witch boss events & effects",
    version = PLUGIN_VERSION,
    url = ""
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
    g_bIsL4D2 = (GetEngineVersion() == Engine_Left4Dead2);
    return APLRes_Success;
}

public void OnPluginStart()
{
    g_cvEnabled = CreateConVar("l4d_witch_boss_enable", "1", "1 = Activar plugin", FCVAR_NOTIFY);

    RegConsoleCmd("sm_witch", Cmd_WitchInfo);

    HookEvent("witch_harasser_set", Event_WitchStartled);
    HookEvent("witch_killed", Event_WitchKilled);
    HookEvent("round_start", Event_RoundReset, EventHookMode_PostNoCopy);
    HookEvent("round_end", Event_RoundReset, EventHookMode_PostNoCopy);
    
    AutoExecConfig(true, "l4d2_witch_boss");
}

public void OnMapStart()
{
    PrecacheSound(SOUND_WITCH, true);
    PrecacheParticle("fire_small"); 
}

public void Event_RoundReset(Event event, const char[] name, bool dontBroadcast)
{
    CleanUpEffects();
    for (int i = 1; i <= MaxClients; i++) g_fGuardCooldown[i] = 0.0;
}

public Action Cmd_WitchInfo(int client, int args)
{
    if (client <= 0 || !IsClientInGame(client)) return Plugin_Handled;

    for (int i = 1; i <= MaxClients; i++)
    {
        if (IsClientInGame(i) && !IsFakeClient(i) && CheckCommandAccess(i, "sm_admin", ADMFLAG_ROOT, true))
        {
            if (client == i) 
            {
                PrintToChat(i, "\x04[WITCH BOSS]\x01 Sistema \x03ACTIVO\x01.");
                PrintCenterText(i, "*** PRECAUCION ***\nLa Witch tiene guardias.");
            }
            else
            {
                PrintToChat(i, "\x04[ADMIN]\x01 \x03%N \x01reviso el estado de la Witch.", client);
            }
        }
    }
    return Plugin_Handled;
}

public void Event_WitchStartled(Event event, const char[] name, bool dontBroadcast)
{
    if (!g_cvEnabled.BoolValue) return;

    int witch = event.GetInt("witchid");
    int userid = event.GetInt("userid");
    int client = GetClientOfUserId(userid);

    if (witch > 0 && IsValidEntity(witch))
    {
        SetEntProp(witch, Prop_Data, "m_iHealth", 2700);
        if (g_bIsL4D2) SetEntProp(witch, Prop_Data, "m_iMaxHealth", 2700);

        CreateFireEffects(witch);
        EmitSoundToAll(SOUND_WITCH, SOUND_FROM_PLAYER, SNDCHAN_AUTO, SNDLEVEL_NONE, SND_NOFLAGS, 1.0);
        
        if (client > 0 && IsClientInGame(client))
        {
            PrintCenterTextAll("!!! %N ASUSTO A LA WITCH !!!", client);
            PrintToChatAll("\x04[Witch]\x01 \x03%N \x01desato a la Witch.", client);
        }

        L4D_ForcePanicEvent();
        
        int door = -1;
        while ((door = FindEntityByClassname(door, "prop_door_rotating_checkpoint")) != -1)
        {
            AcceptEntityInput(door, "Unlock");
            AcceptEntityInput(door, "Open");
        }

        DataPack pack;
        CreateDataTimer(0.3, Timer_WitchActive, pack, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
        pack.WriteCell(EntIndexToEntRef(witch));
        pack.WriteCell(userid);
    }
}

public Action Timer_WitchActive(Handle timer, DataPack pack)
{
    pack.Reset();
    int witch = EntRefToEntIndex(pack.ReadCell());
    int target = GetClientOfUserId(pack.ReadCell());

    char sClass[32];
    if (witch <= 0 || !IsValidEntity(witch) || !GetEntityClassname(witch, sClass, sizeof(sClass)) || !StrEqual(sClass, "witch") || GetEntProp(witch, Prop_Data, "m_iHealth") <= 0)
    {
        CleanUpEffects();
        return Plugin_Stop;
    }

    float wPos[3];
    GetEntPropVector(witch, Prop_Send, "m_vecOrigin", wPos);

    for (int i = 1; i <= MaxClients; i++)
    {
        if (i == target || !IsClientInGame(i) || !IsPlayerAlive(i) || GetClientTeam(i) != 2) 
            continue;

        float pPos[3];
        GetClientAbsOrigin(i, pPos);
        
        if (GetVectorDistance(wPos, pPos) < 450.0 && GetGameTime() > g_fGuardCooldown[i])
        {
            SpawnSpecialGuard(i);
            g_fGuardCooldown[i] = GetGameTime() + 15.0; 
        }
    }

    return Plugin_Continue;
}

void SpawnSpecialGuard(int client)
{
    if (client <= 0 || !IsClientInGame(client)) return;

    int rand = GetRandomInt(1, 4);
    char sZombie[32];

    if (g_bIsL4D2)
    {
        switch(rand)
        {
            case 1: sZombie = "hunter";
            case 2: sZombie = "jockey";
            case 3: sZombie = "charger";
            case 4: sZombie = "smoker";
        }
    }
    else 
    {
        switch(rand)
        {
            case 1: sZombie = "hunter";
            case 2: sZombie = "smoker";
            case 3: sZombie = "hunter";
            case 4: sZombie = "smoker";
        }
    }

    int flags = GetCommandFlags("z_spawn");
    SetCommandFlags("z_spawn", flags & ~FCVAR_CHEAT);
    FakeClientCommand(client, "z_spawn %s auto", sZombie);
    SetCommandFlags("z_spawn", flags);

    PrintToChat(client, "\x04[Witch]\x01 Un \x03%s\x01 aparecio para defender a la Witch.", sZombie);
}

void CreateFireEffects(int witch)
{
    CleanUpEffects(); 

    char sTargetName[32];
    Format(sTargetName, sizeof(sTargetName), "witch_boss_%d", witch);
    DispatchKeyValue(witch, "targetname", sTargetName);

    float vPos[3];
    GetEntPropVector(witch, Prop_Send, "m_vecOrigin", vPos);

    int light = CreateEntityByName("light_dynamic");
    if (light > 0 && IsValidEntity(light))
    {
        DispatchKeyValue(light, "_light", "255 120 0 255");
        DispatchKeyValue(light, "brightness", "8");
        DispatchKeyValue(light, "distance", "400");
        DispatchKeyValue(light, "style", "0");
        
        TeleportEntity(light, vPos, NULL_VECTOR, NULL_VECTOR);
        DispatchSpawn(light);
        AcceptEntityInput(light, "TurnOn");
        SetVariantString(sTargetName);
        AcceptEntityInput(light, "SetParent");
        SetVariantString("chest");
        AcceptEntityInput(light, "SetParentAttachment");

        g_iWitchLight = EntIndexToEntRef(light);
    }

    int particle = CreateEntityByName("info_particle_system");
    if (particle > 0 && IsValidEntity(particle))
    {
        DispatchKeyValue(particle, "effect_name", "fire_small"); 
        
        TeleportEntity(particle, vPos, NULL_VECTOR, NULL_VECTOR);
        DispatchSpawn(particle);
        ActivateEntity(particle);
        AcceptEntityInput(particle, "Start");
        SetVariantString(sTargetName);
        AcceptEntityInput(particle, "SetParent");
        SetVariantString("chest");
        AcceptEntityInput(particle, "SetParentAttachment");

        g_iWitchParticle = EntIndexToEntRef(particle);
    }
}

public void Event_WitchKilled(Event event, const char[] name, bool dontBroadcast)
{
    if (!g_cvEnabled.BoolValue) return;

    int client = GetClientOfUserId(event.GetInt("userid"));
    if (client > 0 && client <= MaxClients && IsClientInGame(client))
    {
        PrintToChatAll("\x04[Witch]\x01 Murio por: \x03%N", client);
    }
    
    CleanUpEffects();
}

void CleanUpEffects()
{
    int light = EntRefToEntIndex(g_iWitchLight);
    if (light > 0 && IsValidEntity(light)) AcceptEntityInput(light, "Kill");
    g_iWitchLight = INVALID_ENT_REFERENCE;

    int particle = EntRefToEntIndex(g_iWitchParticle);
    if (particle > 0 && IsValidEntity(particle)) AcceptEntityInput(particle, "Kill");
    g_iWitchParticle = INVALID_ENT_REFERENCE;
}

stock int PrecacheParticle(const char[] sEffectName)
{
    static int table = INVALID_STRING_TABLE;
    if (table == INVALID_STRING_TABLE)
    {
        table = FindStringTable("ParticleEffectNames");
    }
    
    int index = FindStringIndex(table, sEffectName);
    if (index == INVALID_STRING_INDEX)
    {
        bool save = false;
        AddToStringTable(table, sEffectName);
        index = FindStringIndex(table, sEffectName);
    }
    return index;
}
