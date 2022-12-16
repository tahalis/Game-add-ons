      /* - - -
     |  FORUM.CSDURAGI.COM 
		CSDURAGI NICK SIFRELEYICI 5|
                                    - - - */



#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <hamsandwich>
#include <fakemeta>
#include <nvault>
#include <fun>

#define PLUGIN "CSD Nick Sifreleyici"
#define VERSION "5.05.01" // MAYIS 2020 SURUMU
#define AUTHOR "tahademirbas" 

#define DURATION 1

new SISTAG[] = "CSDURAGI"

new cvar,surecvar,noauthmod,kayitsizmod,kayitsiztakim,kayitlitakim,kayitlirevle,sistemmod;

new timer[64] = 0,oturum[64] = 0,kayit[64] = 0 ,menukapandi[64] = 0,kayitli[64] = 0,points[64] = 0, takimsec[64] = 0;
new kayitvault,kayitlikapat;

new const karaliste[ ][ ] = {
    "degis",
    "herseyc",
    "oyuncu",	
    "Yeni Isim",
    "Player",
    "PKK",
    "skm",
    "sk",
    "anan",
    "cs",
    "ailesi",
    "diyo"
    
}



native csd_oturum()
native csd_kayitdurumu()


new const file[] = "addons/amxmodx/configs/CSDNickSifreleyiciHesaplar.ini";
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	cvar = register_cvar("sv_nicksifreleyici","1")
	register_cvar("CSDNickSifreleme",VERSION,FCVAR_SERVER)
	surecvar = register_cvar("sv_nicksifreleyici_sure","60") // Saniye......
	noauthmod = register_cvar("sv_nicksifreleyici_islemmod","1") // 1-Kick 2-Ban
	sistemmod = register_cvar("sv_nicksifreleyici_mod","2") // 1- TEAMMENU AKTIF - 2 - SIYAH EKRAN TEAMMENU AKTIF
	kayitsizmod = register_cvar("sv_nickSifreleyici_kayitsiz_at","0") // kayitsiz kisiyi atar = 1 | Atmaz = 0
	kayitlikapat = register_cvar("sv_nickSifreleyici_coklukayit","1")
	kayitsiztakim = register_cvar("sv_nickSifreleyici_kayitsztakim","3") // 1-T,2-CT ,3-Spec,0-Kapali
	kayitlitakim =  register_cvar("sv_nickSifreleyici_kayitlitakim","4") // 1-T,2-CT ,3-Spec, 5-Otomatik 4- Teammenu,0- Kapali
	kayitlirevle = register_cvar("sv_nickSifreleyici_KayitliRevle","1") // 1-Revle(noTeammenu) , 0 -Revlemez
	
	kayitvault = nvault_open("NickSifreleyici55") // nVAULT Data Saglayici
	register_forward(FM_ClientUserInfoChanged, "nickkontrol")
	register_clcmd("say /sifremenu","Logmein")
	register_clcmd("say /sifre","Logmein")
	register_clcmd("say /nicksifrele","Logmein")
	
	register_clcmd("Kaydetmek_Icin_Sifre_Girin","kaydol")
	register_clcmd("Nick_Parolasi","girisyap")
	timer[0] = get_pcvar_num(surecvar)
		

	dosyalaridogrula()// SÝLMEYÝNÝZ.
	//set_task(5.0,"cvarayarlayici",_,_,_,"b")
	//set_task(2.0,"TakimAyarla",_,_,_,"b")
	
}
public cvarayarlayici(){
	if(get_cvar_num("sv_nicksifreleyici_mod")==1){
		set_cvar_num("sv_nickSifreleyici_KayitliRevle",0)
		
	}
	else if(get_cvar_num("sv_nicksifreleyici_mod")==2){
		
	}
	
	
	
}
public dosyalaridogrula(){

	server_print("[%s] #########################################",SISTAG)
	server_print("[%s] Nick Sifreleyici Dosyalarini Dogruluyor..",SISTAG)
	if(!file_exists(file)){
		server_print("[%s] Sistem Kayit dosyasi bulunamadi..",SISTAG)
		server_print("[%s] Sistem Kayit dosyasi olusturuluyor..",SISTAG)
		new satir[1028]
		formatex(satir,1027,";//CSD NICK SIFRELEYICI KAYIT DOSYASI ^n")
		write_file(file,satir)
		server_print("[%s] Kayit  dosyasi olusturuldu..",SISTAG)
		
	}
	else
	{
		server_print("[%s] Sistem Kayit dosyasi dogrulandi.",SISTAG)
	}
	server_print("[%s] #########################################",SISTAG)
	
}

public plugin_natives() 
{ 
  
    register_native("csd_oturum","native_oturumsorgula",1)
    register_native("csd_kayitdurumu","native_kayitsorgula",1)
}

public native_oturumsorgula(id){
	
	return oturum[id]; 	
}

public native_kayitsorgula(id){

	return kayit[id]; 
}



public TakimAyarla(id){
	if(!get_pcvar_num(kayitsiztakim))
		return PLUGIN_HANDLED
	
	if(!is_user_connected(id))
		return PLUGIN_HANDLED
		
	if(!get_pcvar_num(kayitsizmod)){
		if(kayitli[id]== 0)
			return PLUGIN_HANDLED
	}
	if(kayitli[id] == 2)
		return PLUGIN_HANDLED
	if(get_pcvar_num(kayitsiztakim) == 1){
		if(!(get_user_team(id) == 1))
			cs_set_user_team(id,CS_TEAM_T)	
	}
	else if(get_pcvar_num(kayitsiztakim) == 2){
		if(!(get_user_team(id) == 2))
			cs_set_user_team(id,CS_TEAM_CT)	
	}
	else if(get_pcvar_num(kayitsiztakim) == 3){
		if(!(get_user_team(id) == 3))
			cs_set_user_team(id,CS_TEAM_SPECTATOR)
	}
	//set_task(2.0,"TakimAyarla",id)
	return PLUGIN_HANDLED
	
}
public client_putinserver(id)set_task(5.0,"versionDisplay",id)



public client_authorized(id){
	
	if(get_pcvar_num(cvar) == 0)
		return PLUGIN_HANDLED
	
	if(is_user_bot(id))
		return PLUGIN_HANDLED
	
	new name[32];
	get_user_name(id,name,charsmax(name))
	if(!get_pcvar_num(kayitsizmod)){
	if(nick_kontrol(name)) {
		timer[id] = get_pcvar_num(surecvar)
		if(!kayitli[id]){
		    kayit[id] = 1
		    kayitli[id] = 1
		}
		TakimAyarla(id)
		set_task(2.0,"Logmein",id)
	}
	}
	else
	{
	if(nick_kontrol(name)) {
		timer[id] = get_pcvar_num(surecvar)
		
		if(!kayitli[id]){
		    kayit[id] = 1
		    kayitli[id] = 1
		}
		TakimAyarla(id)
		set_task(2.0,"Logmein",id)
	}
	else
	{
	timer[id] = get_pcvar_num(surecvar)
	if(!kayitli[id]){
	        kayit[id] = 0
	        kayitli[id] = 0
	}
	TakimAyarla(id)
	set_task(2.0,"Logmein",id)		
	}
	}
	//set_task(5.0,"nickkontrol",id)
	return PLUGIN_HANDLED;
}


public SaveData(id)
{
	new name[64]
	get_user_authid(id, name, 63)
	new vaultkey[64], vaultdata[256]
    
	format(vaultkey, 63, "%s", name)
	format(vaultdata, 255, "%i", points[id])
	nvault_set(kayitvault, vaultkey, vaultdata)
	

    
	return PLUGIN_CONTINUE
}


public LoadData(id)
{
	new name[64]
	get_user_authid(id, name, 63)
	new vaultkey[64], vaultdata[256]
    
	format(vaultkey, 63, "%s", name)
	format(vaultdata, 255, "%i", points[id])
	nvault_get(kayitvault, vaultkey, vaultdata, 255)
	
	new points_user[10]
	parse(vaultdata, points_user, 9)
	
	new points_set = str_to_num(points_user)
	points[id] = points_set
	
	
    
	return PLUGIN_CONTINUE
}


new bool:nickidegisti[33] = false
public nickkontrol(id, buffer){
	
	if (!is_user_connected(id))
		return FMRES_IGNORED
	
	if(is_user_bot(id))
		return FMRES_IGNORED
	
	new name[32]
	client_cmd(id,"echo [%s] Nick Kontrolu Yapildi.",SISTAG)
	engfunc(EngFunc_InfoKeyValue, buffer, "name", name, sizeof name - 1)
	if(nick_kontrol(name)) {
		client_cmd(id,"echo [%s] Kayitli Nick Saptandi.",SISTAG)
		if(!oturum[id])
		         kayitli[id] = 1
		
		if(!takimsec[id]){
			if(!oturum[id]){
				if(!nickidegisti[id]){
					nickidegisti[id] = true
					if(!task_exists(id)){
						
						set_task(2.0,"client_authorized",id)
						client_print_color(id,id,"^4[%s]^3 Suanki Nickin Parolasini Girmek Icin Bekleyin.  ",SISTAG)	
					}
				}
				
			}
		}
	}
	else
	{
		
		oturum[id] = 0
		if(nickidegisti[id])nickidegisti[id] = false
		kayitli[id] = 0
		
	}
	
	return FMRES_IGNORED
	
}


public Logmein(id,level,cid) {
	
	
	new names[33]
	get_user_name(id,names,32)
	new menu, Menuz[512]
	LoadData(id)
	if(takimsec[id] == 1){
		black_teammenu(id)
		return PLUGIN_HANDLED
		
	}
	if(oturum[id] == 0){
		if(get_pcvar_num(kayitsizmod) == 0){
		if(kayitli[id] == 1){
		
			if(timer[id] <= 0){
		
				islemuygula(id);
			
			}
			else
			{
				if(nick_kontrol(names)) {
					timer[id] -= 1
					TakimAyarla(id)
					//user_kill(id)
					set_task(1.5,"Logmein",id)
				}
		
			}
		}
		}
		else
		{
			if(timer[id] <= 0){
		
				islemuygula(id);
			
			}
			else
			{
				TakimAyarla(id)
				
				if(nick_kontrol(names)) {
					timer[id] -= 1
					set_task(1.5,"Logmein",id)
				}
				else
				{
					timer[id] -= 1
					set_task(1.5,"Logmein",id)
					
				}
		
			}
			
			
		}
	}

	
	if(kayitli[id] == 1)
		formatex(Menuz, charsmax(Menuz), "\rCSDURAGI \w| \dNick Sifreleme Sistemi \rV5^n\wKaydolmak Veyatta Giris Icin \d[\r %d Saniye..\d][\rGIRIS YAPILMADI\d]",timer[id])
	
	if(kayitli[id] == 0){
		if(get_pcvar_num(kayitsizmod) == 0)
			formatex(Menuz, charsmax(Menuz), "\rCSDURAGI \w| \dNick Sifreleme Sistemi \rV5^n\wKaydolarak Nickinizi Guvene Alabilirsiniz.! \d[\rKAYITSIZ\d]")
	
		if(get_pcvar_num(kayitsizmod) == 1)
			formatex(Menuz, charsmax(Menuz), "\rCSDURAGI \w| \dNick Sifreleme Sistemi \rV5^n\wKaydedilmesi Gerekli![\r %d Saniye..\d][\rKAYITSIZ\d]",timer[id])
	}
	if(kayitli[id] == 2)
		formatex(Menuz, charsmax(Menuz), "\rCSDURAGI \w| \dNick Sifreleme Sistemi \rV5^n\wSuanki Durum : \d[\rGIRIS YAPILDI\d]",timer[id])
	
	menu = menu_create(Menuz, "Logmein_handled")
	if(kayitli[id] == 1){
		formatex(Menuz, charsmax(Menuz), "\rGiris Yap \d| [%s] \wNicki Icin.. ",names)
		menu_additem(menu, Menuz, "1")
	}
	else
	{
		formatex(Menuz, charsmax(Menuz), "\dGiris Yap \d| [%s] \wNicki Icin.. ",names)
		menu_additem(menu, Menuz, "3")
	}
	if(get_pcvar_num(kayitlikapat) == 0){
	if(kayitli[id] == 0 ){
		if(points[id] == 0){
			formatex(Menuz, charsmax(Menuz), "\yKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
			menu_additem(menu, Menuz, "2")
		}
		else
		{
			formatex(Menuz, charsmax(Menuz), "\dKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
			menu_additem(menu, Menuz, "3")
		}
	}
	else
	{
		formatex(Menuz, charsmax(Menuz), "\dKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
		menu_additem(menu, Menuz, "3")
	}
	}
	else
	{
		if(kayitli[id] == 1){
			formatex(Menuz, charsmax(Menuz), "\yKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
			menu_additem(menu, Menuz, "2")
		}
		else
		{
			if(oturum[id] == 0){
			formatex(Menuz, charsmax(Menuz), "\yKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
			menu_additem(menu, Menuz, "2")
			}
			else
			{
			formatex(Menuz, charsmax(Menuz), "\dKaydol \d|\d [%s] Nickinize Sifre Koyar.",names)
			menu_additem(menu, Menuz, "3")	
				
			}
		}	
		
	}
	if(kayitli[id] == 2 ){
		formatex(Menuz, charsmax(Menuz), "\yParolayi Kaldir \d|\d Suanki Nickinizden Parolayi Kaldirir")
		menu_additem(menu, Menuz, "5")
	}
	else
	{
		formatex(Menuz, charsmax(Menuz), "\dParolayi Kaldir \d|\d Suanki Nickinizden Parolayi Kaldirir")
		menu_additem(menu, Menuz, "3")
	}
	if(kayitli[id] == 2 ){
		formatex(Menuz, charsmax(Menuz), "\wCikis Yap \d|\d Suanki Hesabinizdan Cikar")
		menu_additem(menu, Menuz, "4")
	}
	else
	{
		formatex(Menuz, charsmax(Menuz), "\dCikis Yap \d|\d Suanki Hesabinizdan Cikar")
		menu_additem(menu, Menuz, "3")
	}
	
	menu_setprop(menu,MPROP_EXIT, MEXIT_ALL)
	formatex(Menuz, charsmax(Menuz), "\rIptal \d|\y Oyundan Atilmaniza Neden Olabilir.!")
	
	menu_setprop(menu,MPROP_EXITNAME,Menuz)
	
	menu_display(id, menu, 0)
	
		
	
	return PLUGIN_HANDLED;
}

public Logmein_handled(id, menu, item) {
	
	if (item == MENU_EXIT)
	{
		menukapandi[id] = 1
		menu_destroy(menu)
		
		return PLUGIN_CONTINUE
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback)
	
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1:
		{
			
			menukapandi[id] = 1
			client_print_color(id,id,"^4[%s]^3 Suanki Nickin Parolasini Girin..  ",SISTAG)		
			client_cmd(id,"messagemode Nick_Parolasi")
		}
		case 2:
		{
			menukapandi[id] = 1
			client_print_color(id,id,"^4[%s]^3 Suanki Nicki Kitlemek Icin Parola Girin..!",SISTAG)
			client_cmd(id,"messagemode Kaydetmek_Icin_Sifre_Girin")
		}
		case 3:
		{
			client_print_color(id,id,"^4[%s]^3 Bu Islemi Yapamazsiniz.!",SISTAG)
		}
		case 4:
		{
			oturum[id] = 0;
			menukapandi[id] = 0
			kayitli[id] = 1;
			
			timer[id] = get_pcvar_num(surecvar)
			if(get_pcvar_num(kayitsiztakim) == 1){
				if(!(get_user_team(id) == 1))
					cs_set_user_team(id,CS_TEAM_T)	
			}
			else if(get_pcvar_num(kayitsiztakim) == 2){
				if(!(get_user_team(id) == 2))
					cs_set_user_team(id,CS_TEAM_CT)	
			}
			else if(get_pcvar_num(kayitsiztakim) == 3){
				if(!(get_user_team(id) == 3))
					cs_set_user_team(id,CS_TEAM_SPECTATOR)
			}
			user_silentkill(id)
			client_print_color(id,id,"^4[%s]^3 Cikis Yapildi.!",SISTAG)
			new cid,level
			Logmein(id,cid,level);
			
		}
		case 5:
		{
			
			
			parolakaldir(id);	
			
			
			
		}
	
	}
	return PLUGIN_HANDLED 
}

public parolakaldir(id){
	
	new name[32]
	get_user_name(id,name,charsmax(name))
	
	if(nick_sil(name)) {
			
		kayitli[id] = 0;
		oturum[id] = 0;
		points[id] = 0;
		SaveData(id)
		set_task(2.0,"Logmein",id)
		client_print_color(id,id,"^4[%s]^3 Parola Kaldirildi Ve Oturum Kapatildi.!",SISTAG)
		return PLUGIN_HANDLED
	}
	else
	{
		client_print_color(id,id,"^4[%s]^3 Parola Kaldirilamadi!:^4 Nickiniz Sistemde Bulunamadi.",SISTAG)
		client_print_color(id,id,"^4[%s]^3 Oturumdan Atildiniz.",SISTAG)
		kayitli[id] = 0;
		oturum[id] = 0;
		points[id] = 0;
		SaveData(id)
		set_task(2.0,"Logmein",id)
	}
		
	
	

	
	return PLUGIN_HANDLED;
	
}
public client_disconnected(id){
	
	//kayitli[id] = 0 
	
	
	
}

public girisyap(id){
	
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	if(!text[0]){
		
		client_print_color(id,id,"^4[%s]^3 Sifreyi Bos Gecemezsin.",SISTAG) // Kontrol Sonucu Var.
		return PLUGIN_HANDLED
		
		
	}
	
	if(pass_kontrol(text)) {
		nickidegisti[id] = false
		oturum[id] = 1
		kayitli[id] = 2
		if(get_pcvar_num(kayitlitakim)== 4){
			if(get_pcvar_num(sistemmod) == 1){
				client_cmd(id,"chooseteam")
			}
			else if(get_pcvar_num(sistemmod) == 2){
				takimsec[id] = 1
				black_teammenu(id)
			}
		}
			
		if(get_pcvar_num(kayitlitakim)== 1)
			cs_set_user_team(id,CS_TEAM_T)
		if(get_pcvar_num(kayitlitakim)== 2)
			cs_set_user_team(id,CS_TEAM_CT)
		if(get_pcvar_num(kayitlitakim)== 3)
			cs_set_user_team(id,CS_TEAM_SPECTATOR)
			
		if(get_pcvar_num(kayitlitakim)== 5){
			
			new players[32],inum,inumct;
			get_players(players,inum,"e","TERRORIST")
			get_players(players,inumct,"e","CT")
		 
			if(inum <= inumct){
				cs_set_user_team(id,CS_TEAM_T)
		
			
			}
			else
			{
				cs_set_user_team(id,CS_TEAM_CT)
			}
			
		}
			
		if(get_pcvar_num(kayitlirevle))
			ExecuteHamB(Ham_CS_RoundRespawn,id)
		
		client_print_color(id,id,"^4[%s]^3 Giris Basarili.!",SISTAG)

	}
	else
	{
		
		client_print_color(id,id,"^4[%s]^3 Giris Basarisiz.!",SISTAG)
		menukapandi[id] = 0
		new cid,level
		Logmein(id,cid,level)
	
	}
	return PLUGIN_HANDLED;
	
	
	
}

public black_teammenu(id){

	set_user_maxspeed(id,1.0)
	client_cmd(id,"+duck")
	set_user_rendering(id,kRenderFxGlowShell,0,255,0,kRenderTransAlpha,25)
	message_begin(MSG_ONE,get_user_msgid("ScreenFade"),{0,0,0},id)
	write_short(~0)
	write_short(~0)
	write_short(1<<12)
	write_byte(0)
	write_byte(0)
	write_byte(0)
	write_byte(255)
	message_end()
	new menu = menu_create("\yCSDURAGI\w Takim Sec..","black_teammenu_handler")
	menu_additem(menu,"\rTerrorist Takimi","1")
	menu_additem(menu,"\wCounter Terrorist","2")
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public black_teammenu_handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
		
		
		new players[32],inum,inumct;
		get_players(players,inum,"e","TERRORIST")
		get_players(players,inumct,"e","CT")
		 
		if(!(inum <= inumct)){
			client_print_color(id,id,"^4[%s]^3 Terrorist Takimi^4 Rakip takimdan buyuk.",SISTAG)
			black_teammenu(id)
			return PLUGIN_HANDLED
		}
		cs_set_user_team(id,CS_TEAM_T)
		client_print_color(id,id,"^4[%s]^3 Terrorist Takimi^4'na Gectin.",SISTAG)
		set_user_maxspeed(id,320.0)
		client_cmd(id,"-duck")
		set_user_rendering(id)
		message_begin(MSG_ONE,get_user_msgid("ScreenFade"),{0,0,0},id)
		write_short(~0)
		write_short(~0)
		write_short(1<<12)
		write_byte(0)
		write_byte(0)
		write_byte(0)
		write_byte(0)
		message_end()
		takimsec[id] = 0
		if(get_pcvar_num(kayitlirevle)){
			ExecuteHamB(Ham_CS_RoundRespawn,id)
			give_item(id,"weapon_glock18")
		}
	    
	}
	if(equali(data,"2")) {
		
		new players[32],inum,inumct;
		get_players(players,inum,"e","TERRORIST")
		get_players(players,inumct,"e","CT")
		 
		if(!(inumct <= inum)){
			client_print_color(id,id,"^4[%s]^3 Counter Terrorist Takimi^4 Rakip takimdan buyuk.",SISTAG)
			black_teammenu(id)
			return PLUGIN_HANDLED
		}
		
	
		cs_set_user_team(id,CS_TEAM_CT)
		client_print_color(id,id,"^4[%s]^3 Counter Terrorist Takimi^4'na Gectin.",SISTAG)
	    	set_user_maxspeed(id,320.0)
		client_cmd(id,"-duck")
		set_user_rendering(id)
		message_begin(MSG_ONE,get_user_msgid("ScreenFade"),{0,0,0},id)
		write_short(~0)
		write_short(~0)
		write_short(1<<12)
		write_byte(0)
		write_byte(0)
		write_byte(0)
		write_byte(0)
		message_end()
		takimsec[id] = 0
		if(get_pcvar_num(kayitlirevle)){
			ExecuteHamB(Ham_CS_RoundRespawn,id)
			give_item(id,"weapon_glock18")
		}
	}
		
	return PLUGIN_HANDLED
}
	
	
	



public kaydol(id){
	if (is_user_connected(id))
	{
	new text[64],name[32],ip[64];
	read_args(text,63)
	remove_quotes(text)
	get_user_name(id,name,charsmax(name))
	get_user_ip(id,ip,charsmax(ip))
	
	if(!text[0]){
		
		client_print_color(id,id,"^4[%s]^3 Sifreyi Bos Gecemezsin.",SISTAG) // Kontrol Sonucu Var.
		return PLUGIN_HANDLED
		
		
	}
	
	
	
		
		
	strtolower(name); 
	for( new i = 0;i < sizeof(karaliste);i++ ) {
	if( contain(name, karaliste[ i ] ) != -1 ) {
		client_print_color(id,id,"^4[%s]^3 Nickinizde engellenmis karakterler var.",SISTAG)
		return PLUGIN_HANDLED
	}
	}
	
	
	
	if(nick_kontrol(name)) {
			
		client_print_color(id,id,"^4[%s]^3 Bu nick daha onceden kaydedilmistir.!",SISTAG) // Kontrol Sonucu Var.
		return PLUGIN_HANDLED
	}
	new CurrentDay[16]
    
	get_time("%d/%m/%Y",CurrentDay,15)  // Tarih Atiyoruz
	
	new szLine[248]
	
	formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^"^n",name,text,ip,CurrentDay) 
	write_file(file,szLine)

	client_print_color(id,id,"^4[%s]^3 Kayit Basarili.!",SISTAG)
	client_print_color(id,id,"^4[%s]^3 Nick : %s Sifre : %s",SISTAG,name,text)
	client_print_color(id,id,"^4[%s]^3 Bilgilerinizi Unutmayiniz.!",SISTAG)
	motdgoster(id,name,text)
	oturum[id] = 1
	kayitli[id] = 2
	points[id] = 1 
	SaveData(id)
	if(get_pcvar_num(kayitlitakim)== 4){
		if(get_pcvar_num(sistemmod) == 1){
			client_cmd(id,"chooseteam")
		}
		else if(get_pcvar_num(sistemmod) == 2){
			takimsec[id] = 1
			black_teammenu(id)
		}
	}
	if(get_pcvar_num(kayitlitakim)== 1)
		cs_set_user_team(id,CS_TEAM_T)
	if(get_pcvar_num(kayitlitakim)== 2)
		cs_set_user_team(id,CS_TEAM_CT)
	if(get_pcvar_num(kayitlitakim)== 3)
		cs_set_user_team(id,CS_TEAM_SPECTATOR)
	if(get_pcvar_num(kayitlitakim)== 5){
			
			new players[32],inum,inumct;
			get_players(players,inum,"e","TERRORIST")
			get_players(players,inumct,"e","CT")
		 
			if(inum <= inumct){
				cs_set_user_team(id,CS_TEAM_T)
		
			
			}
			else
			{	
				cs_set_user_team(id,CS_TEAM_CT)
			}
	}		
	if(get_pcvar_num(kayitlirevle))
		ExecuteHamB(Ham_CS_RoundRespawn,id)
	client_print_color(id,id,"^4[%s]^3 Giris Yapildi.!",SISTAG)
	}
	return PLUGIN_HANDLED;
}
public motdgoster(id,const name[],const text[]){
	
					new message[1100],len;  
					len = formatex(message,1099,"<body style=^"background-color: #2B2B2B^">^n");  
					for(new i = 1; i < 33; i++)
					{
						if(is_user_connected(i))
						{
							
					
						
							len += formatex(message[len],1099-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">CSDURAGI NICK SIFRELEYICI 5</h2></header>^n")
							len += formatex(message[len],1099-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
							len += formatex(message[len],1099-len,"<h3 style=^"text-align: center^">YENI NICK KAYIT BILDIRIMI</h3>^nNickin Basari Ile Sifrelenip Kayit Altina Altinmistir. Eger Bir Sorun ile Karsilasirsaniz Yoneticilere Basvurunuz.^n")
							len += formatex(message[len],1099-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">YENI NICK BILGILERI</h4>^n")
							len += formatex(message[len],1099-len,"<div style=^"background-color: #C1C1C1^"><b>NICK</b>: %s</div>^n",name)
							len += formatex(message[len],1099-len,"<div style=^"background-color: #C1C1C1^"><b>SIFRE</b>: %s</div>^n",text)
							len += formatex(message[len],1099-len,"<br>Bilgilerinizi unutmayiniz ve saklayiniz.<br>Unutma Gibi Durumlarda Iletisim Adreslerimizden Yoneticiler Ile Iletisim Kurunuz</div><div>. </div>^n")
							len += formatex(message[len],1099-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">Forum.CSDuragi.Com | Csduragi Nick Sifreleme 5 | CSduragi Dev Team 2019 | Csduragi.Com</footer></body>^n")
							
						
						}
					}
					show_motd(id,message,"CSD NICK SIFRELEYICI 5"); 
					
					return PLUGIN_HANDLED
	
}
stock nick_sil(const Name[]) {
	new szLine[248];
	new LineName[32],blabla[32],linee[33];
	new maxlines,txtlen;
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		read_file(file,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			num_to_str(line,linee,charsmax(linee))
			write_file(file,"",str_to_num(linee))
			
			return 1;
		}
	}
	return 0;
}
stock nick_kontrol(const Name[]) {
	new szLine[248];
	new LineName[32],blabla[32];
	new maxlines,txtlen;
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		read_file(file,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			return 1;
		}
	}
	return 0;
}
stock pass_kontrol(const Name[]) {

	
	new szLine[248];
	new LineName[32],blabla[32],pw[64];
	new maxlines,txtlen;
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		read_file(file,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31,pw,63)
		if(equali(blabla,Name)) {
			return 1;
		}
	}
	return 0;



}


public islemuygula(id){
	
	new name[32];
	get_user_name(id,name,charsmax(name))
	
	if(get_pcvar_num(kayitsizmod) == 0){
		if(!(kayitli[id] == 1)){
			return PLUGIN_HANDLED
			
		}
		else
		{
			
		}
		
	
			
	
		
	}
		
	
	if(oturum[id] == 1){
			
		return PLUGIN_HANDLED;	
	}
	else
	{
		if(!is_user_bot(id)){
		if(get_pcvar_num(noauthmod) == 1){
			client_print_color(0,0,"^4[%s]^3 %s^4 Belirlenen Sure Icerisinde Nickine Giris Yapamadigi Icin Kicklendi",SISTAG,name)
			server_cmd("kick #%d ^"Nick Sifresini Belirtilen Sure Icerisinde Giremedigin Icin Oyundan Atildin.!^"", get_user_userid(id))	
		}
		if(get_pcvar_num(noauthmod) == 2){
			client_print_color(0,0,"^4[%s]^3 %s^4 Belirlenen Sure Icerisinde Nickine Giris Yapamadigi Icin ^3 20 DK^4 Banlandi.!",SISTAG,name)
			server_cmd("ban #%d 20 ^"Nick Sifresini Belirtilen Sure Icerisinde Giremedigin Icin 20dk Oyundan Atildin.!^"", get_user_userid(id))	
			
		}
		}
		
	}
	return PLUGIN_HANDLED;
	
}	
public versionDisplay(id){
	client_print_color(id,id,"^4[%s]^1 Bu sunucuda Nickler ^3CSD Nick Sifreleyici^1 Eklentisi ile korunmaktadir..",SISTAG)
	client_print_color(id,id,"^4[%s]^1 Nickini sifrelemek icin ^3/nicksifrele^1,^3/sifre^1,^3/sifremenu^1 yazabilirsin..",SISTAG)
	return PLUGIN_HANDLED
}
