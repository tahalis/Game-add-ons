/* ======================================================
Plugin Adi: SupplyBox
Tur: Addon
Version: 1.1
Author: Dias Pro Ceviri : redarmy gaming  community
Aciklama : Cok ilgi gordugunden dolayi Pro mod'a dondurmeyi dusunduk. boylece bu plugini yukleyen herkez
dm,bk,dr modlarinda kullanabileceklerdir. Bu surumun cevirisi Csduraðý Dev. Team 'a aittir. 

====================================================== */
#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <fakemeta>
#include <xs>
#include <cstrike>
#include <fun>
#include <hamsandwich>
#define PLUGIN "SupplyBox Pro Version"
#define VERSION "3.0"
#define AUTHOR "Dias Ceviri RedarmyGaming"

// ======================= SUPPLYBOX CONFIG ======================== // 
#define SUPPLYBOX_CLASSNAME "supplybox"
#define TASK_SUPPLYBOX 128256
#define TASK_SUPPLYBOX2 138266
#define TASK_SUPPLYBOX_HELP 129257
#define TASK_SUPPLYBOX_WAIT 130259

new const SISTAG[] = "SUPPLYBOX III"
const MAX_SUPPLYBOX_ENT = 100
new const supplybox_spawn_file[] = "%s/supplybox/%s.cfg"
new const supplybox_item_file[] = "%s/supplybox.ini"
new const supplybox_extraitem_file[] = "%s/extra_supplybox.ini"
new const supplybox_icon_spr[] = "sprites/supplybox_plague/icon_supplybox.spr"
new const supplybox_model[][] = {
	"models/supplybox_plague/supplybox.mdl"
}
new const supplybox_drop_sound[][] = {
	"supplybox_plague/supplybox_drop.wav"
}
new const supplybox_pickup_sound[][] = {
	"supplybox_plague/supplybox_pickup.wav"
}
// ======================= END OF SUPPLYBOX CONFIG ======================== // 

// Below here is hard code. Don't edit anything except cvars
new g_supplybox_num, g_supplybox_wait[33], supplybox_count, Array:supplybox_item, Array:supplybox_extraitem, 
supplybox_ent[MAX_SUPPLYBOX_ENT], g_supplybox_icon_id, Float:g_supplybox_spawn[MAX_SUPPLYBOX_ENT][3],
g_total_supplybox_spawn
new cvar_supplybox_icon, cvar_supplybox_max, cvar_supplybox_num, cvar_supplybox_totalintime, 
cvar_supplybox_time, cvar_supplybox_delaytime, cvar_supplybox_icon_size, cvar_supplybox_icon_light
new bool:made_supplybox, Float:g_icon_delay[33], g_newround = 1, g_endround = 1
new boxstil,roundmode,soundmode

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	register_event("HLTV", "event_newround", "a", "1=0", "2=0")
	register_logevent("logevent_round_end", 2, "1=Round_End")
	
	register_forward(FM_Touch, "fw_supplybox_touch")
	register_clcmd("/kutuat","create_supplybox",ADMIN_CVAR)
	
	cvar_supplybox_max = register_cvar("supplybox_max", "22")
	cvar_supplybox_num = register_cvar("supplybox_num", "11")
	cvar_supplybox_totalintime = register_cvar("supplybox_totalintime", "4")
	cvar_supplybox_time = register_cvar("supplybox_time", "50.0")
	cvar_supplybox_icon = register_cvar("supplybox_icon", "1")
	cvar_supplybox_delaytime = register_cvar("supplybox_icon_delay_time", "0.03")	
	cvar_supplybox_icon_size = register_cvar("supplybox_icon_size", "2")
	cvar_supplybox_icon_light = register_cvar("supplybox_icon_light", "100")
	boxstil = register_cvar("supplybox_mod","1") // 1- Normal silahlar // 2- Extra itemler // 3- Karisik
	roundmode = register_cvar("supplybox_roundmod","1") // 0 olur ise Süreli Atacaktir. 1- olur Ýse Round Basindan Ýtibaren Sure Sayacaktir Ve Tek sefer Atacaktir. 3- olur Ise Islem Yapilmayacaktir.! 
	soundmode = register_cvar("supplybox_sound","1")
	

	//zp_user_infected_post()
	
	if(get_pcvar_num(roundmode) == 0){
		//set_task(35.0,"create_supplybox")
		set_task(get_pcvar_float(cvar_supplybox_time),"create_supplybox",_,_,_,"b")
	}
	set_task(2.0, "update_radar", _, _, _, "b")
	return PLUGIN_HANDLED
	
}






public plugin_precache()
{
	supplybox_item = ArrayCreate(64, 1)
	supplybox_extraitem = ArrayCreate(64, 1)
	
	
	load_supplybox_spawn()
	load_supplybox_item()
	load_supplybox_extraitem()
	
	static i
	for(i = 0; i < sizeof(supplybox_model); i++)
		engfunc(EngFunc_PrecacheModel, supplybox_model[i])
	for(i = 0; i < sizeof(supplybox_drop_sound); i++)
		engfunc(EngFunc_PrecacheSound, supplybox_drop_sound[i])		
	for(i = 0; i < sizeof(supplybox_pickup_sound); i++)
		engfunc(EngFunc_PrecacheSound, supplybox_pickup_sound[i])
		
	g_supplybox_icon_id = engfunc(EngFunc_PrecacheModel, supplybox_icon_spr)
}

public plugin_cfg()
{
	set_task(0.5, "event_newround")
}

public load_supplybox_spawn()
{
	// Check for spawns points of the current map
	new cfgdir[32], mapname[32], filepath[100], linedata[64]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(filepath, charsmax(filepath), supplybox_spawn_file, cfgdir, mapname)
	
	// Load spawns points
	if (file_exists(filepath))
	{
		new file = fopen(filepath,"rt"), row[4][6]
		
		while (file && !feof(file))
		{
			fgets(file, linedata, charsmax(linedata))
			
			// invalid spawn
			if(!linedata[0] || str_count(linedata,' ') < 2) continue;
			
			// get spawn point data
			parse(linedata,row[0],5,row[1],5,row[2],5)
			
			// origin
			g_supplybox_spawn[g_total_supplybox_spawn][0] = floatstr(row[0])
			g_supplybox_spawn[g_total_supplybox_spawn][1] = floatstr(row[1])
			g_supplybox_spawn[g_total_supplybox_spawn][2] = floatstr(row[2])

			g_total_supplybox_spawn++
			if (g_total_supplybox_spawn >= MAX_SUPPLYBOX_ENT) 
				break
		}
		if (file) fclose(file)
	}
}

public load_supplybox_item() 
{
	new filepath[64]
	get_configsdir(filepath, charsmax(filepath))
	format(filepath, charsmax(filepath), supplybox_item_file, filepath)
	
	if (!file_exists(filepath))	
	{
		new error_msg[100]
		formatex(error_msg, charsmax(error_msg), "[SupplyBox][Hata] Item dosyasi Bulunamadi.!")
		set_fail_state(error_msg)
		return
	}
	
	new line[1024], key[64], value[960]
	new file = fopen(filepath, "rt")
	
	while (!feof(file) && file)
	{
		fgets(file, line, charsmax(line));
		replace(line, charsmax(line), "^n", "")
		
		if (!line[0] || line[0] == ';')
			continue
		
		strtok(line, key, charsmax(key), value, charsmax(value), '=')
		trim(key)
		trim(value)
		
		if (equali(key, "SUPPLYBOX_ITEM")) 
		{
			while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ',')) 
			{
				trim(key)
				trim(value)
				ArrayPushString(supplybox_item, key)
			}
		}
	}
}

public load_supplybox_extraitem(){
	
	
	
	
	new filepath[64]
	get_configsdir(filepath, charsmax(filepath))
	format(filepath, charsmax(filepath), supplybox_extraitem_file, filepath)
	
	if (!file_exists(filepath))	
	{
		new error_msg[100]
		formatex(error_msg, charsmax(error_msg), "[SupplyBox][Hata] Item dosyasi Bulunamadi.!(extra_supplybox.ini)")
		set_fail_state(error_msg)
		return
	}
	
	new line[1024], key[64], value[960]
	new file = fopen(filepath, "rt")
	
	while (!feof(file) && file)
	{
		fgets(file, line, charsmax(line));
		replace(line, charsmax(line), "^n", "")
		
		if (!line[0] || line[0] == ';')
			continue
		
		strtok(line, key, charsmax(key), value, charsmax(value), '=')
		trim(key)
		trim(value)
		
		if (equali(key, "SUPPLYBOX_ITEM")) 
		{
			while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ',')) 
			{
				trim(key)
				trim(value)
				ArrayPushString(supplybox_extraitem, key)
			}
		}
	
		
	}
	
	
	
	
	
	
	
	
	
}
public update_radar()
{	
	for (new id = 1; id <= get_maxplayers(); id++)
	{
		if (!is_user_alive(id) || !supplybox_count) 
			continue
		
		static i, next_ent
		i = 1
		while(i <= supplybox_count)
		{
			next_ent = supplybox_ent[i]
			if (next_ent && is_valid_ent(next_ent))
			{
				static Float:origin[3]
				pev(next_ent, pev_origin, origin)
				
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("HostagePos"), {0,0,0}, id)
				write_byte(id)
				write_byte(i)		
				write_coord(floatround(origin[0]))
				write_coord(floatround(origin[1]))
				write_coord(floatround(origin[2]))
				message_end()
			
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("HostageK"), {0,0,0}, id)
				write_byte(i)
				message_end()
			}

			i++
		}
	}
}

public event_newround()
{
	made_supplybox = false
	g_newround = 1
	g_endround = 1
	
	
	supplybox_count = 0
	
	
	
	if(get_pcvar_num(roundmode) == 1){
		if(task_exists(TASK_SUPPLYBOX)) remove_task(TASK_SUPPLYBOX)
		if(task_exists(TASK_SUPPLYBOX2)) remove_task(TASK_SUPPLYBOX2)
		if(task_exists(TASK_SUPPLYBOX_HELP)) remove_task(TASK_SUPPLYBOX_HELP)
		//set_task(35.0,"create_supplybox")
		
		set_task(get_pcvar_float(cvar_supplybox_time),"create_supplybox")
		ColorChat(0,"^4[%s]^3 %d Saniye^4 Sonra Yardim Kutulari Atilacak Onlari Bul!",SISTAG,get_pcvar_num(cvar_supplybox_time))
	}
	
}

public logevent_round_end() g_endround = 1

public zp_user_infected_post()
{
	if(!made_supplybox)
	{
		g_newround = 1
		made_supplybox = true
		
		if(task_exists(TASK_SUPPLYBOX)) remove_task(TASK_SUPPLYBOX)
		
		if(!g_total_supplybox_spawn)
		{
			client_print(0, print_console, "[SupplyBox][Hata] Kutu atilacak bolgeler belirli degil Bolge olustur.!")
		} else {
			set_task(get_pcvar_float(cvar_supplybox_time), "create_supplybox", TASK_SUPPLYBOX)

		}
	}
	return PLUGIN_HANDLED
}

public client_PostThink(id)
{
	if (!get_pcvar_num(cvar_supplybox_icon) || !is_user_alive(id))
		return
	if((g_icon_delay[id] + get_pcvar_float(cvar_supplybox_delaytime)) > get_gametime())
		return
		
	g_icon_delay[id] = get_gametime()

	if (supplybox_count)
	{
		static i, box_ent
		i = 1
		
		while (i <= supplybox_count)
		{
			box_ent = supplybox_ent[i]
			create_icon_origin(id, box_ent, g_supplybox_icon_id)
			i++
		}
	}
}

public create_supplybox()
{
	remove_supplybox()
	//client_print(0, print_chat, "Yardim Kutusu Atiliyor...!")
	if (supplybox_count >= get_pcvar_num(cvar_supplybox_max)) 
		return

	if(g_newround || g_endround){
		
		
	}
	if (task_exists(TASK_SUPPLYBOX)) remove_task(TASK_SUPPLYBOX)
	//set_task(get_pcvar_float(cvar_supplybox_time), "create_supplybox", TASK_SUPPLYBOX)
	
	if (get_total_supplybox() >= get_pcvar_num(cvar_supplybox_totalintime)) 
		return
	//client_print(0, print_chat, "Yardim Kutusu Atiliyor Bul onu!")
	g_supplybox_num = 0
	create_supplybox2()
	
	static random_sound
	random_sound = random_num(0, charsmax(supplybox_drop_sound))
	if(get_pcvar_num(soundmode) == 1)
		client_cmd(0, "spk ^"%s^"", supplybox_drop_sound[random_sound])
	
	for(new i = 0; i < get_maxplayers(); i++)
	{
		if(is_user_alive(i) && is_user_connected(i)){
			ColorChat(i,"^4[%s]^3 Yardim Kutulari Atildi Onlari Bul!",SISTAG)
			client_print(i, print_center, "Yardim Kutusu Atildi Bul Onu..!")
		}
	}
	
	if (task_exists(TASK_SUPPLYBOX_HELP)) remove_task(TASK_SUPPLYBOX_HELP)
	set_task(3.0, "show_supplybox_help", TASK_SUPPLYBOX_HELP)

	if (task_exists(TASK_SUPPLYBOX2)) remove_task(TASK_SUPPLYBOX2)
	set_task(0.5, "create_supplybox2", TASK_SUPPLYBOX2, _, _, "b")	
}

public create_supplybox2()
{
	if (supplybox_count >= get_pcvar_num(cvar_supplybox_max) || get_total_supplybox() >= get_pcvar_num(cvar_supplybox_totalintime))
	{
		remove_task(TASK_SUPPLYBOX2)
		return
	}
	
	if(g_newround || g_endround){
	
	}
	supplybox_count++
	g_supplybox_num++

	static item
	static extraitem

	
	new ent
	if(get_pcvar_num(boxstil) == 1){
		
		
		
		item = random(ArraySize(supplybox_item))

		ent = create_entity("info_target")
	
		entity_set_string(ent, EV_SZ_classname, SUPPLYBOX_CLASSNAME)
		entity_set_model(ent, supplybox_model[random_num(0, charsmax(supplybox_model))])	
		entity_set_size(ent,Float:{-2.0,-2.0,-2.0},Float:{5.0,5.0,5.0})
		entity_set_int(ent,EV_INT_solid,1)
		entity_set_int(ent,EV_INT_movetype,6)
		entity_set_int(ent, EV_INT_iuser1, item)
		entity_set_int(ent, EV_INT_iuser2, supplybox_count)
	}
	if(get_pcvar_num(boxstil) == 2){
		
		
		
		extraitem = random(ArraySize(supplybox_extraitem))
	
		
		ent = create_entity("info_target")
	
		entity_set_string(ent, EV_SZ_classname, SUPPLYBOX_CLASSNAME)
		entity_set_model(ent, supplybox_model[random_num(0, charsmax(supplybox_model))])	
		entity_set_size(ent,Float:{-2.0,-2.0,-2.0},Float:{5.0,5.0,5.0})
		entity_set_int(ent,EV_INT_solid,1)
		entity_set_int(ent,EV_INT_movetype,6)
		entity_set_int(ent, EV_INT_iuser3, extraitem)
		
		
		entity_set_int(ent, EV_INT_iuser2, supplybox_count)
	}
	if(get_pcvar_num(boxstil) == 3){
		
	
					
		item = random(ArraySize(supplybox_item))
		extraitem = random(ArraySize(supplybox_extraitem))
	
		
		ent = create_entity("info_target")
	
		entity_set_string(ent, EV_SZ_classname, SUPPLYBOX_CLASSNAME)
		entity_set_model(ent, supplybox_model[random_num(0, charsmax(supplybox_model))])	
		entity_set_size(ent,Float:{-2.0,-2.0,-2.0},Float:{5.0,5.0,5.0})
		entity_set_int(ent,EV_INT_solid,1)
		entity_set_int(ent,EV_INT_movetype,6)
		entity_set_int(ent, EV_INT_iuser1, item)
		entity_set_int(ent, EV_INT_iuser3, extraitem)
		
		
		entity_set_int(ent, EV_INT_iuser2, supplybox_count)
					
				
					
				
				
	
	}
	
	static Float:Origin[3]
	collect_spawn_point(Origin)
	engfunc(EngFunc_SetOrigin, ent, Origin)
	
	supplybox_ent[supplybox_count] = ent

	if ((g_supplybox_num >= get_pcvar_num(cvar_supplybox_num)) && task_exists(TASK_SUPPLYBOX2)) 
		remove_task(TASK_SUPPLYBOX2)
}

public get_total_supplybox()
{
	new total
	for (new i = 1; i <= supplybox_count; i++)
	{
		if (supplybox_ent[i]) total += 1
	}
	return total
}

public show_supplybox_help()
{
	for(new i = 0; i < get_maxplayers(); i++)
	{
		if(is_user_alive(i) && is_user_connected(i)){
			client_print(i, print_center, "Yardim Kutularinin Yerleri Radarina Eklendi..!")
			ColorChat(i,"^4[%s]^3 Yardim Kutulari Radarina Eklendi.!",SISTAG)
		}

	}
}

public remove_supplybox()
{
	remove_ent_by_class(SUPPLYBOX_CLASSNAME)
	new supplybox_ent_reset[MAX_SUPPLYBOX_ENT]
	supplybox_ent = supplybox_ent_reset
	client_print(0, print_center, "Yardim Kutulari Toplaniyor...!")
	ColorChat(0,"^4[%s]^3 Yardim Kutulari Toplaniyor..",SISTAG)

	return PLUGIN_HANDLED
}

public fw_supplybox_touch(ent, id)
{
	if (!is_user_alive(id)) 
		return FMRES_IGNORED
	
	static classname[32]
	entity_get_string(ent,EV_SZ_classname,classname,31)
	
	if (equal(classname, SUPPLYBOX_CLASSNAME))
	{
		
		static item_id, item[64], extraitem[64]
		static name[32]
		get_user_name(id, name, sizeof(name))
		
		if(get_pcvar_num(boxstil) == 1){
			
			
			
			item_id = entity_get_int(ent, EV_INT_iuser1)
			ArrayGetString(supplybox_item, item_id, item, charsmax(item))
			
			give_item(id, item)
			give_item(id, "ammo_50ae")
			give_item(id, "ammo_338magnum")
			give_item(id, "ammo_556nato")
			give_item(id, "ammo_buckshot")
			give_item(id, "ammo_45acp")
			give_item(id, "ammo_9mm")
			
			
			client_print(0, print_center, "%s Yardim Kutusundan %s Buldu..!", name, item)
			ColorChat(0,"^4[%s]^3 %s^4 Yardim Kutusundan^3 %s^4 Buldu..!",SISTAG,name,item)

			
			
		}
		
		
		if(get_pcvar_num(boxstil) == 2){
			
			
			
			 
				
					
			item_id = entity_get_int(ent, EV_INT_iuser3)
			ArrayGetString(supplybox_extraitem, item_id, extraitem, charsmax(extraitem))
			client_cmd(id,extraitem)
			client_cmd(id,"clear")
			give_item(id, "ammo_50ae")
			give_item(id, "ammo_338magnum")
			give_item(id, "ammo_556nato")
			give_item(id, "ammo_buckshot")
			give_item(id, "ammo_45acp")
			give_item(id, "ammo_9mm")
			
			client_print(0, print_center, "%s Yardim Kutusundan Extra Item Buldu..!", name)
			ColorChat(0,"^4[%s]^3 %s^4 Yardim Kutusundan^3 Extra Item^4 Buldu..!",SISTAG,name)

				
				
			
			
			
			
			
		}
		
		if(get_pcvar_num(boxstil) == 3){
			
		
			switch (random_num(0, 1))
			{
				case 0:
				{
					item_id = entity_get_int(ent, EV_INT_iuser1)
					ArrayGetString(supplybox_item, item_id, item, charsmax(item))
			
					give_item(id, item)
					give_item(id, "ammo_50ae")
					give_item(id, "ammo_338magnum")
					give_item(id, "ammo_556nato")
					give_item(id, "ammo_buckshot")
					give_item(id, "ammo_45acp")
					give_item(id, "ammo_9mm")
			
			
					client_print(0, print_center, "%s Yardim Kutusundan %s Buldu..!", name, item)
					ColorChat(0,"^4[%s]^3 %s^4 Yardim Kutusundan^3 %s^4 Buldu..!",SISTAG,name,item)

				
				
				
				}
				case 1:
				{
				
						
					
					item_id = entity_get_int(ent, EV_INT_iuser3)
					ArrayGetString(supplybox_extraitem, item_id, extraitem, charsmax(extraitem))
					client_cmd(id,extraitem)
					client_cmd(id,"clear")
					give_item(id, "ammo_50ae")
					give_item(id, "ammo_338magnum")
					give_item(id, "ammo_556nato")
					give_item(id, "ammo_buckshot")
					give_item(id, "ammo_45acp")
					give_item(id, "ammo_9mm")
			
					client_print(0, print_center, "%s Yardim Kutusundan Extra Item Buldu..!", name)
					ColorChat(0,"^4[%s]^3 %s^4 Yardim Kutusundan^3 Extra Item^4 Buldu..!",SISTAG,name)

						
						
				
					
				
				
				}
		
				
				
				
			}	
			
			
			
			
		}
		
		
		
			
	
		
		static random_sound
		random_sound = random_num(0, charsmax(supplybox_pickup_sound))
		if(get_pcvar_num(soundmode) == 1)
			emit_sound(id, CHAN_VOICE, supplybox_pickup_sound[random_sound], 1.0, ATTN_NORM, 0, PITCH_NORM)

		new num_box = entity_get_int(ent, EV_INT_iuser2)
		supplybox_ent[num_box] = 0
		remove_entity(ent)

		g_supplybox_wait[id] = 1
		if (task_exists(id+TASK_SUPPLYBOX_WAIT)) remove_task(id+TASK_SUPPLYBOX_WAIT)
		set_task(2.0, "remove_supplybox_wait", id+TASK_SUPPLYBOX_WAIT)
	}
	
	return FMRES_IGNORED
}

public remove_supplybox_wait(id)
{
	id -= TASK_SUPPLYBOX_WAIT
	
	g_supplybox_wait[id] = 0
	if (task_exists(id+TASK_SUPPLYBOX_WAIT)) remove_task(id+TASK_SUPPLYBOX_WAIT)
}

stock collect_spawn_point(Float:origin[3]) // By Sontung0
{
	for (new i = 1; i <= g_total_supplybox_spawn *3 ; i++)
	{
		origin = g_supplybox_spawn[random(g_total_supplybox_spawn)]
		if (check_spawn_box(origin)) return 1;
	}

	return 0;
}
stock check_spawn_box(Float:origin[3]) // By Sontung0
{
	new Float:originE[3], Float:origin1[3], Float:origin2[3]
	new ent = -1
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", SUPPLYBOX_CLASSNAME)) != 0)
	{
		pev(ent, pev_origin, originE)
		
		// xoy
		origin1 = origin
		origin2 = originE
		origin1[2] = origin2[2] = 0.0
		if (vector_distance(origin1, origin2) <= 32.0) return 0;
	}
	return 1;
}

stock create_icon_origin(id, ent, sprite) // By sontung0
{
	if (!pev_valid(ent)) return;
	
	new Float:fMyOrigin[3]
	entity_get_vector(id, EV_VEC_origin, fMyOrigin)
	
	new target = ent
	new Float:fTargetOrigin[3]
	entity_get_vector(target, EV_VEC_origin, fTargetOrigin)
	fTargetOrigin[2] += 40.0
	
	if (!is_in_viewcone(id, fTargetOrigin)) return;

	new Float:fMiddle[3], Float:fHitPoint[3]
	xs_vec_sub(fTargetOrigin, fMyOrigin, fMiddle)
	trace_line(-1, fMyOrigin, fTargetOrigin, fHitPoint)
							
	new Float:fWallOffset[3], Float:fDistanceToWall
	fDistanceToWall = vector_distance(fMyOrigin, fHitPoint) - 10.0
	normalize(fMiddle, fWallOffset, fDistanceToWall)
	
	new Float:fSpriteOffset[3]
	xs_vec_add(fWallOffset, fMyOrigin, fSpriteOffset)
	new Float:fScale
	fScale = 0.01 * fDistanceToWall
	
	new scale = floatround(fScale)
	scale = max(scale, 1)
	scale = min(scale, get_pcvar_num(cvar_supplybox_icon_size))
	scale = max(scale, 1)

	te_sprite(id, fSpriteOffset, sprite, scale, get_pcvar_num(cvar_supplybox_icon_light))
}

stock te_sprite(id, Float:origin[3], sprite, scale, brightness) // By sontung0
{	
	message_begin(MSG_ONE, SVC_TEMPENTITY, _, id)
	write_byte(TE_SPRITE)
	write_coord(floatround(origin[0]))
	write_coord(floatround(origin[1]))
	write_coord(floatround(origin[2]))
	write_short(sprite)
	write_byte(scale) 
	write_byte(brightness)
	message_end()
}

stock normalize(Float:fIn[3], Float:fOut[3], Float:fMul) // By sontung0
{
	new Float:fLen = xs_vec_len(fIn)
	xs_vec_copy(fIn, fOut)
	
	fOut[0] /= fLen, fOut[1] /= fLen, fOut[2] /= fLen
	fOut[0] *= fMul, fOut[1] *= fMul, fOut[2] *= fMul
}

stock str_count(const str[], searchchar) // By Twilight Suzuka
{
	new count, i, len = strlen(str)
	
	for (i = 0; i <= len; i++)
	{
		if(str[i] == searchchar)
			count++
	}
	
	return count;
}

stock remove_ent_by_class(classname[])
{
	new nextitem  = find_ent_by_class(-1, classname)
	while(nextitem)
	{
		remove_entity(nextitem)
		nextitem = find_ent_by_class(-1, classname)
	}
}

stock ColorChat(const id, const input[], any:...)
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

