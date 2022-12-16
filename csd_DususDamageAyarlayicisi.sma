/* Bu eklenti AmxStudio Ile Forum.CSduragi.Com 'icin Gelisitirlmiþtir. */

#include <amxmodx>
#include <amxmisc>
#include <reapi>

#define PLUGIN "Dusus Damagesi Ayarlayicisi"
#define VERSION "1.0"
#define AUTHOR "tahademirbaas"




public plugin_init() {
  register_plugin(PLUGIN, VERSION, AUTHOR);
  RegisterHookChain(RG_CSGameRules_FlPlayerFallDamage, "HasariYiyince", 1)
  if(!cvar_exists("mp_dusushasari")) {
    register_cvar("mp_dusushasari", "20");
  }
}

public HasariYiyince()
{
	SetHookChainReturn(ATYPE_FLOAT, get_cvar_float("mp_dusushasari"))
	return PLUGIN_HANDLED
}  


/*														   CSDURAGI DEVELOPER TEAM 2018
------------------------------------------------------------------------------------------------------------------------------------------------*/


