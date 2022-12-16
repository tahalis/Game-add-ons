#include <amxmodx>
#include <cstrike>

#define PLUGIN "Custom Crosshair"
#define VERSION "1.6"
#define AUTHOR "ByCha G.MawiLarq"

#define HUD_HIDE_CROSS (1<<6)
#define HUD_DRAW_CROSS (1<<7)

new iMsgCrosshair, g_msgHideWeapon;
new cvar_enabled, cvar_zoom4, cvar_snipers, cvar_knife;

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	register_event("CurWeapon", "Event_CurWeapon", "be", "1=1");
	
	iMsgCrosshair = get_user_msgid("Crosshair");
	g_msgHideWeapon = get_user_msgid("HideWeapon");
	
	cvar_enabled = register_cvar("eklenti_durumu", "1");
	cvar_zoom4 = register_cvar("zoomda_aim", "0");
	cvar_snipers = register_cvar("nisancilarin_crosu", "1");
	cvar_knife = register_cvar("bicakta_cros", "1");
}

public plugin_precache()
{
	precache_generic("sprites/observer.txt");
	precache_generic("sprites/csgo_crosshair_32-sky.spr");
	precache_generic("sprites/csgo_crosshair_64-orange.spr");
}

public Event_CurWeapon(id)
{
	new wpn = read_data(2), cvar = get_pcvar_num(cvar_enabled);

	if(cvar != 0 && cvar != 1)
	{
		Zoom4_CrossHair(id, 0);
		client_print(id, print_center, "Cvar'lar 1 veya 2 olabilir");
		return
	}
	
	if(wpn == CSW_KNIFE)
	{
		if(get_pcvar_num(cvar_knife) == 0)
		{
			Hide_NormalCrosshair(id, cvar);
			show_crosshair(id, 0);
			return
		}
	}
	
	if(get_pcvar_num(cvar_snipers) == 0)
	{
		if(wpn != CSW_AWP && wpn != CSW_SCOUT && wpn != CSW_G3SG1 && wpn != CSW_SG550)
		{
			Zoom4_CrossHair(id, cvar);
		}
	}
	else
	{
		if(cs_get_user_zoom(id) != 2 && cs_get_user_zoom(id) != 3)
			Zoom4_CrossHair(id, cvar);
	}
}

stock Zoom4_CrossHair(id, flag)
{
	if(get_pcvar_num(cvar_zoom4) == 0)
	{
		if(cs_get_user_zoom(id) != 4)
		{
			Hide_NormalCrosshair(id, flag);
			show_crosshair(id, flag);
		}
	}
	else
	{
		Hide_NormalCrosshair(id, flag);
		show_crosshair(id, flag);
	}

}

stock Hide_NormalCrosshair(id, flag)
{
	if(flag == 1)
	{
		message_begin(MSG_ONE, g_msgHideWeapon, _, id);
		write_byte(HUD_HIDE_CROSS);
		message_end();
	}
	else
	{
		message_begin(MSG_ONE, g_msgHideWeapon, _, id);
		write_byte(HUD_DRAW_CROSS);
		message_end();
	}
}

stock show_crosshair(id, flag)
{
	message_begin(MSG_ONE_UNRELIABLE, iMsgCrosshair, _, id);
	write_byte(flag);
	message_end();
}
