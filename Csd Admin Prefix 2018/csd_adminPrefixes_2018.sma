/*  AMX Mod X script*/

#include <amxmodx>
#include <amxmisc>
#include <celltrie>
#include <cstrike>

#define VERSION "2.2018"
#define EDIT "RedarmyGaming"
#define FLAG_LOAD ADMIN_CFG
#define MAX_PREFIXES 33
#define MAX_BAD_PREFIXES 100
new const MODVERSION[] = "V1"
new g_bad_prefix, g_listen, g_listen_flag, g_custom, g_custom_flag, g_say_characters, g_prefix_characters;
new pre_ips_count = 0, pre_names_count = 0, pre_steamids_count, pre_flags_count = 0, bad_prefix_count = 0, i, temp_cvar[2];
new configs_dir[64], file_prefixes[128], file_bad_prefixes[128], text[128], prefix[32], type[2], key[32], length, line = 0, error[256];
new g_saytxt, g_maxplayers, CsTeams:g_team;
new g_typed[192], g_message[192], g_name[32];
new Trie:pre_ips_collect, Trie:pre_names_collect, Trie:pre_steamids_collect, Trie:pre_flags_collect, Trie:bad_prefixes_collect, Trie:client_prefix;
new str_id[16], temp_key[35], temp_prefix[32], temp_value;
new bool:g_toggle[33];

new const say_team_info[2][CsTeams][] =
{
	{"*IZLEYICI* ", "*OLU* ", "*OLU* ", "*IZLEYICI* "},
	{"", "", "", ""}
}

new const sayteam_team_info[2][CsTeams][] =
{
	{"(Izleyici) ", "*OLU*(Terrorist) ", "*OLU*(Counter-Terrorist) ", "(Izleyici) "},
	{"(Izleyici) ", "(Terrorist) ", "(Counter-Terrorist) ", "(Izleyici) "}
}

new const forbidden_say_symbols[] = {
	"/",
	"!",
	"%",
	"$"
}

new const forbidden_prefixes_symbols[] = {
	"/",
	"\",
	"%",
	"$",
	".",
	":",
	"?",
	"!",
	"@",
	"#",
	"%"
}

new const separator[] = "************************************************"
new const in_prefix[] = "[CSD ADMIN PREFIX v2018]"
new const prefixfile[] = "addons/amxmodx/configs/ap_prefixes.ini";
new const usersfile[] = "addons/amxmodx/configs/users.ini";
new iPlayer,displaymode_cvar
public plugin_init()
{
	register_plugin("CSDURAGI ADMIN PREFIX 2018", VERSION, " Alt Yapi m0skVi4a | Cevirmen Ve Ek ozellikler TahaDemirbas")

	g_bad_prefix = register_cvar("ap_bad_prefixes", "1")
	g_listen = register_cvar("ap_listen", "1")
	g_listen_flag = register_cvar("ap_listen_flag", "a")
	g_custom = register_cvar("ap_custom_current", "1")
	g_custom_flag = register_cvar("ap_custom_current_flag", "b")
	g_say_characters = register_cvar("ap_say_characters", "1")
	g_prefix_characters = register_cvar("ap_prefix_characters", "1")
	displaymode_cvar = register_cvar("ap_displaymode","1") // 1 - HERKEZE GOSTER | 0- OLULER VE YASAYANLAR AYRI | 

	g_saytxt = get_user_msgid ("SayText")
	g_maxplayers = get_maxplayers()

	register_concmd("ap_reload_prefixes", "LoadPrefixes")
	register_concmd("ap_reload_badprefixes", "LoadBadPrefixes")
	register_concmd("ap_put", "SetPlayerPrefix")
	register_clcmd("say", "HookSay")
	register_clcmd("say_team", "HookSayTeam")
	register_clcmd("say /prefixmenu", "ShowMenu")
	register_clcmd("YeniTag", "tagekle")
	register_clcmd("IP_ADRES","ipadresi")
	register_clcmd("Tag_Goruntuleme_Yetkisi","tagyetkiekleveyaz")
	register_clcmd("OyuncuNicki","oyuncuismi")

	pre_ips_collect = TrieCreate()
	pre_names_collect = TrieCreate()
	pre_steamids_collect = TrieCreate()
	pre_flags_collect = TrieCreate()
	bad_prefixes_collect = TrieCreate()
	client_prefix = TrieCreate()

	register_dictionary("admin_prefixes.txt")

	get_configsdir(configs_dir, charsmax(configs_dir))
	formatex(file_prefixes, charsmax(file_prefixes), "%s/ap_prefixes.ini", configs_dir)
	formatex(file_bad_prefixes, charsmax(file_bad_prefixes), "%s/ap_bad_prefixes.ini", configs_dir)

	LoadPrefixes(0)
	LoadBadPrefixes(0)
}
	
	
	

public ShowMenu(id, lvl, cid)
{

	if(!access(id,ADMIN_RCON)) {
		ColorChat(id,"^4[%s]^3 Buraya Girmeye Hakkin Yok!",in_prefix)
		return PLUGIN_HANDLED
	}	

	new menu = menu_create("\rCSDURAGI\y PREFIX KONTROL MENUSU\d | v2018^n\wLutfen Cakismalari onlemek icin \rDiger Say\w Eklentilerini Kapatin.!", "MenuDevam");

	menu_additem(menu, "\yYeni Tag Ekle \d| Sayda Gozukecek Yeni Tag Ekler", "", 0); // case 0
	menu_additem(menu, "\wMevcut Tag Listesi\d | Mevcut Taglari Goruntuler", "", 0); // case 1
	menu_additem(menu, "\rCSDADM Prefix Ayarlari\d", "", 0); // case 2
	menu_additem(menu, "\dCSduragi Gelismis Admin PREFIX (c) 2018 ", "", 0); // case 2

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
	menu_setprop(menu, MPROP_BACKNAME, "Geri");
	menu_setprop(menu, MPROP_NEXTNAME, "Ileri");
	menu_setprop(menu, MPROP_EXITNAME, "Cikis");
	menu_setprop(menu, MPROP_NOCOLORS, 1);

	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public MenuDevam(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_cancel(id);
		return PLUGIN_HANDLED;
	}

	new command[6], name[64], access, callback;

	menu_item_getinfo(menu, item, access, command, sizeof command - 1, name, sizeof name - 1, callback);

	switch(item)
	{
		case 0:
		{
			
			
			TagturuMenu(id)

		}
		case 1: 
		{
			
			Taglistesi(id)

			
			
		}
		case 2:
		{
			Ayarlar(id)
			
		}
		case 3: 
		{
			
		}
	}

	menu_destroy(menu);

	return PLUGIN_HANDLED;
}	
	

public Ayarlar(id)
{
	if(!access(id,ADMIN_RCON)) {
		ColorChat(id,"^4[%s]^3 Buraya Girmeye Hakkin Yok!",in_prefix)
		return PLUGIN_HANDLED
	}
	
	
	new menu = menu_create("\rCSDURAGI ADMIN PREFIX \d|| Ayarlar Menusu", "ayarlar_handled");

	if(get_pcvar_num(g_listen) == 1){
		menu_additem(menu, "\yCSD Admin Prefix\d |\y ACIK ", "", 0); // case 0
	}
	else
	{
		menu_additem(menu, "\dCSD Admin Prefix\d |\r KAPALI ", "", 0); // case 0	
	}
	if(get_pcvar_num(g_say_characters) == 1){
		menu_additem(menu, "\ySay Ozel Karakterlerini Gizle\d |\y ACIK", "", 0); // case 1
	}
	else
	{
		menu_additem(menu, "\dSay Ozel Karakterlerini Gizle\d |\r KAPALI", "", 0); // case 1
	}
	if(get_pcvar_num(g_prefix_characters) == 1){
		menu_additem(menu, "\yPrefix Ozel Karakterlerini Filtrele\d |\y ACIK", "", 0); // case 2
	}
	else
	{
		menu_additem(menu, "\dPrefix Ozel Karakterlerini Filtrele\d |\r KAPALI", "", 0); // case 2
	}
	if(get_pcvar_num(displaymode_cvar) == 1){
		menu_additem(menu, "\yOluler Ile Canlilar Arasi Yazili Iletisim\d |\y ACIK", "", 0); // case 3
	}
	else
	{
		menu_additem(menu, "\dOluler Ile Canlilar Arasi Yazili Iletisim\d |\r KAPALI", "", 0); // case 3
	}

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
	menu_setprop(menu, MPROP_BACKNAME, "Geri");
	menu_setprop(menu, MPROP_NEXTNAME, "Ileri");
	menu_setprop(menu, MPROP_EXITNAME, "Cikis");

	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public ayarlar_handled(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_cancel(id);
		return PLUGIN_HANDLED;
	}

	new command[6], name[64], access, callback;

	menu_item_getinfo(menu, item, access, command, sizeof command - 1, name, sizeof name - 1, callback);

	switch(item)
	{
		case 0:
		{
			if(get_pcvar_num(g_listen) == 1)
				server_cmd("amx_cvar ap_listen 0")
				
			if(get_pcvar_num(g_listen) == 0)
				server_cmd("amx_cvar ap_listen 1")
				
			set_task(1.5,"Ayarlar",id)
		}
		case 1:
		{
			if(get_pcvar_num(g_say_characters) == 1)
				server_cmd("amx_cvar ap_say_characters 0")
			
			if(get_pcvar_num(g_say_characters) == 0)
				server_cmd("amx_cvar ap_say_characters 1")
				
			set_task(1.5,"Ayarlar",id)
		}		
		case 2:
		{
			if(get_pcvar_num(g_prefix_characters) == 1)
				server_cmd("amx_cvar ap_prefix_characters 0")
			
			if(get_pcvar_num(g_prefix_characters) == 0)
				server_cmd("amx_cvar ap_prefix_characters 1")
				
			set_task(1.5,"Ayarlar",id)
		}
		case 3:
		{
			if(get_pcvar_num(displaymode_cvar) == 1)
				server_cmd("amx_cvar ap_displaymode 0")
			
			if(get_pcvar_num(displaymode_cvar) == 0)
				server_cmd("amx_cvar ap_displaymode 1")
				
			set_task(1.5,"Ayarlar",id)
		}
		
	}
	return PLUGIN_HANDLED
}
	
	
new yazmaturu[64] = 0	
public TagturuMenu(id)
{
	new menu = menu_create("\yTag Ekleme Turu Seciniz", "tagturu_handled");

	menu_additem(menu, "\wSteam ID Tag\d | Secilen Steam Kisisine Ozel Tag", "", 0); // case 0
	menu_additem(menu, "\wIP Adresine Ozel Tag\d | Ip adresi eslesen oyuncuda tag olacak.", "", 0); // case 1
	menu_additem(menu, "\wNicke Ozel Tag \d| Belirtilen Nickle Girene Ozel Tag", "", 0); // case 2
	menu_additem(menu, "\wYetkiye Ozel Tag\d | belirtilen yetkide olan kisilere tag verilecek.", "", 0); // case 3
	menu_additem(menu, "\wYetkili Listesinden Al\d | Users.ini'deki secilen yetkiliye tag verilecek.", "", 0); // case 4

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
	menu_setprop(menu, MPROP_BACKNAME, "Geri");
	menu_setprop(menu, MPROP_NEXTNAME, "Ileri");
	menu_setprop(menu, MPROP_EXITNAME, "Cikis");

	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}



public tagturu_handled(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_cancel(id);
		return PLUGIN_HANDLED;
	}

	new command[6], name[64], access, callback;

	menu_item_getinfo(menu, item, access, command, sizeof command - 1, name, sizeof name - 1, callback);

	switch(item)
	{
		case 0:
		{
			yazmaturu[id] = 1
			SteamIDMenu(id)
			
		
		
		}
		case 1:
		{
			
			yazmaturu[id] = 2
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 IP Adresini Yazarken Dikkat Ediniz.!",in_prefix)
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 IP Adresi yazarken^3 xxx.xxx.xxx.xxx^4 Olarak Girmelisiniz.",in_prefix)
			client_cmd(id,"messagemode IP_ADRES")		
			
		}
		case 2:
		{
		
			yazmaturu[id] = 3
			
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Nicki Yazarken Dikkat Ediniz.!",in_prefix)
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Nicki yazarken^3 Eksiksiz^4 Olarak Girmelisiniz.",in_prefix)
			client_cmd(id,"messagemode OyuncuNicki")
		
		}
		case 3:
		{
			
			yazmaturu[id] = 4
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Tag Yazarken^3 [,],{,}^4 Gibi Isaretler Kullanmayiniz.",in_prefix)
			ColorChat(id,"^4[%s]^3 Yazacaginiz Tag Ichat uygulamasi gibi Say'in Sol Tarafinda Gosterilecek.",in_prefix)
			ColorChat(id,"^4[%s]^3 Ornek :^4 Kurucu^3 s harfi iken^4 Slot^3 j Harfi^4 Olacak..",in_prefix)
			client_cmd(id,"messagemode YeniTag")
			
		}
		case 4:
		{
			
			yazmaturu[id] = 3
			ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Tag Yazarken^3 [,],{,}^4 Gibi Isaretler Kullanmayiniz.",in_prefix)
			ColorChat(id,"^4[%s]^3 Yazacaginiz Tag Ichat uygulamasi gibi Say'in Sol Tarafinda Gosterilecek.",in_prefix)
			ColorChat(id,"^4[%s]^3 Ornek :^4 Kurucu^3 s harfi iken^4 Slot^3 j Harfi^4 Olacak..",in_prefix)
			Yetkililistesi(id)
			
		}
	}

	menu_destroy(menu);

	return PLUGIN_HANDLED;
}
new oyuncunick[32]
public Yetkililistesi(id) {
	new menu = menu_create("\rYetkili Listesi\d | CSD ADMIN PREFIX 2018","Yetlis_handler")
	
	new szLine[248];
	new LineName[32]
	new maxlines,txtlen,linee[6];
	maxlines = file_size(usersfile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		
		read_file(usersfile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31)
			if(!equali(LineName,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineName,"1")
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
}	

public Yetlis_handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
		
		ColorChat(id,"^4[%s] ^1%s^4 Adli Yetkili Icin Tag Giriniz.!",in_prefix,name)
		copy(oyuncunick,charsmax(oyuncunick),name)
		client_cmd(id,"messagemode YeniTag")
		
	}
	return PLUGIN_HANDLED
}




public client_authorized(id){
	
		
	set_task(5.0,"reklam",id)
	return PLUGIN_HANDLED
	
}

public reklam(id){
	
	
	ColorChat(id,"^4[%s]^3 Bu Serverde Csduragi Admin Prefix %s Kullanilmaktadir. ",in_prefix,MODVERSION)
	return PLUGIN_HANDLED
}
	
new ip[32]
public ipadresi(id){
		
	
	read_args(ip,31)
	remove_quotes(ip)
	client_cmd(id,"messagemode YeniTag")
	
	
	
	
	
	
		
}


public oyuncuismi(id){
	
	read_args(oyuncunick,31)
	remove_quotes(oyuncunick)
	client_cmd(id,"messagemode YeniTag")
	
	
	
}
	
new authid[64]
public SteamIDMenu( id )
	{	
		new iPlayers[ 32 ], iNum;
		get_players( iPlayers, iNum );
		
		new szInfo[ 6 ], hMenu;
		hMenu = menu_create( "Steam ID Almak icin Adam Sec..:", "InviteMenu_Handler" );
		new szName[ 32 ];
		
		for( new i = 0, iPlayer; i < iNum; i++ )
		{
			iPlayer = iPlayers[ i ];
			
			
			
				
			get_user_name( iPlayer, szName, charsmax( szName ) );
			
			num_to_str( iPlayer, szInfo, charsmax( szInfo ) );
			
			menu_additem( hMenu, szName, szInfo );
		}
			
		menu_display( id, hMenu, 0 );
	}	
	
	
	
public InviteMenu_Handler( id, hMenu, iItem)
	{
		if( iItem == MENU_EXIT )
		{
			return PLUGIN_HANDLED;
		}
		
		new szData[ 6 ], iAccess, hCallback, szName[ 32 ];
		menu_item_getinfo( hMenu, iItem, iAccess, szData, 5, szName, 31, hCallback );
		
		iPlayer = str_to_num( szData );

		if( !is_user_connected( iPlayer ) )
			return PLUGIN_HANDLED;
			
			
		get_user_authid(iPlayer,authid,63)
		new tagname[32]
		get_user_name(iPlayer,tagname,31)
			
		ColorChat(id,"^4[%s]^4 %s^3 Steam Id Adresli^4 %s^3 Oyuncusuna Verilecek Tagi Yazin..",in_prefix,authid,tagname)
		client_cmd(id,"messagemode YeniTag")	
		

		return PLUGIN_HANDLED;
	}
	

	
	
	
public Taglistesi(id) {
	new menu = menu_create("\rTag Listesi\d | CSD ADMIN PREFIX ","TagSil")
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(prefixfile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(prefixfile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(!equali(LineName,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineAccess)
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
}	

new tag[32];
new tagyetki[32];

public TagSil(id,menu,item) {
	
	
	return PLUGIN_HANDLED
	
}
public tagekle(id){
	
	
	read_args(tag,31)
	remove_quotes(tag)
	
	if(yazmaturu[id] == 5){
		
		if(Tag_kontrol(tag)) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Tagi Daha Onceden Kullanmissiniz.",in_prefix)
			client_cmd(id,"messagemode YeniTag")
			return PLUGIN_HANDLED
		}
		
		tagyetkiekleveyaz(id)	
	}
	if(yazmaturu[id] == 1){
		
		if(Tag_kontrol(tag)) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Tagi Daha Onceden Kullanmissiniz.",in_prefix)
			client_cmd(id,"messagemode YeniTag")
			return PLUGIN_HANDLED
		}
		
		tagyetkiekleveyaz(id)	
	}
	if(yazmaturu[id] == 2){
		
		
		if(Tag_kontrol(ip[iPlayer])) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Ip Adresini Daha Onceden Kullanmissiniz.",in_prefix)
			client_cmd(id,"messagemode IP_ADRES")
			return PLUGIN_HANDLED
		}
	
		tagyetkiekleveyaz(id)
	}
	if(yazmaturu[id] == 3){
		
		
		if(Tag_kontrol(oyuncunick[iPlayer])) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Nicki Daha Onceden Kullanmissiniz.",in_prefix)
			client_cmd(id,"messagemode OyuncuNicki")
			return PLUGIN_HANDLED
		}
	
		tagyetkiekleveyaz(id)
	}
	
	
	if(yazmaturu[id] == 4){
		
		if(Tag_kontrol(tag)) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Tagi Daha Onceden Kullanmissiniz.",in_prefix)
			client_cmd(id,"messagemode YeniTag")
			return PLUGIN_HANDLED
		}
		
		ColorChat(id,"^4[%s]^3 Tag Goruntulemek Icin Yetki Harfi Girin (^4 b,c,d,e gibi^3) ",in_prefix)
		ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Yetki Harfleri Girilirken Alfabetik Sirayi Goz onune Alin. Buyuk Yetkiler Alfabetik Siralanmali.",in_prefix)
		ColorChat(id,"^4[%s]^3 DÝKKAT:^4 Tag Yazarken^3 [,],{,}^4 Gibi Isaretler Kullanmayiniz.",in_prefix)

		client_cmd(id,"messagemode Tag_Goruntuleme_Yetkisi")
	}
	
	return PLUGIN_HANDLED
}
public tagyetkiekleveyaz(id){	
	read_args(tagyetki,31)
	remove_quotes(tagyetki)
	
	if(yazmaturu[id] == 1){
		if(Tag_kontrol(authid[iPlayer])) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu authid'yi Baska Bir Tagta kullandiniz.!",in_prefix)
			TagturuMenu(id)
			return PLUGIN_HANDLED
		}	
	}
	if(yazmaturu[id] == 4){
		if(Tag_kontrol(tagyetki)) {
			ColorChat(id,"^4[%s] ^3HATA:^4 Bu Yetkiyi Baska Bir Tagta kullandiniz.!",in_prefix)
			client_cmd(id,"messagemode YeniTag")
			return PLUGIN_HANDLED
		}
	}
	
	new szLine[248]
	
	if(yazmaturu[id] == 1){
		formatex(szLine,247,"^"s^" ^"%s^" ^"[%s]^" ^n",authid,tag)
		write_file(prefixfile,szLine)
		server_cmd("ap_reload_prefixes")
	}
	if(yazmaturu[id] == 2){
		formatex(szLine,247,"^"i^" ^"%s^" ^"[%s]^" ^n",ip,tag)
		write_file(prefixfile,szLine)
		server_cmd("ap_reload_prefixes")
	}
	
	if(yazmaturu[id] == 3){
		formatex(szLine,247,"^"n^" ^"%s^" ^"[%s]^" ^n",oyuncunick,tag)
		write_file(prefixfile,szLine)
		server_cmd("ap_reload_prefixes")
	}
	
	
	if(yazmaturu[id] == 4){
		formatex(szLine,247,"^"f^" ^"%s^" ^"[%s]^" ^n",tagyetki,tag)
		write_file(prefixfile,szLine)
		server_cmd("ap_reload_prefixes")
	}

	ColorChat(id,"^4[%s]^3 Tag Basariyla Aktiflestirildi.!",in_prefix)
	ColorChat(id,"^4[%s]^3 Yazmis Oldugunuz Tag :^4 [%s]^3 Playerismi",in_prefix,tag)
	
	client_cmd(id,"say /prefixmenu")
	
	return PLUGIN_HANDLED
	
}
	
	
stock Tag_kontrol(const Name[]) {
	new szLine[248];
	new LineName[32],blabla[32];
	new maxlines,txtlen;
	maxlines = file_size(prefixfile,1);
	for(new line;line<maxlines;line++) {
		read_file(prefixfile,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			return 1;
		}
	}
	return 0;
} 	
	
public LoadPrefixes(id)
{
	if(!(get_user_flags(id) & FLAG_LOAD))
	{
		console_print(id, "%L", LANG_SERVER, "PREFIX_PERMISSION", in_prefix)
		return PLUGIN_HANDLED
	}

	TrieClear(pre_ips_collect)
	TrieClear(pre_names_collect)
	TrieClear(pre_steamids_collect)
	TrieClear(pre_flags_collect)

	line = 0, length = 0, pre_flags_count = 0, pre_ips_count = 0, pre_names_count = 0;

	if(!file_exists(file_prefixes)) 
	{
		formatex(error, charsmax(error), "%L", LANG_SERVER, "PREFIX_NOT_FOUND", in_prefix, file_prefixes)
		set_fail_state(error)
	}

	server_print(separator)

	while(read_file(file_prefixes, line++ , text, charsmax(text), length) && (pre_ips_count + pre_names_count + pre_steamids_count + pre_flags_count) <= MAX_PREFIXES)
	{
		if(!text[0] || text[0] == '^n' || text[0] == ';' || (text[0] == '/' && text[1] == '/'))
			continue

		parse(text, type, charsmax(type), key, charsmax(key), prefix, charsmax(prefix))
		trim(prefix)

		if(!type[0] || !prefix[0] || !key[0])
			continue

		replace_all(prefix, charsmax(prefix), "!g", "^x04")
		replace_all(prefix, charsmax(prefix), "!t", "^x03")
		replace_all(prefix, charsmax(prefix), "!n", "^x01")

		switch(type[0])
		{
			case 'f':
			{
				pre_flags_count++
				TrieSetString(pre_flags_collect, key, prefix)
				server_print("%L", LANG_SERVER, "PREFIX_LOAD_FLAG", in_prefix, prefix, key[0])
			}
			case 'i':
			{
				pre_ips_count++
				TrieSetString(pre_ips_collect, key, prefix)
				server_print("%L", LANG_SERVER, "PREFIX_LOAD_IP", in_prefix, prefix, key)
			}
			case 's':
			{
				pre_steamids_count++
				TrieSetString(pre_steamids_collect, key, prefix)
				server_print("%L", LANG_SERVER, "PREFIX_LOAD_STEAMID", in_prefix, prefix, key)
			}
			case 'n':
			{
				pre_names_count++
				TrieSetString(pre_names_collect, key, prefix)
				server_print("%L", LANG_SERVER, "PREFIX_LOAD_NAME", in_prefix, prefix, key)
			}
			default:
			{
				continue
			}
		}
	}

	if(pre_flags_count <= 0 && pre_ips_count <= 0 && pre_steamids_count <= 0 && pre_names_count <= 0)
	{
		server_print("%L", LANG_SERVER, "PREFIX_NO", in_prefix)
	}

	get_user_name(id, g_name, charsmax(g_name))
	server_print("%L", LANG_SERVER, "PREFIX_LOADED_BY", in_prefix, g_name)
	console_print(id, "%L", LANG_SERVER, "PREFIX_LOADED", in_prefix)

	server_print(separator)

	for(new i = 1; i <= g_maxplayers; i++)
	{
		num_to_str(i, str_id, charsmax(str_id))
		TrieDeleteKey(client_prefix, str_id)
		PutPrefix(i)
	}

	return PLUGIN_HANDLED
}

public LoadBadPrefixes(id)
{
	if(!get_pcvar_num(g_bad_prefix))
	{
		console_print(id, "%L", LANG_SERVER, "BADP_OFF", in_prefix)
		return PLUGIN_HANDLED
	}

	if(!(get_user_flags(id) & FLAG_LOAD))
	{
		console_print(id, "%L", LANG_SERVER, "BADP_PERMISSION", in_prefix)
		return PLUGIN_HANDLED
	}

	TrieClear(bad_prefixes_collect)

	line = 0, length = 0, bad_prefix_count = 0;

	if(!file_exists(file_bad_prefixes)) 
	{
		console_print(id, "%L", LANG_SERVER, "BADP_NOT_FOUND", in_prefix, file_bad_prefixes)
		return PLUGIN_HANDLED		
	}

	server_print(separator)

	while(read_file(file_bad_prefixes, line++ , text, charsmax(text), length) && bad_prefix_count <= MAX_BAD_PREFIXES)
	{
		if(!text[0] || text[0] == '^n' || text[0] == ';' || (text[0] == '/' && text[1] == '/'))
			continue

		parse(text, prefix, charsmax(prefix))

		if(!prefix[0])
			continue

		bad_prefix_count++
		TrieSetCell(bad_prefixes_collect, prefix, 1)
		server_print("%L", LANG_SERVER, "BADP_LOAD", in_prefix, prefix)
	}

	if(bad_prefix_count <= 0)
	{
		server_print("%L", LANG_SERVER, "BADP_NO", in_prefix)
	}

	get_user_name(id, g_name, charsmax(g_name))
	server_print("%L", LANG_SERVER, "BADP_LOADED_BY", in_prefix, g_name)
	console_print(id, "%L", LANG_SERVER, "BADP_LOADED", in_prefix)

	server_print(separator)

	return PLUGIN_HANDLED
}

public client_putinserver(id)
{
	g_toggle[id] = true
	num_to_str(id, str_id, charsmax(str_id))
	TrieSetString(client_prefix, str_id, "")
	PutPrefix(id)
}

public HookSay(id)
{
	read_args(g_typed, charsmax(g_typed))
	remove_quotes(g_typed)

	trim(g_typed)

	if(equal(g_typed, "") || !is_user_connected(id))
		return PLUGIN_HANDLED_MAIN

	if(equal(g_typed, "/prefix"))
	{
		if(g_toggle[id])
		{
			g_toggle[id] = false
			client_print(id, print_chat, "%L", LANG_SERVER, "PREFIX_OFF", in_prefix)
		}
		else
		{
			g_toggle[id] = true
			client_print(id, print_chat, "%L", LANG_SERVER, "PREFIX_ON", in_prefix)
		}

		return PLUGIN_HANDLED_MAIN
	}

	if(!g_toggle[id])
		return PLUGIN_CONTINUE

	num_to_str(id, str_id, charsmax(str_id))

	if((TrieGetString(client_prefix, str_id, temp_prefix, charsmax(temp_prefix)) && get_pcvar_num(g_say_characters) == 1) || (!TrieGetString(client_prefix, str_id, temp_prefix, charsmax(temp_prefix)) && get_pcvar_num(g_say_characters) == 2) || get_pcvar_num(g_say_characters) == 3)
	{
		if(check_say_characters(g_typed))
			return PLUGIN_HANDLED_MAIN
	}

	get_user_name(id, g_name, charsmax(g_name))

	g_team = cs_get_user_team(id)

	if(temp_prefix[0])
	{
		formatex(g_message, charsmax(g_message), "^1%s^4%s^3 %s :^4 %s", say_team_info[is_user_alive(id)][g_team], temp_prefix, g_name, g_typed)
	}
	else
	{
		formatex(g_message, charsmax(g_message), "^1%s^3%s :^1 %s", say_team_info[is_user_alive(id)][g_team], g_name, g_typed)
	}

	get_pcvar_string(g_listen_flag, temp_cvar, charsmax(temp_cvar))

	for(new i = 1; i <= g_maxplayers; i++)
	{
		if(!is_user_connected(i))
			continue
			
		// 1 - HERKEZE GOSTER | 2- OLULER VE YASAYANLAR AYRI	
		if(get_pcvar_num(displaymode_cvar) == 0 ){
			if(is_user_alive(id) && is_user_alive(i) || !is_user_alive(id) && !is_user_alive(i) || get_pcvar_num(g_listen) && get_user_flags(i) & read_flags(temp_cvar))
			{
				send_message(g_message, id, i)
			}
		
		}
		if(get_pcvar_num(displaymode_cvar) == 1){
			if(is_user_alive(id) && is_user_alive(i) || !is_user_alive(id) && !is_user_alive(i))
			{
				send_message(g_message, id, i)
			}
		
		}
	}

	return PLUGIN_HANDLED_MAIN
}

public HookSayTeam(id)
{
	read_args(g_typed, charsmax(g_typed))
	remove_quotes(g_typed)

	trim(g_typed)

	if(equal(g_typed, "") || !is_user_connected(id))
		return PLUGIN_HANDLED_MAIN

	if(equal(g_typed, "/prefix"))
	{
		if(g_toggle[id])
		{
			g_toggle[id] = false
			client_print(id, print_chat, "%L", LANG_SERVER, "PREFIX_OFF", in_prefix)
		}
		else
		{
			g_toggle[id] = true
			client_print(id, print_chat, "%L", LANG_SERVER, "PREFIX_ON", in_prefix)
		}

		return PLUGIN_HANDLED_MAIN
	}

	if(!g_toggle[id])
		return PLUGIN_CONTINUE

	num_to_str(id, str_id, charsmax(str_id))

	if((TrieGetString(client_prefix, str_id, temp_prefix, charsmax(temp_prefix)) && get_pcvar_num(g_say_characters) == 1) || (!TrieGetString(client_prefix, str_id, temp_prefix, charsmax(temp_prefix)) && get_pcvar_num(g_say_characters) == 2) || get_pcvar_num(g_say_characters) == 3)
	{
		if(check_say_characters(g_typed))
			return PLUGIN_HANDLED_MAIN
	}

	get_user_name(id, g_name, charsmax(g_name))

	g_team = cs_get_user_team(id)

	if(temp_prefix[0])
	{
		formatex(g_message, charsmax(g_message), "^1%s^4%s^3 %s :^4 %s", sayteam_team_info[is_user_alive(id)][g_team], temp_prefix, g_name, g_typed)
	}
	else
	{
		formatex(g_message, charsmax(g_message), "^1%s^3%s :^1 %s", sayteam_team_info[is_user_alive(id)][g_team], g_name, g_typed)
	}

	get_pcvar_string(g_listen_flag, temp_cvar, charsmax(temp_cvar))

	for(new i = 1; i <= g_maxplayers; i++)
	{
		if(!is_user_connected(i))
			continue

		if(get_user_team(id) == get_user_team(i) || get_pcvar_num(g_listen) && get_user_flags(i) & read_flags(temp_cvar))
		{
			
			// 1 - HERKEZE GOSTER | 2- OLULER VE YASAYANLAR AYRI	
			if(get_pcvar_num(displaymode_cvar) == 1 ){
				if(is_user_alive(id) && is_user_alive(i) || !is_user_alive(id) && !is_user_alive(i))
				{
					send_message(g_message, id, i)
				}
					
			}
			if(get_pcvar_num(displaymode_cvar) == 0 ){
				if(is_user_alive(id) && is_user_alive(i) || !is_user_alive(id) && !is_user_alive(i) || get_pcvar_num(g_listen) && get_user_flags(i) & read_flags(temp_cvar))
				{
					send_message(g_message, id, i)
				}
					
			}
		}
	}

	return PLUGIN_HANDLED_MAIN
}

public SetPlayerPrefix(id)
{
	if(!get_pcvar_num(g_custom) || !get_pcvar_string(g_custom_flag, temp_cvar, charsmax(temp_cvar)))
	{
		console_print(id, "%L", LANG_SERVER, "CUSTOM_OFF", in_prefix)
		return PLUGIN_HANDLED
	}

	if(!(get_user_flags(id) & read_flags(temp_cvar)))
	{
		console_print(id, "%L", LANG_SERVER, "CUSTOM_PERMISSION", in_prefix)
		return PLUGIN_HANDLED
	}

	new input[128], target;
	new arg_type[2], arg_prefix[32], arg_key[35];
	new temp_str[16];

	read_args(input, charsmax(input))
	remove_quotes(input)
	parse(input, arg_type, charsmax(arg_type), arg_key, charsmax(arg_key), arg_prefix, charsmax(arg_prefix))
	trim(arg_prefix)

	if(get_pcvar_num(g_bad_prefix) && is_bad_prefix(arg_prefix) && !equali(arg_prefix, ""))
	{
		console_print(id, "%L", LANG_SERVER, "CUSTOM_FORBIDDEN", in_prefix, arg_prefix)
		return PLUGIN_HANDLED
	}

	if(get_pcvar_num(g_prefix_characters) && check_prefix_characters(arg_prefix))
	{
		console_print(id, "%L", LANG_SERVER, "CUSTOM_SYMBOL", in_prefix, arg_prefix, forbidden_prefixes_symbols[i])
		return PLUGIN_HANDLED
	}

	switch(arg_type[0])
	{
		case 'f':
		{
			target = 0
			temp_str = "Flag"
		}
		case 'i':
		{
			target = find_player("d", arg_key)
			temp_str = "IP"
		}
		case 's':
		{
			target = find_player("c", arg_key)
			temp_str = "SteamID"
		}
		case 'n':
		{
			target = find_player("a", arg_key)
			temp_str = "Name"
		}
		default:
		{
			console_print(id, "%L", LANG_SERVER, "CUSTOM_INVALID", in_prefix, arg_type)
			return PLUGIN_HANDLED
		}
	}

	get_user_name(id, g_name, charsmax(g_name))

	if(equali(arg_prefix, ""))
	{
		find_and_delete(arg_type, arg_key)

		if(target)
		{
			PutPrefix(target)
		}
		
		console_print(id, "%L", LANG_SERVER, "CUSTOM_REMOVE", in_prefix, temp_str, arg_key)
		server_print("%L", LANG_SERVER, "CUSTOM_REMOVE_INFO", in_prefix, g_name, temp_str, arg_key)
		return PLUGIN_HANDLED
	}

	find_and_delete(arg_type, arg_key)

	formatex(text, charsmax(text), "^"%s^" ^"%s^" ^"%s^"", arg_type, arg_key, arg_prefix)
	write_file(file_prefixes, text, -1)

	switch(arg_type[0])
	{
		case 'f':
		{
			TrieSetString(pre_flags_collect, arg_key, arg_prefix)
		}
		case 'i':
		{
			TrieSetString(pre_ips_collect, arg_key, arg_prefix)
		}
		case 's':
		{
			TrieSetString(pre_steamids_collect, arg_key, arg_prefix)
		}
		case 'n':
		{
			TrieSetString(pre_names_collect, arg_key, arg_prefix)
		}
	}

	if(target)
	{
		num_to_str(target, str_id, charsmax(str_id))
		TrieSetString(client_prefix, str_id, arg_prefix)
	}

	console_print(id, "%L", LANG_SERVER, "CUSTOM_CHANGE", in_prefix, temp_str, arg_key, arg_prefix)
	server_print("%L", LANG_SERVER, "CUSTOM_CHANGE_INFO", in_prefix, g_name, temp_str, arg_key, arg_prefix) 

	return PLUGIN_HANDLED
}

public client_infochanged(id)
{
	if(!is_user_connected(id))
		return PLUGIN_CONTINUE

	new g_old_name[32];

	get_user_info(id, "name", g_name, charsmax(g_name))
	get_user_name(id, g_old_name, charsmax(g_old_name))

	if(!equal(g_name, g_old_name))
	{
		num_to_str(id, str_id, charsmax(str_id))
		TrieSetString(client_prefix, str_id, "")
		set_task(0.5, "PutPrefix", id)
		return PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE
}

public PutPrefix(id)
{
	num_to_str(id, str_id, charsmax(str_id))
	TrieSetString(client_prefix, str_id, "")

	new sflags[32], temp_flag[2];
	get_flags(get_user_flags(id), sflags, charsmax(sflags))

	for(new i = 0; i <= charsmax(sflags); i++)
	{
		formatex(temp_flag, charsmax(temp_flag), "%c", sflags[i])

		if(TrieGetString(pre_flags_collect, temp_flag, temp_prefix, charsmax(temp_prefix)))
		{
			TrieSetString(client_prefix, str_id, temp_prefix)
		}
	}

	get_user_ip(id, temp_key, charsmax(temp_key), 1)

	if(TrieGetString(pre_ips_collect, temp_key, temp_prefix, charsmax(temp_prefix)))
	{
		TrieSetString(client_prefix, str_id, temp_prefix)
	}

	get_user_authid(id, temp_key, charsmax(temp_key))

	if(TrieGetString(pre_steamids_collect, temp_key, temp_prefix, charsmax(temp_prefix)))
	{
		TrieSetString(client_prefix, str_id, temp_prefix)
	}

	get_user_name(id, temp_key, charsmax(temp_key))

	if(TrieGetString(pre_names_collect, temp_key, temp_prefix, charsmax(temp_prefix)))
	{
		TrieSetString(client_prefix, str_id, temp_prefix)
	}

	return PLUGIN_HANDLED
}

send_message(const message[], const id, const i)
{
	message_begin(MSG_ONE, g_saytxt, {0, 0, 0}, i)
	write_byte(id)
	write_string(message)
	message_end()
}

bool:check_say_characters(const check_message[])
{
	for(new i = 0; i < charsmax(forbidden_say_symbols); i++)
	{
		if(check_message[0] == forbidden_say_symbols[i])
		{
			return true
		}
	}
	return false
}

bool:check_prefix_characters(const check_prefix[])
{
	for(i = 0; i < charsmax(forbidden_prefixes_symbols); i++)
	{
		if(containi(check_prefix, forbidden_prefixes_symbols[i]) != -1)
		{
			return true
		}
	}
	return false
}

bool:is_bad_prefix(const check_prefix[])
{
	if(TrieGetCell(bad_prefixes_collect, check_prefix, temp_value))
	{
		return true
	}
	return false
}

find_and_delete(const arg_type[], const arg_key[])
{
	line = 0, length = 0;

	while(read_file(file_prefixes, line++ , text, charsmax(text), length))
	{
		if(!text[0] || text[0] == '^n' || text[0] == ';' || (text[0] == '/' && text[1] == '/'))
			continue

		parse(text, type, charsmax(type), key, charsmax(key), prefix, charsmax(prefix))
		trim(prefix)

		if(!type[0] || !prefix[0] || !key[0])
			continue
			
		if(!equal(arg_type, type) || !equal(arg_key, key))
			continue
			
		write_file(file_prefixes, "", line - 1)
	}
	
	switch(arg_type[0])
	{
		case 'f':
		{
			TrieDeleteKey(pre_flags_collect, arg_key)
		}
		case 'i':
		{
			TrieDeleteKey(pre_ips_collect, arg_key)
		}
		case 's':
		{
			TrieDeleteKey(pre_steamids_collect, arg_key)
		}
		case 'n':
		{
			TrieDeleteKey(pre_names_collect, arg_key)
		}
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
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1055\\ f0\\ fs16 \n\\ par }
*/
