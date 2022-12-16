/* Bu eklenti AmxStudio Ile Forum.CSduragi.Com 'icin Gelisitirlmiþtir. */

#include <amxmodx>
#include <amxmisc>
#include <reapi>

#define PLUGIN "Dusus Damagesi Ayarlayicisi"
#define VERSION "1.5"
#define AUTHOR "tahademirbaas"

new hp


public plugin_init() {
  register_plugin(PLUGIN, VERSION, AUTHOR);
  RegisterHookChain(RG_CSGameRules_FlPlayerFallDamage, "HasariYiyince", 1)
 
  hp =  register_cvar("mp_dusushasari", "20");
  
}

public HasariYiyince()
{
	SetHookChainReturn(ATYPE_FLOAT, get_pcvar_float(hp))
	
	
	return PLUGIN_HANDLED
}  


/*														   CSDURAGI DEVELOPER TEAM 2018
------------------------------------------------------------------------------------------------------------------------------------------------*/


