/* Plugin generated by AMXX-Studio */

#include <amxmodx>
#include <amxmisc>
#include <cstrike>

#define PLUGIN "BFROUND SISTEMI"
#define VERSION "2.0"
#define AUTHOR "redarmygaming"
#define SUBKEY "1xx00015511255125"

new const SISTAG[] = "BFROUNDv2" 
new ct_score, terrorist_score; 

new ct_points[64] = 0;
new t_points[64] = 0;

new bfmode,bftransfer,votemapturu
new votemapzamani,bitisroundu
//new hud_info
new puanlar
new g_votemapzamani[64]

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	register_event("DeathMsg", "event_deaths", "a");
	
	puanlar = register_cvar("csd_bfround_points","100")
	bfmode = register_cvar("bfround_mod","1") // 1-ROUND SISTEMI || 2- TEK ROUND || 3-SADECE PUAN EKLE
	bftransfer = register_cvar("bfround_puantransfer","0") // 1- TAKIMLAR ARASI PUAN TRANSFERI || 0- SADECE PUAN ALIMI 
	votemapturu = register_cvar("bfround_mapoylamas�","1") // 1- BFROUND MAP OYLAMASI || 2- HARICI MAP OYLAMASI
	votemapzamani = register_cvar("bfround_votemapsuresi","1.50") // MAP OYLAMA SISTEMLERININ KACINCI SAN�YEDE OYLAMA BASLATTIGI SURE
	bitisroundu = register_cvar("bfround_bitisroundu","5") // ROUNDLU SISTEM 'DE ROUND SAYISI 
	get_pcvar_string(votemapzamani,g_votemapzamani,charsmax(g_votemapzamani))
	//hud_info = CreateHudSyncObj();
	set_task(0.1,"hudgoster",_,_,_,"b")
	ct_points[0] = get_pcvar_num(puanlar)
	t_points[0] = get_pcvar_num(puanlar)
	
	
}


public event_deaths(id){
	
	new victim = read_data(2);
	new attacker = get_user_attacker(victim)
	
	
	
		
	if(cs_get_user_team(attacker) == CS_TEAM_T ){

		
			
		ct_points[0] -= 1
		if(get_pcvar_num(bftransfer) == 1 )
			t_points[0] += 1
		
		//ChatColor(attacker,"^4[%s]^3 Ct Takiminin Sayginligini^4 1^3 Puan Daha Dusurdun.!  ",SISTAG)		
		
	}
	if(cs_get_user_team(attacker) == CS_TEAM_CT  ){
		if(get_pcvar_num(bftransfer) == 1 )
			ct_points[0] += 1

		t_points[0] -= 1
		//ChatColor(attacker,"^4[%s]^3 Te Takiminin Sayginligini^4 1^3 Puan Daha Dusurdun.!  ",SISTAG)	
	}
			
		
	if(ct_points[0] == 0){
		
		
		ChatColor(0,"^4[%s]^3 CT Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 CT Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 CT Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 CT Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		
		
		set_dhudmessage(0, 42, 255, -1.0, 0.24, 3, 6.0, 6.0)
		show_dhudmessage(id, "CT TAKIMI GALIP GELDI..!^nBir Sonraki Roundda Basarilar Dileriz..!")
			 
			 
		if(get_pcvar_num(bfmode) == 1){
			ct_score += 1
			if(terrorist_score == get_pcvar_num(bitisroundu)){
				
				if(get_pcvar_num(bfmode) == 2){
					terrorist_score += 1
					if(get_pcvar_num(votemapturu) == 2){
						set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
					}
				}
				if(get_pcvar_num(votemapturu) == 1){
					// MAP OYLAMA BASLATMA PUBLICI 
				
			
				}
				
				
				
			}
			
			server_cmd("sv_restart","5")
			set_task(5.0,"roundbaslat")
		}
		if(get_pcvar_num(bfmode) == 2){
			ct_score += 1
			
			if(get_pcvar_num(votemapturu) == 2){
				set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
			}
			if(get_pcvar_num(votemapturu) == 1){
				// MAP OYLAMA BASLATMA PUBLICI 
			}
			
		}
		if(get_pcvar_num(bfmode) == 3){
			ct_score += 1	
			set_task(5.0,"roundbaslat")
			if(terrorist_score == get_pcvar_num(bitisroundu)){
				
				if(get_pcvar_num(bfmode) == 2){
					terrorist_score += 1
			
					if(get_pcvar_num(votemapturu) == 2){
						set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
					}
				}
				if(get_pcvar_num(votemapturu) == 1){
					// MAP OYLAMA BASLATMA PUBLICI 
				
			
				}
				
				
				
			}
			
			
		}
		server_cmd("servere iletilecek komut yada plugin komutu")
		
		
		
			
		
	}
	
	
	
	if(t_points[0] == 0){
		ChatColor(0,"^4[%s]^3 T Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 T Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 T Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
		ChatColor(0,"^4[%s]^3 T Takimi^4 Oyunu Kazandi..! ^3",SISTAG)
	
		set_dhudmessage(255, 0, 0, -1.0, 0.24, 3, 6.0, 6.0)
		show_dhudmessage(id, "T TAKIMI GALIP GELDI..!^nBir Sonraki Roundda Basarilar Dileriz..!")
		
		
		if(get_pcvar_num(bfmode) == 1){
			terrorist_score += 1
			
			if(terrorist_score == get_pcvar_num(bitisroundu)){
				
				if(get_pcvar_num(bfmode) == 2){
					terrorist_score += 1
			
					if(get_pcvar_num(votemapturu) == 2){
						set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
					}
				}
				if(get_pcvar_num(votemapturu) == 1){
					// MAP OYLAMA BASLATMA PUBLICI 
				
			
				}
				
				
				
			}
			
			
			server_cmd("sv_restart","5")
			set_task(5.0,"roundbaslat")
		}
		if(get_pcvar_num(bfmode) == 2){
			terrorist_score += 1
			
			if(get_pcvar_num(votemapturu) == 2){
				set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
			}
			if(get_pcvar_num(votemapturu) == 1){
				// MAP OYLAMA BASLATMA PUBLICI 
			}
			
		}
		if(get_pcvar_num(bfmode) == 3){
			terrorist_score += 1	
			set_task(5.0,"roundbaslat")
			if(terrorist_score == get_pcvar_num(bitisroundu)){
				
				if(get_pcvar_num(bfmode) == 2){
					terrorist_score += 1
			
					if(get_pcvar_num(votemapturu) == 2){
						set_cvar_num("mp_timelimit",g_votemapzamani[0])	
				
					}
				}
				if(get_pcvar_num(votemapturu) == 1){
					// MAP OYLAMA BASLATMA PUBLICI 
				
			
				}
				
				
				
			}
		}
		
		server_cmd("servereiletilecek komut yada plugin komutu")
		
			
	}
		
	return PLUGIN_HANDLED
	
	
	
}

public roundbaslat(){
	
	
	set_hudmessage(85, 255, 255, -1.0, 0.29, 0, 6.0, 12.0)
	show_hudmessage(0, "Takim Puanlari Esitlendi!")
	
	ct_points[0] = get_pcvar_num(puanlar)
	t_points[0] = get_pcvar_num(puanlar)	 
	ChatColor(0,"^4[%s]^3 Takim Puanlari Esitlendi Ilk Karsi Takimin Puanini Bitiren^4 +1^3 Sayinin Sahibi Olur.!",SISTAG)
	return PLUGIN_HANDLED	
	
	
	
}


public hudgoster(id){
	
	
	//new timeleft = get_timeleft() 
	
	/*set_hudmessage(255, 212, 42, -1.0, 0.01)
	ShowSyncHudMsg(id, hud_info, "-=%d:%d=-^n-=CT Takimi: [%d]->[%d]||[%d]<-[%d] :T Takimi=-=",timeleft / 60, timeleft % 60,ct_points[0],ct_score,terrorist_score,t_points[0])
	*/	

	// DHUD SYSTEM---------------------------------------------------------------------------------------------
	set_dhudmessage(255, 0, 0, -1.0, 0.0, 3, 6.0, 12.0)
	show_dhudmessage(id, "TE Takimi [%d]->[%d]|                              ",t_points[0],terrorist_score)
	set_dhudmessage(0, 42, 255, -1.0, 0.0, 3, 6.0, 12.0)
	show_dhudmessage(id, "                              |[%d]<-[%d] CT Takimi", ct_score,ct_points[0])
	
	
	
	
	
	
	
}
	
stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4")
	replace_all(msg, 190, "!y", "^3")
	replace_all(msg, 190, "!team", "^1")
	
	if (id) players[0] = id; else get_players(players, count, "ch")
	{
		for (new i = 0; i < count; i++)
		{
			if (is_user_connected(players[i]))
			{
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
				write_byte(players[i]);
				write_string(msg); 
				message_end();
			}
		}
	}
}	
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1055\\ f0\\ fs16 \n\\ par }
*/