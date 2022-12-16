/* Plugin generated by AMXX-Studio */

#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <cstrike>

#define PLUGIN "Csduragi Oto Spec Bot[INI]"
#define VERSION "2.5"
#define AUTHOR "TahaDemirbas" // ForumCSD 
#define MAX_BOT_NUM 3
//#define ISLEM 3
new  ISLEM
new cvar_sistem,cvar_dokunulmazlik,cvar_delay,cvar_atmod,cvar_defatoyuncu
new g_botKimligi = -0,g_bellekisimleri[MAX_BOT_NUM]
new g_Bot[MAX_BOT_NUM+2]=-0
new const datafile[] = "addons/amxmodx/configs/botnames.txt" // CSduragi Panel Uyumla FakeFullSpecBot bot �ni den gelen yol
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)

	register_clcmd("say /specbotmenu","eklentimenusu",ADMIN_RCON)
	register_clcmd("SpecBotAdi","botekle")
	cvar_sistem = register_cvar("csd_sbot","1")
	cvar_atmod = register_cvar("csd_sbot_atmod","1") // 1-Dinamik- Sunucu de�i�kenlerinden otomatik sunucu max slot say�s� ile i�lem yap�l�r. -    / 2 - Direkt belirli say�n�n alt�ndaysa i�lem yap�l�r. Sunucu max slotuna bak�lmaz.
	cvar_defatoyuncu = register_cvar("csd_sbot_defatoyuncusayisi","27") // csd_sbot_atmod cvar ayar� "2" De�erinde iken Cvar ayar� ayarlanan ki�i say�s�ndan sonra botlar� atar. 
	cvar_dokunulmazlik = register_cvar("csd_sbotdoku","1") // bota dokunulmazlik
	cvar_delay = register_cvar("csd_sbot_gecikme","10.0") // Server Kontrolu Arasindaki Sure (Saniye)
	if(get_pcvar_num(cvar_atmod)== 1){
		ISLEM=(get_maxplayers()- 3)
	}else if(get_pcvar_num(cvar_atmod)== 2)
	{
		ISLEM=get_pcvar_num(cvar_defatoyuncu)
	}
	else
	{
		ISLEM=(get_maxplayers()- 3)
	}
	set_task(get_pcvar_float(cvar_delay),"ServeriIncele",777,_,_,"b")
	
	dosyalaridogrula()
	
}
public dosyalaridogrula(){
	
	server_print("[CSDSPECBOT] #########################################")
	server_print("[CSDSPECBOT] Sistem Dosyalari Dogrulamasi basladi..")
	if(!file_exists(datafile)){
		server_print("[CSDSPECBOT] Sistem Konfigrasyon dosyasi bulunamadi..")
		server_print("[CSDSPECBOT] Sistem Konfigrasyon dosyasi olusturuluyor..")
		new satir[1028]
		formatex(satir,1027,"^"CSduragi.Com^"^n^"forum.Csduragi.Com^"^n^"CSduragi Sunucu kiralama^"^n")
		write_file(datafile,satir)
		server_print("[CSDSPECBOT] Sistem Konfigrasyon dosyasi olusturuldu..")
		
	}
	else
	{
		server_print("[CSDSPECBOT] Sistem Konfigrasyon dosyasi dogrulandi.")
	}
	server_print("[CSDSPECBOT] #########################################")
	return PLUGIN_HANDLED
}

public eklentimenusu(id){
	if(!(get_user_flags(id) & ADMIN_RCON)){
		client_print_color(id,id,"Bu Menuyu Kullanma Hakkin Yok.")
		return PLUGIN_HANDLED
	}
	
	new menu = menu_create("\yCSDURAGI\w Specbot Eklentisi","MainMenu_Handler")

	menu_additem(menu,"\ySpec Botu\w Ekle","1")
	menu_additem(menu,"\ySpec Botlarini\r Sil^n","2")
	menu_additem(menu,"\dSpec Botlarini Tekrar Getir","3")
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public MainMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
	client_print_color(id,id,"^3[CSDSPEC] ^4 Spec bot Adi Girin..")	
	client_cmd(id,"messagemode SpecBotAdi")
	    
	}
	if(equali(data,"2")) {
	 botsil(id)
	    	
	}
	if(equali(data,"3")) {
	 botlaritekrargetir(id)
	    	
	}

	return PLUGIN_HANDLED
}
public botlaritekrargetir(id){
	for(new i=0;i<=g_botKimligi+1;i++){
		server_cmd("kick #%d", get_user_userid(g_Bot[i]))
		g_bellekisimleri[i] = 0
		g_Bot[i] = 0
		g_botKimligi--
	}
	
	server_print("[csdSPECBOT] Spec Botlari Tekrardan Yuklendi.")
	return PLUGIN_HANDLED
}


public botekle(id){
	new text[33]
	read_args(text,32)
	remove_quotes(text)
	new satir[1018]
	formatex(satir,1017,"^"%s^"",text)
	write_file(datafile,satir)
	client_print_color(id,id,"^4[CSDSPEC] ^1%s^4 Adli Bot Olusturulmustur.",text)
	eklentimenusu(id)
	return PLUGIN_HANDLED
}

public botsil(id){
	
		
	new menu = menu_create("\yCSD SPEC BOT \d| \rYONETICI:\d BOT SIL","BsilMainMenu_Handler")
	
	
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(datafile,1);
	
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		menutanit[0] = 0;
		
		read_file(datafile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(!equali(menutanit,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,menutanit,linee)
			}
		}
	}
	
	
	
	
	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public BsilMainMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	
		
	write_file(datafile,"",str_to_num(data))
	client_print_color(id,id,"^4[CSDSPEC] ^1%s^4 Adli Bot Silinmistir.",name)
	eklentimenusu(id)
	
	return PLUGIN_HANDLED
}







public botlarigetir(){
	
	
	
	
	
	
	
	if(get_playersnum(1)>= ISLEM){
		//server_print("[csdSPECBOT] Sunucu Oyuncu sayisi yuksek oldugundan dolayi spec botlari atilmiyor.")
		return PLUGIN_HANDLED
	}
	
	new BotAdi[64]
	new szLine[248];
	
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line=0;line<maxlines;line++) {
		szLine[0] = 0;
		BotAdi[0] = 0; 
		 
		if(g_botKimligi >= MAX_BOT_NUM)
			return PLUGIN_HANDLED
		
		read_file(datafile,g_botKimligi,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,BotAdi,32)
			if(!equali(BotAdi,";" )) {
				
				if(!is_user_connected(g_Bot[line])){
					
				g_Bot[line] = engfunc(EngFunc_CreateFakeClient, BotAdi)

				if (g_Bot[line] > 0) 
				{
					dllfunc(MetaFunc_CallGameEntity, "player", g_Bot[line])
					set_pev(g_Bot[line], pev_flags, FL_FAKECLIENT)
	
					set_pev(g_Bot[line], pev_model, "")
					set_pev(g_Bot[line], pev_viewmodel2, "")
					set_pev(g_Bot[line], pev_modelindex, 0)

					set_pev(g_Bot[line], pev_renderfx, kRenderFxNone)
					set_pev(g_Bot[line], pev_rendermode, kRenderTransAlpha)
					set_pev(g_Bot[line], pev_renderamt, 0.0)
					
					TakimiAyarla(g_Bot[line])
					if (get_pcvar_num(cvar_dokunulmazlik))
						set_user_flags(g_Bot[line], ADMIN_IMMUNITY)
					g_botKimligi++
					server_print("[csdSPECBOT] %d Numarali Spec Botu %s Ismi Ile Olusturuldu..",g_botKimligi,BotAdi)
				}
				}

			}	
		}
	}
	
	return PLUGIN_HANDLED	
}
public TakimiAyarla(Bot)
{
	if (cstrike_running()) {
		cs_set_user_team(Bot, CS_TEAM_UNASSIGNED)
	}
}

public ServeriIncele(){
	
	if (get_pcvar_num(cvar_sistem)) 
	{
		
		for(new i=0;i<=g_botKimligi+1;i++){

			if(is_user_connected(g_Bot[i]))
			{
				//if(get_playersnum(1) > (MAXPLAYERS - i)){
				
				if(get_playersnum(1) > (ISLEM - i)){
					server_cmd("kick #%d", get_user_userid(g_Bot[i]))
					server_print("[csdSPECBOT] %d Numarali Spec Botu  oyuncu sayisi nedeni ile atildi.",i)
					g_bellekisimleri[i] = 0
					g_Bot[i] = 0
					g_botKimligi--
				}
					
			}
			else
			{
				if(get_playersnum(1)+1 < ISLEM){ 
					if(g_botKimligi < MAX_BOT_NUM)
						botlarigetir()
				}
			}
			if (get_user_team(g_Bot[i]) > 0) {
			
				TakimiAyarla(g_Bot[i])
			
			}
		}
		
		
	}
	return PLUGIN_HANDLED	
}


/*														                           TD     2019
############################################################################################################################################*/																									