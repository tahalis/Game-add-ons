
#define DAMAGE_RECIEVED

#include <amxmodx>

new g_MsgSync

#if defined DAMAGE_RECIEVED
	new g_MsgSync2
#endif

public plugin_init()
{
	register_plugin("CSduragi Bullet Damage", "1.0", "Csd. Dev Team-Taha Demirbas")

	register_event("Damage", "hasar_alinca", "b", "2!0", "3=0", "4!0")

	g_MsgSync = CreateHudSyncObj()

#if defined DAMAGE_RECIEVED
	g_MsgSync2 = CreateHudSyncObj()
#endif
}

public hasar_alinca(id)
{
	new attacker = get_user_attacker(id)

#if defined DAMAGE_RECIEVED
	
	if ( is_user_connected(id) && is_user_connected(attacker) )
	{
		new damage = read_data(2)
		new metin[128]
		
		set_hudmessage(255, 0, 0, -1.0, 0.62, 2, 0.1, 4.0, 0.1, 0.1, -1)
		if(damage <= 10 )
			formatex(metin,charsmax(metin),"Kucuk Capli Hasar Alindi %i ",damage)
		if(damage >= 30 && damage >= 10)			
			formatex(metin,charsmax(metin),"Normal Hasar Alindi %i ",damage)		
		if(damage <= 60 && damage >= 30)
			formatex(metin,charsmax(metin),"Orta Capli Hasar Alindi %i ",damage)			
		if(damage <= 75 && damage >= 60)
			formatex(metin,charsmax(metin),"Dusman Buyuk Hasar Verdi %i ",damage)	
		if(damage <= 90 && damage >= 75)
			formatex(metin,charsmax(metin),"Dusman Oldurucu Hasar Verdi %i ",damage)
		if(damage >= 90)
			formatex(metin,charsmax(metin),"Dusman Bitirici Hasar Verdi %i ",damage)

		
		ShowSyncHudMsg(id, g_MsgSync2, "%s^n", metin)
	
		
	
#else
	if ( is_user_connected(attacker) )
	{
		new damage = read_data(2)
#endif
		new metins[128]
		
		set_hudmessage(0, 100, 200, -1.0, 0.59, 2, 0.1, 4.0, 0.02, 0.02, -1)
		if(damage <= 10 )
			formatex(metins,charsmax(metins),"Kucuk Capli Hasar Verildi %i ",damage)
		if(damage >= 30 && damage >= 10)			
			formatex(metins,charsmax(metins),"Normal Hasar Verildi %i ",damage)		
		if(damage <= 60 && damage >= 30)
			formatex(metins,charsmax(metins),"Orta Capli Hasar Verildi %i ",damage)			
		if(damage <= 75 && damage >= 60)
			formatex(metins,charsmax(metins),"Dusmana Buyuk Hasar Verildi %i ",damage)	
		if(damage <= 90 && damage >= 75)
			formatex(metins,charsmax(metins),"Dusmana Oldurucu Hasar Verildi %i ",damage)
		if(damage >= 90)
			formatex(metins,charsmax(metins),"Dusmana Bitirici Hasar Verildi %i ",damage)
	
		ShowSyncHudMsg(attacker, g_MsgSync, "%s^n", metins)

		
	}
}	
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1055\\ f0\\ fs16 \n\\ par }
*/
