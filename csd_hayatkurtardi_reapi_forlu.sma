#include <amxmodx>
#include <reapi>

new const SISTAG[]="CSDURAGI"

new bool:g_alive[MAX_CLIENTS + 1];
new saldiran[MAX_CLIENTS + 1];
new saldirilankimligi[MAX_CLIENTS + 1];

public plugin_init() {
	register_plugin("Hayatini Kurtardi", "1.1", "tahademirbaas"); // Reapi by PurposeLess

	RegisterHookChain(RG_CBasePlayer_TakeDamage, "CBasePlayer_TakeDamage", .post=false);
	RegisterHookChain(RG_CBasePlayer_Spawn, "CBasePlayer_Spawn", .post=true);
	RegisterHookChain(RG_CBasePlayer_Killed, "CBasePlayer_Killed", .post=true);
}

public CBasePlayer_TakeDamage(const pevVictim, pevInflictor, pevAttacker, Float:flDamage, bitsDamageType)
{
	#define unused pevInflictor,flDamage,bitsDamageType

	if(pevVictim == pevAttacker)
	{
		return;
	}

	if(!is_user_alive(pevAttacker) || get_member(pevVictim, m_iTeam) == TEAM_SPECTATOR)
	{
		return;
	}

	get_user_name(pevVictim, saldiran[pevAttacker], charsmax(saldiran))
	saldirilankimligi[pevAttacker] = pevVictim;

	if(task_exists(pevAttacker))
	{
		set_task(5.0, "saldiri_bilgisinisifirla", pevAttacker);
	}
}

public saldiri_bilgisinisifirla(const id)
{
	saldiran[id] = 0;
	saldirilankimligi[id] = 0;
}

public CBasePlayer_Spawn(const id)
{
	if(is_user_alive(id))
	{
		g_alive[id] = true;
	}
}

public CBasePlayer_Killed(const pevVictim, pevAttacker, iGib)
{
	#pragma unused iGib

	g_alive[pevVictim] = false;

	new olenadi[MAX_NAME_LENGTH],oldurenadi[MAX_NAME_LENGTH];
	get_user_name(pevAttacker, oldurenadi, charsmax(oldurenadi));
	get_user_name(pevVictim, olenadi, charsmax(olenadi));

	new players[MAX_CLIENTS], inum;
	static Uid;
	get_players(players, inum);
	for(new i; i<inum; i++)
	{
		Uid = players[i];

		if(saldiran[pevVictim])
		{
			if(pevAttacker != Uid)
			{
				if(g_alive[saldirilankimligi[Uid]] && equali(saldiran[Uid],saldiran[pevVictim]))
				{
					client_print_color(saldirilankimligi[Uid], pevAttacker, "^1[%s]^3 %s^4 Adli Oyuncu^3 %s^4 Adli Oyuncuyu Oldurerek^3 Hayatini Kurtardi..", SISTAG, oldurenadi, olenadi);
				}
			}
		}
	}
}
