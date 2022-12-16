
/*
                //----- *****{        YETSIS API 1.8         }***** -----\\
		|                                                         |
		|   Bu Eklenti Forum.YETSIS       Icin Ozel Yazilmistir.  | 
		|    Istenilen Her modda Yetkiver olarak kullanilabilir   |
		|                      WEBSIS 2019                        |
		
		|                                 			  |
                \\-------------------------------------------------------//


*/



#include <amxmodx>
#include <amxmisc>




#define PLUGIN "YETKILIOL EKLENTISI(YETSIS5)"
#define VERSIONNAME "1.8.b1b.7" 
#define AUTHOR "WEBSIS" 




enum
{
    MenuAcmaYetkisi,
    GenelMenuAcmaYetkisi,
    ADMINMENUYETKISI,
    ONAYLAMAYETKISI,
    YONETIMYETKISI,
    KONSOL,
    SIL,
    MAX_ACCESS_FLAGS,
    VERSIONN
}


new ADMYETKI[MAX_ACCESS_FLAGS],ONAYLAYETKI[MAX_ACCESS_FLAGS],YONETYETKI[MAX_ACCESS_FLAGS],SILYETKISI[MAX_ACCESS_FLAGS],VERSION[33]

new Web_Yetkili[33]
new const datafile[] = "addons/amxmodx/configs/yetsis_config.ini";
new const ofile[] = "addons/amxmodx/configs/onaylanacak_yetkililer.ini";
new const file[] = "addons/amxmodx/configs/users.ini";
new const filesay[] = "addons/amxmodx/configs/yetsis_chats.ini";
new const filesikayet[] = "addons/amxmodx/configs/yetsis_sikayet.ini";



new g_onay
new g_enabled

new ilkbakiye_cvar,bakiyesistemi_cvar,bakiyeturu
new g_bakiyeturu[33]



new tagreklam
new REK[64]







new g_menuyetki[MAX_ACCESS_FLAGS];




new nickendprefix



new yetsiskayit_tag,yetsiskayit_sontag,yetsiskayit_ykodu
new g_yts_tag[64],g_yts_sontag[64],g_yts_kyt_yetkikodu[64]

public plugin_init() {
	register_plugin(PLUGIN, VERSIONNAME, AUTHOR)
	
	
	g_enabled = register_cvar("sv_yetsis_server","1")
	if(get_pcvar_num(g_enabled)){
	set_task(120.0,"reklam",_,_,_,"b")
	register_clcmd("say /yetkiliol","karsilamenu")
	register_clcmd("say /yetkiver","karsilamenu")
	register_clcmd("say /yetsis","karsilamenu")

	register_clcmd("amx_yetkiver","addcmd",ADMYETKI[ADMINMENUYETKISI], "Kullanimi : ^"Clan | Nick^" ^"PW^" ^"Aciklama^"")

	}
	
	// YETSIS WEB
	register_clcmd("say ","saylogla")
	register_clcmd("say_team ","saylogla_team")
	register_concmd("web_saycek","web_saycek")
	register_concmd("web_guncelle","web_guncelle")
	register_concmd("web_kayitayarlari","web_kayitayarlari")
	register_concmd("web_yetkiligirisi","webyetkilikontrol")
	register_concmd("web_yetkiligirisi_steam","webyetkilikontrol_steam") // STEAM
	register_concmd("web_girisiyetkilendir","webgirisiyetkilendir")
	register_concmd("web_yetkigrubu_detay","web_yetkigrubu_detay")
	register_concmd("web_yetkiliyirutbelendir","webgirisirutbelendir")
	register_concmd("web_yetkiduzenle","web_yetkiduzenle")
	register_concmd("web_yetkionayla","web_yetkionayla")
	register_concmd("web_yetkiliislemlistesi","web_yetkilislemlistesi")
	register_concmd("web_yetkilisil","web_yetkilisil")
	register_concmd("web_onaylanacaksil","web_onaylanacaksil")
	register_concmd("web_yetkiliguncelle","web_yetkiliguncelle")
	register_concmd("web_yetkilionaylaguncelle","web_yetkilionaylaguncelle")
	register_concmd("web_yetkiligrubuislemlistesi","web_yetkiligrubuislemlistesi")
	register_concmd("web_onaylanacaklarlistesi","web_onaylanacaklarlistesi")
	register_concmd("web_sikayetlistesi","web_sikayetlistesi")
	register_concmd("web_yetkiligruplari","web_yetkiligruplari")
	register_concmd("web_rutbedenyetkigetir","webrutbedenyetkiye")
	register_concmd("web_listedenyetkiliguncelle","web_listedenyetkiliguncelle")
	register_concmd("web_listedenyetkiligrupguncelle","web_listedenyetkiligrupguncelle")
	register_concmd("web_listedenyetkilisil","web_listedenyetkilisil")
	register_concmd("web_listedenyetkiligrupsil","web_listedenyetkiligrupsil")
	register_concmd("web_yetkigrubuduzenle","web_yetkigrubuduzenle")
	register_concmd("web_bakiyeguncelle","web_bakiyeguncelle")
	register_concmd("web_oyunculistesi","web_oyunculistesi")
	register_concmd("web_rutbeyetkikodu","web_rutbeyetkikodu")
	register_concmd("web_yetkilikaydet","web_yetkilikaydet")
	register_concmd("web_yetkilikaydet_steam","web_yetkilikaydet_steam")
	register_concmd("web_yetkigrubulistesi","web_yetkigrubulistesi")
	register_concmd("web_yetkiliyukselt","web_yetkiliyukselt")
	register_concmd("web_yetkiliekle","web_yetkiliekle")
	register_concmd("web_yetkigrubuekle","web_yetkigrubuekle")
	register_concmd("web_yetkigrubucek","web_yetkigrubucek")
	register_concmd("web_topluyetkiduzenle","web_topluyetkiduzenle")
	register_concmd("web_smaversion","web_smaversion")
	
	
	
	
	yetsiskayit_tag = register_cvar("yetkiver_webyetsiskayit_tag","YETSIS |") // WEB KAYDI ICIN ILK TAG BURADAN DEGISTIRILIR
	yetsiskayit_sontag = register_cvar("yetkiver_webyetsiskayit_sontag","[Slot]") // WEB KAYDI ICIN SON TAG BURADAN DEGISTIRILIR
	yetsiskayit_ykodu = register_cvar("yetkiver_kayit_ykodu","b") // WEB KAYDI ICIN YETKI KODU BURADAN DEGISTIRILIR
	get_pcvar_string(yetsiskayit_tag,g_yts_tag,63)
	get_pcvar_string(yetsiskayit_sontag,g_yts_sontag,63)
	get_pcvar_string(yetsiskayit_ykodu,g_yts_kyt_yetkikodu,63)
	tagreklam = register_cvar("yetkiliol_reklamtag","YETSIS 1.8.7")
	get_pcvar_string(tagreklam,REK,charsmax(REK))
	
	

	
	g_onay = register_cvar("sv_clan_onay","1") // ONAY DENETIMI 0 OLUR ISE DIREKTMAN BELIRLENEN YETKILER VERILIR.


	nickendprefix = register_cvar("yetkiver_yetkiprefix","1")
	bakiyesistemi_cvar = register_cvar("yetkiver_bakiyesistemi","1")
	ilkbakiye_cvar = register_cvar("yetkiver_bakiyesistemi_bBakiye","0")
	bakiyeturu = register_cvar("yetkiver_bakiyeturu","TL")
	get_pcvar_string(bakiyeturu,g_bakiyeturu,charsmax(g_bakiyeturu))
	
	dosyalaridogrula() // KESINLIKLE SILMEYIN
	sayloglarinitemizle() // SÝLMEYÝN
	ayarcek2(); // SÝLMEYÝNÝZ
	
	return PLUGIN_HANDLED
	
	
	
	
}

public sayloglarinitemizle(){
	
	new szLine[248];
	new LineName[32],LinePW[200],LineAccess[32],LineFlag[32],g_bakiye[32],g_takim[33],g_map[33];
	new maxlines,txtlen
	maxlines = file_size(filesay,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_takim[0] = 0;
	g_map[0] = 0;
	
	read_file(filesay,line,szLine,247,txtlen)
		
	if(szLine[0]) { // Takým	Tarih	Map	Ýsim	Mesaj	Ýþlem
		parse(szLine,LineName,31,LinePW,199,LineAccess,31,g_map,32,g_bakiye,31,g_takim,32)
		write_file(filesay,"",line)
	}
	}
	server_print("[%s] Sistem Konusma Kayitlari Temizlendi.",REK)
	return PLUGIN_HANDLED
	
	
	
}


public dosyalaridogrula(){
	new const kurallar[]="addons/amxmodx/configs/ClanSozlesmesi.txt"
	server_print("[%s] #########################################",REK)
	server_print("[%s] Sistem Dosyalari Dogrulamasi basladi..",REK)
	if(!file_exists(datafile)){
		server_print("[%s] Sistem Konfigrasyon dosyasi bulunamadi..",REK)
		server_print("[%s] Sistem Konfigrasyon dosyasi olusturuluyor..",REK)
		new satir[1028]
		formatex(satir,1027,";// YETSIS 6(YETKIVER) AYAR DOSYASI^n^n^"MENUYETKI^" ^"ab^"^n^"YAZIM_SILIM_YETKISI^" ^"l^"^n^"ONAYLAMA_YETKISI^" ^"c^"^n^"YONETIMYETKISI^" ^"l^"^n^n")
		write_file(datafile,satir)
		formatex(satir,1027,";//--------------------------------------------------------------^n;//  YETSIS SISTEMI YETKILERI^n")
		write_file(datafile,satir)
		server_print("[%s] Sistem Konfigrasyon dosyasi olusturuldu..",REK)
		
	}
	else
	{
		server_print("[%s] Sistem Konfigrasyon dosyasi dogrulandi.",REK)
	}
	if(!file_exists(ofile)){
		server_print("[%s] Sistem Onaylanacak Yetkililer dosyasi bulunamadi..",REK)
		server_print("[%s] Sistem Onaylanacak Yektililer dosyasi olusturuluyor..",REK)
		new satir[1028]
		formatex(satir,1027,"^n")
		write_file(ofile,satir)
		
		server_print("[%s] Sistem Onaylanacak Yetkililer dosyasi olusturuldu..",REK)
	}
	else
	{
		server_print("[%s] Sistem Onaylanacak Yetkililer dosyasi dogrulandi.",REK)
	}
	if(!file_exists(filesay)){
		server_print("[%s] Sistem Chats dosyasi bulunamadi..",REK)
		server_print("[%s] Sistem Chats dosyasi olusturuluyor..",REK)
		new satir[1028]
		formatex(satir,1027,"^n")
		write_file(filesay,satir)
		
		server_print("[%s] Sistem Chats dosyasi olusturuldu..",REK)
	}
	else
	{
		server_print("[%s] Sistem Chats dosyasi dogrulandi.",REK)
	}
	if(!file_exists(filesikayet)){
		server_print("[%s] Sistem Sikayet dosyasi bulunamadi..",REK)
		server_print("[%s] Sistem Sikayetsdosyasi olusturuluyor..",REK)
		new satir[1028]
		formatex(satir,1027,"^n")
		write_file(filesikayet,satir)
		
		server_print("[%s] Sistem Chats dosyasi olusturuldu..",REK)
	}
	else
	{
		server_print("[%s] Sistem Sikayet dosyasi dogrulandi.",REK)
	}
	if(!file_exists(kurallar)){
		server_print("[%s] Sistem Kurallar dosyasi bulunamadi..",REK)
		server_print("[%s] Sistem Kurallar dosyasi olusturuluyor..",REK)
		new satir[1028]
		formatex(satir,1027,"^n")
		write_file(kurallar,satir)
		
		server_print("[%s] Sistem Kurallar dosyasi olusturuldu..",REK)
	}
	else
	{
		server_print("[%s] Sistem Kurallar dosyasi dogrulandi.",REK)
	}
	
	server_print("[%s] Sistem dosyalari dogrulandi.",REK)
	server_print("[%s] #########################################",REK)
	return PLUGIN_HANDLED
}


//-----WEBMODE------------------

public web_kayitayarlari(){
	
	new cvarayari[33],mahlas[33],rutbesi[33],yetkikodu[33],islem[33]
	
	read_argv(1,cvarayari,32)
	read_argv(2,mahlas,32)
	read_argv(3,rutbesi,32)
	read_argv(4,yetkikodu,32)
	read_argv(5,islem,32)
	
	

	if(equali(islem,"listele")){
		get_cvar_string("yetkiver_webyetsiskayit_tag",mahlas,32)
		get_cvar_string("yetkiver_webyetsiskayit_sontag",rutbesi,32)
		get_cvar_string("yetkiver_kayit_ykodu",yetkikodu,32)
		server_print("Cvarayari=%d&mahlas=%s&rutbesi=%s&yetkikodu=%s",get_cvar_num("yetkiver_yetkiprefix"),mahlas,rutbesi,yetkikodu)
		
		
	}
	else if(equali(islem,"kaydet")){
		set_cvar_string("yetkiver_yetkiprefix",cvarayari[0])
		set_cvar_string("yetkiver_webyetsiskayit_tag",mahlas[0])
		set_cvar_string("yetkiver_webyetsiskayit_sontag",rutbesi[0])
		set_cvar_string("yetkiver_kayit_ykodu",yetkikodu[0])
		server_print("Basarili")
	}
	
	return PLUGIN_HANDLED
	
	
	
}



public web_guncelle(){
	
	new const eski_datafile[] = "CSDYetkiVer/config.ini";
	new const eski_ofile[] = "CSDYetkiVer/onaylanacak_yetkililer/yetkililer.ini";
	
	if(!file_exists(eski_datafile)){
		server_print("Islem Basarisiz.<br>Eski config.ini Sunucuda bulunamadi.")
		return PLUGIN_HANDLED
	}
	if(!file_exists(eski_ofile)){
		server_print("Islem Basarisiz.<br>Eski yetkililer.ini Sunucuda bulunamadi.")
		return PLUGIN_HANDLED
		
	}
	
	new szLine[248];
	new LineName[32],LinePW[200],LineAccess[32],LineFlag[32],g_bakiye[32],g_takim[33],g_map[33];
	new maxlines,txtlen
	maxlines = file_size(eski_datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_takim[0] = 0;
	g_map[0] = 0;
	
	read_file(eski_datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) { 
		parse(szLine,LineName,31,LinePW,199,LineAccess,31,g_map,32,g_bakiye,31,g_takim,32)
		write_file(datafile,szLine)
	}
	}
	
	maxlines = file_size(eski_ofile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_takim[0] = 0;
	g_map[0] = 0;
	
	read_file(eski_ofile,line,szLine,247,txtlen)
		
	if(szLine[0]) { 
		parse(szLine,LineName,31,LinePW,199,LineAccess,31,g_map,32,g_bakiye,31,g_takim,32)
		write_file(ofile,szLine)
	}
	}
	
	server_print("Veri Guncellemesi Basari Ile Tamamlandi.<br>Sisteme tekrardan giris yaparak verileri yenileyebilirsiniz.")
	return PLUGIN_HANDLED
	
}

new kayitlanansatir = 0
public saylogla(id){
	
	new nick[33],text[128],ip[33],tarih[33],mapname[33]
	get_user_name(id,nick,32)
	get_user_ip(id,ip,32)
	get_mapname(mapname,32)
	read_args(text,127)
	get_time("%m/%d/%Y - %H:%M:%S",tarih,32)
	
	if(!text[0] || text[0] == '^n' || text[0] == ';' || (text[0] == '/' && text[1] == '/')){
		
	}
	else
	{
		
	new satir[300]
	if(get_user_team(id)==1){
		formatex(satir,299,"^"%s^" %s ^"%s^" ^"%s^" ^"%s^" ^"TE^"",nick,text,ip,mapname,tarih)
	}
	else if(get_user_team(id)==2){
		formatex(satir,299,"^"%s^" %s ^"%s^" ^"%s^" ^"%s^" ^"CT^"",nick,text,ip,mapname,tarih)
	}
	else{
		formatex(satir,299,"^"%s^" %s ^"%s^" ^"%s^" ^"%s^" ^"SPEC^"",nick,text,ip,mapname,tarih)
		
	}
	write_file(filesay,satir,kayitlanansatir)
	kayitlanansatir++
	}
	
	//return PLUGIN_HANDLED
	
}
public saylogla_team(id){
	
	new nick[33],text[128],ip[33],tarih[33],mapname[33]
	get_user_name(id,nick,32)
	get_user_ip(id,ip,32)
	get_mapname(mapname,32)
	read_args(text,127)
	get_time("%m/%d/%Y - %H:%M:%S",tarih,32)
	
	if(!text[0] || text[0] == '^n' || text[0] == ';' || (text[0] == '/' && text[1] == '/')){
		
	}
	else
	{
		
	new satir[300]
	if(get_user_team(id)==1){
		formatex(satir,299,"^"%s^" (TE) %s ^"%s^" ^"%s^" ^"%s^" ^"TE^"",nick,text,ip,mapname,tarih)
	}
	else if(get_user_team(id)==2){
		formatex(satir,299,"^"%s^" (CT) %s ^"%s^" ^"%s^" ^"%s^" ^"CT^"",nick,text,ip,mapname,tarih)
	}
	else{
		formatex(satir,299,"^"%s^" (SPEC) %s ^"%s^" ^"%s^" ^"%s^" ^"SPEC^"",nick,text,ip,mapname,tarih)
		
	}
	write_file(filesay,satir)
	}
	
	//return PLUGIN_HANDLED
	
}
public web_saycek(){
	
	new szLine[248];
	new LineName[32],LinePW[200],LineAccess[32],LineFlag[32],g_bakiye[32],g_takim[33],g_map[33];
	new maxlines,txtlen
	maxlines = file_size(filesay,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_takim[0] = 0;
	g_map[0] = 0;
	new satir= (maxlines+1)-line
	read_file(filesay,satir,szLine,247,txtlen)
		
	if(szLine[0]) { // Takým	Tarih	Map	Ýsim	Mesaj	Ýþlem
		parse(szLine,LineName,31,LinePW,199,LineAccess,31,g_map,32,g_bakiye,31,g_takim,32)
		if(!equali(LineName,";") && equali(g_takim,"TE")) {	
			server_print(" <tr><th class=^"bg-danger^" style=^"font-size: 12px^">%s</th>",g_takim)
			server_print(" <th class=^"bg-danger^" style=^"font-size: 12px^" >%s</th>",g_bakiye)
			//server_print(" <th class=^"bg-danger^" style=^"font-size: 12px^" >%s</th>",g_map)
			server_print(" <th class=^"bg-danger^" style=^"font-size: 12px^">%s</th>",LineName)
			server_print(" <th class=^"bg-danger^" style=^"font-size: 12px^" >%s</th>",LinePW)
			server_print(" <th><a href=^"yetkiliaraclari?sustur=%s^"><img src=^"Images/sustur.png^" width=^"20^" height=^"20^" alt=^"Sustur^"/></a></th></tr>",LineName)
			
		}
		else if(!equali(LineName,";") && equali(g_takim,"CT")) {	
			server_print(" <tr><th class=^"bg-info^" style=^"font-size: 12px^">%s</th>",g_takim)
			server_print(" <th class=^"bg-info^"style=^"font-size: 12px^" >%s</th>",g_bakiye)
			//server_print(" <th class=^"bg-info^" style=^"font-size: 12px^">%s</th>",g_map)
			server_print(" <th class=^"bg-info^"style=^"font-size: 12px^" >%s</th>",LineName)
			server_print(" <th class=^"bg-info^"style=^"font-size: 12px^" >%s</th>",LinePW)
			server_print(" <th><a href=^"yetkiliaraclari?sustur=%s^"><img src=^"Images/sustur.png^" width=^"20^" height=^"20^" alt=^"Sustur^"/></a></th></tr>",LineName)
			
		}
		else if(!equali(LineName,";") && equali(g_takim,"SPEC")) {	
			server_print(" <tr><th style=^"font-size: 12px^">%s</th>",g_takim)
			server_print(" <th style=^"font-size: 12px^">%s</th>",g_bakiye)
			//server_print(" <th>%s</th>",g_map)
			server_print(" <th style=^"font-size: 12px^">%s</th>",LineName)
			server_print(" <th style=^"font-size: 12px^">%s</th>",LinePW)
			server_print(" <th style=^"font-size: 12px^"><a href=^"yetkiliaraclari?sustur=%s^"><img src=^"Images/sustur.png^" width=^"20^" height=^"20^" alt=^"Sustur^"/></a></th></tr>",LineName)
		}
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}


public web_smaversion(){
	
	server_print("%s",VERSIONNAME)	
	return PLUGIN_HANDLED
	
	
}




new Rutbe[66]
public webyetkilikontrol(){
	new nick[32], sifre[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31)
		if(!equali(LineName,";") && equali(LineName,nick) && equali(LinePW,sifre) ) {	
			server_print("Basarili")
			copy(Web_Yetkili,32,nick)
			return PLUGIN_HANDLED
		}
			
		}
	}
	
	return PLUGIN_HANDLED
	
	
}
public webyetkilikontrol_steam(){
	new nick[32]
	read_argv(1, nick, 31)

	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31)
		if(!equali(LineName,";") && equali(LineName,nick) && equali(LineFlag,"ce") ) {	
			server_print("Basarili")
			copy(Web_Yetkili,32,nick)
			return PLUGIN_HANDLED
		}
			
		}
	}
	
	return PLUGIN_HANDLED
	
	
}
public web_oyunculistesi(){
	new takim[32]
	read_argv(1,takim,31)
	
	new players[32], playerCount, player,sayi
	get_players(players, playerCount)

	for(new i=0; i<playerCount; i++)
	{
		player = players[i]        
		new takimi = str_to_num(takim)
		if(get_user_team(player) == takimi){
			sayi++
			new ismi[33],oldurus,olus,ip[33]	
			get_user_name(player,ismi,32)
			oldurus = get_user_frags(player)
			olus = get_user_deaths(player)
			get_user_ip(player,ip,32)
			if(takimi == 1){
				server_print("<tr class=^"bg-danger^"><th scope=^"row^">%d</th><td>%s</td><td>%d</td><td>%d</td>",sayi,ismi,oldurus,olus)	
				server_print("<td><div class=^"dropdown^"><button class=^"btn btn-secondary dropdown-toggle^" type=^"button^" id=^"dropdownMenuButton^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">Islem Sec</button>")
				server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuButton^"><a class=^"dropdown-item^" href=^"#^">Islem Sec</a>")
				server_print("<a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Kick&Oyuncu=%s^">Kickle</a><a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Ban&Oyuncu=%s^">Banla</a>",ismi,ismi)
				server_print("</div></div></td>")
			}
			if(takimi == 2){
				server_print("<tr class=^"bg-info^"><th scope=^"row^">%d</th><td>%s</td><td>%d</td><td>%d</td>",sayi,ismi,oldurus,olus)	
				server_print("<td><div class=^"dropdown^"><button class=^"btn btn-secondary dropdown-toggle^" type=^"button^" id=^"dropdownMenuButton^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">Islem Sec</button>")
				server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuButton^"><a class=^"dropdown-item^" href=^"#^">Islem Sec</a>")
				server_print("<a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Kick&Oyuncu=%s^">Kickle</a><a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Ban&Oyuncu=%s^">Banla</a>",ismi,ismi)
				server_print("</div></div></td>")
			}
			if(takimi == 3){
				server_print("<tr><th scope=^"row^">%d</th><td>%s</td><td>%d</td><td>%d</td>",sayi,ismi,oldurus,olus)	
				server_print("<td><div class=^"dropdown^"><button class=^"btn btn-secondary dropdown-toggle^" type=^"button^" id=^"dropdownMenuButton^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">Islem Sec</button>")
				server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuButton^"><a class=^"dropdown-item^" href=^"#^">Islem Sec</a>")
				server_print("<a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Kick&Oyuncu=%s^">Kickle</a><a class=^"dropdown-item^" href=^"oyuncuislem.php?Mod=Ban&Oyuncu=%s^">Banla</a>",ismi,ismi)
				server_print("</div></div></td>")
			}
		}
		
	}
	return PLUGIN_HANDLED
	
	
}



public web_yetkilisil(){
	new nick[32], sifre[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31)
		if(!equali(LineName,";") && equali(LineName,nick) && equali(LinePW,sifre) ) {	
			write_file(file,"",line)
			server_print("Basarili")
			return PLUGIN_HANDLED
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_onaylanacaksil(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(ofile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31)
		if(!equali(LineName,";")) {
			new satir = str_to_num(nick)
			if(satir == line){
				write_file(ofile,"",line)
				server_print("Basarili")
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}

public web_yetkiliguncelle(){
	new nick[32], sifre[32],yeninick[32],yenisifre[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, yeninick, 31)
	read_argv(4, yenisifre, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(LineName,nick) && equali(LinePW,sifre) ) {	
			write_file(file,"",line)
			new yazilacaksatir[266]
			webrutbedenyetkiye(LineAccess)
			new tarih[32]
			get_time("%d.%m.%Y",tarih,31)
			formatex(yazilacaksatir,265,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^"  ^"%s^" ^"%s^" // DURUM : AKTIF | YAZAN : GUNCELLEME:YETSISWEB",yeninick,yenisifre,LineAccess,LineFlag,tarih,Rutbe,g_bakiye,uyarisayisi)
			write_file(file,yazilacaksatir,line)
			server_print("Basarili")
			return PLUGIN_HANDLED
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}

public web_yetkigrubu_detay(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_myetki[32],g_ontag[32],g_sontag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_myetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_myetki,31,g_ontag,31,g_sontag,31,g_bakiye,31)
		if(!equali(LineName,";") && equali(LineName,"menu") && equali(LinePW,nick)) {
			
			
			server_print("Grup=%s&Yetki=%s&Aciklama=%s&SecenekY=%s&Ontag=%s&Sontag=%s&Bakiye=%s",LinePW,LineAccess,LineFlag,g_myetki,g_ontag,g_sontag,g_bakiye)
			
		
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}

public web_yetkiliekle(){
	new nick[32], sifre[32],yetkigrubu[32],yazanyetkisi[33],tur[33],bastarih[33],bittarih[33]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, yetkigrubu, 31)
	read_argv(4,yazanyetkisi,32)
	read_argv(5,tur,32)
	read_argv(6,bastarih,32)
	read_argv(7,bittarih,32)
	
	webyetkidenrutbeye(yetkigrubu)
	if(kayitdenetim_web(nick)){
		server_print("Kayitli")
		return PLUGIN_HANDLED
	}
	
	
			
	new yazilacaksatir[266]
	formatex(yazilacaksatir,265,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"%s^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE><green><TAG><default><DEATHTAG><TAKIM><team><NICK><default>:<green><SAY>^"  ^"0^" ^"0^" // DURUM : AKTIF | YAZAN : GUNCELLEME:YETSISWEB",nick,sifre,Rutbe,tur,bastarih,bittarih,yetkigrubu)
	write_file(file,yazilacaksatir)
	server_print("Basarili")
			
	return PLUGIN_HANDLED
	
	
}
public web_yetkiliyukselt(){
	new nick[32], sifre[32],yeninick[32],yeni_yetki[32],grupbakiyesi[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, yeninick, 31)
	read_argv(4, yeni_yetki, 31)
	read_argv(5, grupbakiyesi, 31)

	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(LineName,nick) ) {
			
			new yenibakiye = str_to_num(grupbakiyesi)
			new eskibakiye = str_to_num(g_bakiye)
			yenibakiye = (eskibakiye-yenibakiye)
			server_print("%d %d %d ",grupbakiyesi,eskibakiye,yenibakiye)
			write_file(file,"",line)
			new yazilacaksatir[266],tarih[32]
			get_time("%d.%m.%Y",tarih,31)
			webrutbedenyetkiye(yeni_yetki)
			formatex(yazilacaksatir,265,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^"  ^"%d^" ^"%s^" // DURUM : AKTIF | YAZAN : GUNCELLEME:YETSISWEB",yeninick,sifre,yeni_yetki,LineFlag,tarih,Rutbe,yenibakiye,uyarisayisi)
			write_file(file,yazilacaksatir,line)
			server_print("Basarili")
			return PLUGIN_HANDLED
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkilikaydet(){
	new nick[32], sifre[32],szLine[248],tur[33]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, tur, 31)
	new tarih[32]
	get_time("%d.%m.%Y",tarih,31)
	webrutbedenyetkiye(g_yts_kyt_yetkikodu)
	if(get_pcvar_num(nickendprefix) == 0){

	
		if(get_pcvar_num(g_onay) == 0){
			new isim[32]
			formatex(isim,31,"%s %s",g_yts_tag,nick)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s %s&Sifre=%s",g_yts_tag,nick)
				return PLUGIN_HANDLED
			}
			
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :AKTIF ",g_yts_tag,nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :AKTIF ",g_yts_tag,nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			
			write_file(file,szLine)
			server_print("Durum=KayitAktif&Nick=%s %s&Sifre=%s",g_yts_tag,nick,sifre)
		}
		else
		{
			new isim[32]
			formatex(isim,31,"%s %s",g_yts_tag,nick)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s %s&Sifre=%s",g_yts_tag,nick)
				return PLUGIN_HANDLED
			}
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :ONAYDA ",g_yts_tag,nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :ONAYDA ",g_yts_tag,nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			write_file(ofile,szLine)
			server_print("Durum=KayitOnayda&Nick=%s %s&Sifre=%s",g_yts_tag,nick,sifre)
			
		}
	}
	else
	{
	
		if(get_pcvar_num(g_onay) == 0){
			new isim[32]
			formatex(isim,31,"%s %s %s",nick,g_yts_sontag)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s %s %s&Sifre=%s",g_yts_tag,nick,g_yts_sontag)
				return PLUGIN_HANDLED
			}
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :AKTIF ",g_yts_tag,nick,g_yts_sontag,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :AKTIF",g_yts_tag,nick,g_yts_sontag,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			
			write_file(file,szLine)
			server_print("Durum=KayitAktif&Nick=%s %s %s&Sifre=%s",g_yts_tag,nick,g_yts_sontag,sifre)
		}
		else
		{
			new isim[32]
			formatex(isim,31,"%s %s %s",g_yts_tag,nick,g_yts_sontag)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s %s %s&Sifre=%s",g_yts_tag,nick,g_yts_sontag,sifre)
				return PLUGIN_HANDLED
			}
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :ONAYDA ",g_yts_tag,nick,g_yts_sontag,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s %s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :ONAYDA ",g_yts_tag,nick,g_yts_sontag,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			
			write_file(ofile,szLine)
			server_print("Durum=KayitOnayda&Nick=%s %s %s&Sifre=%s",g_yts_tag,nick,g_yts_sontag,sifre)
			server_print("KayitOnayda")
		}
	
	
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkilikaydet_steam(){
	new nick[32], sifre[32],szLine[248],tur[33],tarih[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, tur, 31)
	
	get_time("%d.%m.%Y",tarih,31)
	webrutbedenyetkiye(g_yts_kyt_yetkikodu)
	
	
	if(get_pcvar_num(g_onay) == 0){
			new isim[32]
			formatex(isim,31,"%s",nick)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s&Sifre=%s",nick,sifre)
				return PLUGIN_HANDLED
			}
			
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :AKTIF ",nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :AKTIF ",nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			
			write_file(file,szLine)
			server_print("Durum=KayitAktif&Nick=%s&Sifre=%s",nick,sifre)
	}
	else
	{
			new isim[32]
			formatex(isim,31,"%s",nick)
			if(kayitdenetim(isim)){
				server_print("Durum=Basarisiz&Nick=%s&Sifre=%s",nick,sifre)
				return PLUGIN_HANDLED
			}
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"0^"  // DURUM :ONAYDA ",nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"0^" ^"0^"  // DURUM :ONAYDA ",nick,sifre,g_yts_kyt_yetkikodu,tur,tarih,Rutbe)
			write_file(ofile,szLine)
			server_print("Durum=KayitOnayda&Nick=%s&Sifre=%s",nick,sifre)
	}
	
	
	
	return PLUGIN_HANDLED
	
	
}
public web_yetkilionaylaguncelle(){
	new nick[32]
	read_argv(1, nick, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32];
	new maxlines,txtlen
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(ofile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";")) {	
			new satir = str_to_num(nick)
			if(satir == line){
				write_file(file,szLine[0])
				write_file(ofile,"",line)
				//new yazilacaksatir[266]
				//formatex(yazilacaksatir,265,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"%s^" // DURUM : AKTIF | YAZAN : ONAYLAMA:YETSISWEB",LineName,LinePW,LineAccess,LineFlag,g_bakiye,uyarisayisi)
				
				server_print("Basarili")
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_bakiyeguncelle(){
	new nick[32],yenibakiye[32]
	read_argv(1, nick, 31)
	read_argv(2, yenibakiye, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(LineName,nick)) {	
			new yenibak = str_to_num(yenibakiye)
			new eskibakiye = str_to_num(g_bakiye)
			yenibak = yenibak + eskibakiye
			write_file(file,"",line)
			new tarih[32]
			get_time("%d.%m.%Y",tarih,31)
			webrutbedenyetkiye(g_yts_kyt_yetkikodu)
			new yazilacaksatir[266]
			formatex(yazilacaksatir,265,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"31.12.2020^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%d^" ^"%s^" // DURUM : AKTIF | YAZAN : GUNCELLEME:YETSISWEB",LineName,LinePW,LineAccess,LineFlag,tarih,Rutbe,yenibak,uyarisayisi)
			write_file(file,yazilacaksatir,line)
			server_print("Basarili")
			
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkiduzenle(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";")) {
			new numara = str_to_num(nick)
			if(numara == line){
				webrutbedenyetkiye(LineAccess)
				server_print("Nick=%s&Sifre=%s&Yetki=%s&Uyari=%s&Bastarih=%s&Bittarih=%s",LineName,LinePW,Rutbe,uyarisayisi,bastarih,bittarih)
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_topluyetkiduzenle(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";")) {
			new numara = str_to_num(nick)
			if(numara == line){
				webrutbedenyetkiye(LineAccess)
				server_print("Nick=%s&Sifre=%s&Yetki=%s&Bakiye=%s&Uyari=%s",LineName,LinePW,Rutbe,g_bakiye,uyarisayisi)
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}

public web_yetkionayla(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	
	new maxlines,txtlen
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	uyarisayisi[0] =0;
	g_bakiye[0] = 0;
	read_file(ofile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";")) {
			new numara = str_to_num(nick)
			if(numara == line){
				webrutbedenyetkiye(LineAccess)
				server_print("Nick=%s&Sifre=%s&Yetki=%s&Uyari=%s",LineName,LinePW,Rutbe,uyarisayisi)
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}



public web_yetkigrubuduzenle(){
	new nick[32]
	read_argv(1, nick, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_myetki[32],g_ontag[32],g_sontag[32],g_bakiye[32];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_myetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_myetki,31,g_ontag,31,g_sontag,31,g_bakiye,31)
		if(!equali(LineName,";") && equali(LineName,"menu")) {
			new numara = str_to_num(nick)
			if(numara == line){
				server_print("Grup=%s&Yetki=%s&Aciklama=%s&SecenekY=%s&Ontag=%s&Sontag=%s&Bakiye=%s",LinePW,LineAccess,LineFlag,g_myetki,g_ontag,g_sontag,g_bakiye)
			}
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkigrubulistesi(){
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_yetki[32],g_ontag[33],g_sontag[33],g_bakiye[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_yetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_yetki,31,g_ontag,32,g_sontag,32,g_bakiye,32)
		if(!equali(LineName,";") && equali(LineName,"menu") && !equali(szLine[0],";") ) {
			sayi++
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<tr><alt> <td>%s</td><td>%s</td><td>%s</td>",LinePW,LineFlag,LineAccess)	
			server_print(Yetkisatiri)
			server_print("<td><div class=^"input-group mb-3^"><input type=^"text^" class=^"form-control^" aria-label=^"Amount (to the nearest dollar)^" value=^"%s^" disabled>",g_bakiye)
			server_print("<a href=^"yetkiyukselt.php?yukselt=%d^" class=^"btn btn-primary^" style=^"float:right^">Sec..</a>",line)
			server_print("</div></td></tr>")
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
	
	
}
public web_listedenyetkiliguncelle(){
	new nick[32],yeninick[32],yenipw[32],yeniyetkigrubu[32],yeniuyari[32],yenibastarih[33],yenibittarih[33]
	read_argv(1, nick, 31)
	read_argv(2, yeninick, 31)
	read_argv(3, yenipw, 31)
	read_argv(4, yeniyetkigrubu, 31)
	read_argv(5, yeniuyari, 31)
	read_argv(6, yenibastarih, 32)
	read_argv(7, yenibittarih, 32)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(nick,LineName)) {
			
			
			webyetkidenrutbeye(yeniyetkigrubu)
			write_file(file,"",line)
			new yetkisatiri[1027]
			formatex(yetkisatiri,1026,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"[%s]^" ^"[Yetkili]^" ^"<STEAMTAG><green><RUTBE> <green><TAG> <default><DEATHTAG><TAKIM><team><NICK><default> : <green><SAY>^" ^"%s^" ^"%s^" // DURUM : AKTIF | YAZAN : GUNCELLEME:YETSISWEB",yeninick,yenipw,Rutbe,LineFlag,yenibastarih,yenibittarih,yeniyetkigrubu,g_bakiye,yeniuyari)
			write_file(file,yetkisatiri,line)
			server_print("Basarili")
			
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_listedenyetkiligrupguncelle(){
	new nick[32],yeninick[32],yeniyetkii[32],SecenekY[32],ontag[32],Sontag[32],Bakiye[32],Aciklama[32]
	read_argv(1, nick, 31)
	read_argv(2, yeninick, 31)
	read_argv(3, yeniyetkii, 31)
	read_argv(4, SecenekY, 31)
	read_argv(5, ontag, 31)
	read_argv(6, Sontag, 31)
	read_argv(7, Bakiye, 31)
	read_argv(8, Aciklama, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(nick,LinePW)) {
		
			
			write_file(datafile,"",line)
			new yetkisatiri[128]
			formatex(yetkisatiri,127,"^"menu^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"%s^" ^"%s^"  ^"%s^"",yeninick,yeniyetkii,Aciklama,SecenekY,ontag,Sontag,Bakiye)
			write_file(datafile,yetkisatiri,line)
			server_print("Basarili")
			
			
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkigrubuekle(){
	new yeninick[32],yeniyetkii[32],SecenekY[32],ontag[32],Sontag[32],Bakiye[32],Aciklama[32]
	
	read_argv(1, yeninick, 31)
	read_argv(2, yeniyetkii, 31)
	read_argv(3, Aciklama, 31)
	read_argv(4, SecenekY, 31)
	read_argv(5, ontag, 31)
	read_argv(6, Sontag, 31)
	read_argv(7, Bakiye, 31)
	
	new yetkisatiri[128]
	formatex(yetkisatiri,127,"^"menu^" ^"%s^" ^"%s^" ^"%s^"  ^"%s^" ^"%s^" ^"%s^"  ^"%s^"",yeninick,yeniyetkii,Aciklama,SecenekY,ontag,Sontag,Bakiye)
	write_file(datafile,yetkisatiri)
	server_print("Basarili")
			

	return PLUGIN_HANDLED
	
	
}
public web_listedenyetkilisil(){
	new nick[32],yeninick[32],yenipw[32],yeniyetkigrubu[32],yeniuyari[32]
	read_argv(1, nick, 31)
	read_argv(2, yeninick, 31)
	read_argv(3, yenipw, 31)
	read_argv(4, yeniyetkigrubu, 31)
	read_argv(5, yeniuyari, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(LineName,nick)) {
			write_file(file,"",line)
			server_print("Basarili")	
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_listedenyetkiligrupsil(){
	new nick[32],yeninick[32],yenipw[32],yeniyetkigrubu[32],yeniuyari[32]
	read_argv(1, nick, 31)
	read_argv(2, yeninick, 31)
	read_argv(3, yenipw, 31)
	read_argv(4, yeniyetkigrubu, 31)
	read_argv(5, yeniuyari, 31)
	
	
	new szLine[248]
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],uyarisayisi[32];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,uyarisayisi,31)
		if(!equali(LineName,";") && equali(LinePW,nick)) {
			write_file(datafile,"",line)
			server_print("Basarili")	
		}
		
	}
	}
	return PLUGIN_HANDLED
	
	
}
public web_yetkilislemlistesi(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_uyari[0] = 0;
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,g_uyari,31)
		if(!equali(LineName,";") && !equali(szLine[0],";") ) {
			sayi++
			webrutbedenyetkiye(LineAccess)
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<tr><alt><td><div class=^"custom-control custom-checkbox^"><input type=^"checkbox^"class=^"custom-control-input^" id=^"customCheck%d^" name=^"yetkilislemleri_secili[]^" value=^"%d^"><label class=^"custom-control-label^" for=^"customCheck%d^"></label></div></td>",sayi,line,sayi)	
			server_print(Yetkisatiri)
			server_print("<th scope=^"row^">%d</th><alt> <td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>",sayi,LineName,Rutbe,bastarih,bittarih,g_bakiye,g_uyari)
			server_print("<td><div class=^"dropdown^"><a class=^"btn btn-secondary dropdown-toggle^" href=^"#^" role=^"button^" id=^"dropdownMenuLink^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">...</a>")
			server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuLink^"><a class=^"dropdown-item^" href=^"#^">...</a>") 
			server_print("<a class=^"dropdown-item^" href=^"yetkilislemleri.php?Sil=%d&Mod=users^">Sil</a>",line)
			server_print("<a class=^"dropdown-item^" href=^"yetkilislemleri.php?Duzenle=%d&Mod=users^">Duzenle</a></div></div></td></td></tr>^n",line)
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}
public web_onaylanacaklarlistesi(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33],tagsatir[33],rutbesatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_bakiye[0] = 0;
	g_uyari[0] = 0;
	read_file(ofile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,g_uyari,31)
		if(!equali(LineName,";") && !equali(szLine[0],";") ) {
			sayi++
			webrutbedenyetkiye(LineAccess)
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<tr><alt><td><div class=^"custom-control custom-checkbox^"><input type=^"checkbox^"class=^"custom-control-input^" id=^"customCheckk%d^" name=^"yetkilislemleri_secili[]^" value=^"%d^"><label class=^"custom-control-label^" for=^"customCheckk%d^"></label></div></td>",sayi,line,sayi)	
			server_print(Yetkisatiri)
			server_print("<th scope=^"row^">%d</th><alt> <td>%s</td><td>%s</td><td>%s</td><td>%s</td>",sayi,LineName,Rutbe,g_bakiye,g_uyari)
			server_print("<td><div class=^"dropdown^"><a class=^"btn btn-secondary dropdown-toggle^" href=^"#^" role=^"button^" id=^"dropdownMenuLink^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">Islem Sec</a>")
			server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuLink^"><a class=^"dropdown-item^" href=^"#^">Islem Sec</a>")
			server_print("<div class=^"custom-control custom-checkbox^"><input type=^"checkbox^"")
			server_print("class=^"custom-control-input^" id=^"customCheckk%d^" name=^"yetkilislemleri_secili[]^" value=^"%d^"><label class=^"custom-control-label^" for=^"customCheckk%d^">Sec..</label></div>",sayi,line,sayi)
			server_print("<a class=^"dropdown-item^" href=^"yetkilislemleri.php?Sil=%d&Mod=onaylanacak^">Sil</a>",line)
			server_print("<a class=^"dropdown-item^" href=^"yetkilislemleri.php?Onayla=%d&Mod=onaylanacak^">Onayla</a></div></div></td></td></tr>^n",line)
			 
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}

public web_sikayetlistesi(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[300],LineFlag[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(filesikayet,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	
	read_file(filesikayet,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,299,LineFlag,32)
		if(!equali(LineName,";") && !equali(szLine[0],";") ) {
			sayi++
			
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<tr><alt><td><div class=^"custom-control custom-checkbox^"><input type=^"checkbox^"class=^"custom-control-input^" id=^"customCheckkkk%d^" name=^"yetkilislemleri_secilii[]^" value=^"%d^"><label class=^"custom-control-label^" for=^"customCheckkkk%d^"></label></div></td>",sayi,line,sayi)	
			server_print(Yetkisatiri)
			server_print("<th scope=^"row^">%d</th><alt> <td>%s</td><td>%s</td><td>%s</td><td>%s</td>",sayi,LineName,LinePW,LineAccess,LineFlag)
			server_print("</td></tr>^n")
			 
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}

public web_yetkiligrubuislemlistesi(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_yetki[32],g_ontag[33],g_sontag[33],g_bakiye[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_yetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_yetki,31,g_ontag,32,g_sontag,32,g_bakiye,32)
		if(!equali(LineName,";") && equali(LineName,"menu") && !equali(szLine[0],";") ) {
			sayi++
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<tr><alt> <td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>",LinePW,LineAccess,g_yetki,g_ontag,g_sontag,g_bakiye)	
			server_print(Yetkisatiri)
			server_print("<td><div class=^"dropdown^"><a class=^"btn btn-secondary dropdown-toggle^" href=^"#^" role=^"button^" id=^"dropdownMenuLink^" data-toggle=^"dropdown^" aria-haspopup=^"true^" aria-expanded=^"false^">Islem Sec</a>")
			server_print("<div class=^"dropdown-menu^" aria-labelledby=^"dropdownMenuLink^"><a class=^"dropdown-item^" href=^"#^">Islem Sec</a><a class=^"dropdown-item^" href=^"yetkilislemleri.php?Sil=%d&Mod=Grub^">Sil</a>",line)
			server_print("<a class=^"dropdown-item^" href=^"yetkilislemleri.php?Duzenle=%d&Mod=Grub^">Duzenle</a></div></div></td></td></tr>^n",line)
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}
public web_yetkiligruplari(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_yetki[32],g_ontag[33],g_sontag[33],g_bakiye[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_yetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_yetki,31,g_ontag,32,g_sontag,32,g_bakiye,32)
		if(!equali(LineName,";") && equali(LineName,"menu") && !equali(szLine[0],";") ) {
			sayi++
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<option>%s</option>",LinePW)	
			server_print(Yetkisatiri)
			
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}
public web_yetkigrubucek(){
	
	
	new szLine[248],Yetkisatiri[1500];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_yetki[32],g_ontag[33],g_sontag[33],g_bakiye[33];
	new maxlines,txtlen,sayi= 0
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	g_yetki[0] = 0;
	g_ontag[0] = 0;
	g_sontag[0] = 0;
	g_bakiye[0] = 0;
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_yetki,31,g_ontag,32,g_sontag,32,g_bakiye,32)
		if(!equali(LineName,";") && equali(LineName,"menu") && !equali(szLine[0],";") ) {
			sayi++
			formatex(Yetkisatiri,charsmax(Yetkisatiri),"<button class=^"dropdown-item^" type=^"submit^" name=^"seciliguncelle^" value=^"%s^">%s</button>",LinePW,LinePW)	
			server_print(Yetkisatiri)
			
			
		}
		
	}
	
	}
	
	return PLUGIN_HANDLED
	
	
}
public webgirisiyetkilendir(){
	new nick[32], sifre[32]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33],rutbesatir[33],tagsatir[33],formatsatir[1027],bastarih[33],bittarih[33];
	new maxlines,txtlen
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	rutbesatir[0] = 0;
	tagsatir[0]=0;
	formatsatir[0]=0;
	
	
	read_file(file,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,bastarih,32,bittarih,32,tagsatir,32,rutbesatir,32,formatsatir,1026,g_bakiye,31,g_uyari,31)
		if(!equali(LineName,";") && equali(LineName,nick) ) {	
			
			new postsatiri[266]
			formatex(postsatiri,265,"Yetki=%s&Flag=%s&Bakiye=%s&Uyari=%s&Bastarih=%s&Bittarih=%s",LineAccess,LineFlag,g_bakiye,g_uyari,bastarih,bittarih)
			server_print(postsatiri)
			return PLUGIN_HANDLED
		}
		
			
		}
	}
	
	return PLUGIN_HANDLED
	
	
}

public webgirisirutbelendir(){
	new kod[64]
	read_argv(1, kod, 31)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,32)
		if(!equali(LineName,";") && equali(LineAccess,kod)) {	
			server_print(LinePW)
			return PLUGIN_HANDLED
		}
		
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}
public webrutbedenyetkiye(Yetki[]){
	
	//read_argv(1, kod, 31)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,32)
		if(!equali(LineName,";") && equali(LineAccess,Yetki)) {	
			copy(Rutbe,charsmax(Rutbe),LinePW)
			 
		}
		
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}

public webyetkidenrutbeye(Yetki[]){
	
	//read_argv(1, kod, 31)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,32)
		if(!equali(LineName,";") && equali(LinePW,Yetki)) {	
			copy(Rutbe,charsmax(Rutbe),LineAccess)
			 
		}
		
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}
public web_rutbeyetkikodu(){
	new kod[64]
	read_argv(1, kod, 31)
	 
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[33];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
	szLine[0] = 0;
	LineName[0] = 0;
	LinePW[0] = 0;
	LineAccess[0] = 0;
	LineFlag[0] = 0;
	
	read_file(datafile,line,szLine,247,txtlen)
		
	if(szLine[0]) {
		
		parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,32)
		if(!equali(LineName,";") && equali(LinePW,kod) && equali(LineName,"menu")) {	
			server_print(LineAccess)
			
		}
		
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}



// LOCAL MODE --------------------------------------------------


public addcmd(id){
	
	if(!(get_user_flags(id) & ADMYETKI[ADMINMENUYETKISI])){
		client_cmd(id,"echo [YETSIS]*****Bu Emri Kullanmaya Yetkiniz Yok!*****")
		return PLUGIN_HANDLED
	}
		
	
	new nick[32], sifre[32], yetki[32], aciklama[32],yazan[32],yetkici[MAX_ACCESS_FLAGS],tur[33]
	read_argv(1, nick, 31)
	read_argv(2, sifre, 31)
	read_argv(3, yetki, 31)
	read_argv(4, tur, 32)
	read_argv(5, aciklama, 31)
	get_user_name(id,yazan,charsmax(yazan))
	new szLine[248]
	yetkici[KONSOL] = read_flags(yetki)
	if(!(get_user_flags(id) & yetkici[KONSOL])){
		client_cmd(id,"echo [%s] Yazmak Istediginiz Yetki Yetkinizden Buyuk!",REK)
		return PLUGIN_HANDLED
	}
	
	if(!get_pcvar_num(g_onay)){
		if(get_pcvar_num(bakiyesistemi_cvar))
			formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%d^" ^"0^" // DURUM : AKTIF | YAZAN : %s ",nick,sifre,yetki,tur,aciklama,get_pcvar_num(ilkbakiye_cvar),yazan)
		if(!get_pcvar_num(bakiyesistemi_cvar))
			formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"0^" ^"0^" // DURUM : AKTIF | YAZAN : %s",nick,sifre,yetki,tur,aciklama,yazan)
		
		write_file(file,szLine)
	}
	else
	{
		formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"0^" ^"0^"// DURUM : DEAKTIF | Tur : Gonullu(Onaylanmadi) yazan : %s",nick,sifre,yetki,tur,aciklama,yazan)
		write_file(ofile,szLine)
	}
	if(get_pcvar_num(g_onay))
	{
	
		
		client_print_color(id,id,"^4[%s] ^3Yetkin Basariyla Onaylanacaklar Listesine Eklendi ^4Nick: ^3%s  ^4PW: ^3%s",REK,nick,sifre)
		client_print_color(id,id,"^4[%s] ^3Yetkin Onaylanana Kadar Suanda Belirlenen Yetki (^4%s^3)",REK,yetki)
		client_cmd(id,"echo Yetkili Onaylanacaklar Listesine Eklendi !")
		
		server_cmd("amx_reloadadmins")
		return PLUGIN_HANDLED
	}
	else
	{
		
		client_print_color(id,id,"^4[%s] ^1Yetkin Basariyla  Aktiflestirildi ^4Nick: ^3%s  ^4PW: ^3%s",REK,nick,sifre)
		client_print_color(id,id,"^4[%s] ^3Artik Bu Serverin Bir Yetkilisisin..! Kurallara Uymassan Yetkin Silinir..'",REK)
		client_print_color(id,id,"^4[%s] ^3Yetkin:^4%s^3",REK,yetki)
		client_cmd(id,"echo Yetkili kaydi gerceklestirildi")
		server_cmd("amx_reloadadmins")
		return PLUGIN_HANDLED	
	
	}
	
	
	
}




public karsilamenu(id){
ayarcek2()
server_cmd("amx_reloadadmins")
show_motd(id,"http://yetsis.tr.ht/")	
return PLUGIN_HANDLED
}


public Yapilandirmenu(id){
	
	ayarcek2()
	new menu = menu_create("\rWEBSIS\w YETSIS 6.0 YAPILANDIR BETA^nIslemler Yapilmadan Once Yedek Alinmalidir..","Yapilandir_Handler")

	menu_additem(menu,"Config Yapilandir \d| Sadece 1 Sefer Yapilmali","1")
	menu_additem(menu,"Users.ini Yapilandir. \d| Ilk Acilista Yapilmasi Gereklidir. Birden Fazla Yapmayiniz.","2")
	if(VERSION[VERSIONN]){
	menu_additem(menu,"\yYetsisi Baslat","3")	
		
	}
	
	
	

	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public Yapilandir_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
		client_print_color(id,id,"^4[%s]^3 Surum Bilgisi Ve Yetki Paketleri Guncelleniyor..",REK)
		client_cmd(id,"toggleconsole")
		client_cmd(id,"echo [%s] CONFIG YAPILANDIRILMASI BASLIYOR..-------------",REK)
		client_cmd(id,"echo [%s] Yapilandirma Kurulu Yetsis Uzerine Yapilmalidir.",REK)
		
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32],ontag[32],sontag[32],g_bakiye[33];
		new maxlines,txtlen
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
			parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,ontag,31,sontag,31,g_bakiye,32)
			if(!equali(LineName,";") && equali(menutanit,"menu") ) {
				
				write_file(datafile,"",line)
				new yenisatir[128]
				formatex(yenisatir,127,"^"menu^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"0^"",LineName,LinePW,LineAccess,LineFlag,ontag,sontag)
				write_file(datafile,yenisatir,line)
				client_cmd(id,"echo [%s] YAPILANDIRILAN : %s",REK,LineName)
				
			}
		}
		}
		write_file(datafile,"^"VERSION^" ^"5.0^"")
		client_cmd(id,"echo [%s] CONFIG YAPILANDIRILMASI SONUCLANDI-------------",REK)
		Yapilandirmenu(id)
		
		
		
		
		
		
	    
	}
	if(equali(data,"2")) {
		client_print_color(id,id,"^4[%s]^3 Yetkili Kutuphaneleri Guncelleniyor..",REK)
		client_cmd(id,"toggleconsole")
		client_cmd(id,"echo [%s] USERS.INI YAPILANDIRILMASI BASLIYOR..-------------",REK)
		client_cmd(id,"echo [%s] Yapilandirma Kurulu Yetsis Uzerine Yapilmalidir.",REK)
		
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
		new maxlines,txtlen
		maxlines = file_size(file,1);
		for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") ) {
				
				write_file(file,"",line)
				new yenisatir[128]
				formatex(yenisatir,charsmax(yenisatir),"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"0^" ^"0^" // Tur : AKTIF",LineName,LinePW,LineAccess,LineFlag)
				write_file(file,yenisatir,line)
				client_cmd(id,"echo [%s] YAPILANDIRILAN : %s",REK,LineName)
				
			}
		}
		}
		client_cmd(id,"echo [%s] USERS.INI YAPILANDIRILMASI SONUCLANDI-------------",REK)
		Yapilandirmenu(id)	
		
	    	
	}
	if(equali(data,"3")) {
		karsilamenu(id)
	    	
	}
	return PLUGIN_HANDLED
}





public ayarcek2(){
		
	//YETKI CEK
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen
	maxlines = file_size(datafile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(datafile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(!equali(LineName,";") && equali(LineName,"MENUYETKI") ) {
				g_menuyetki[GenelMenuAcmaYetkisi] = read_flags(LinePW)
				
			}
			if(!equali(LineName,";") && equali(LineName,"YAZIM_YETKISI") ) {
				ADMYETKI[ADMINMENUYETKISI] = read_flags(LinePW)
				
			}
			if(!equali(LineName,";") && equali(LineName,"ONAYLAMA_YETKISI") ) {
				ONAYLAYETKI[ONAYLAMAYETKISI] = read_flags(LinePW)
				
			}
			if(!equali(LineName,";") && equali(LineName,"YONETIMYETKISI") ) {
				YONETYETKI[YONETIMYETKISI] = read_flags(LinePW)
				
			}
			if(!equali(LineName,";") && equali(LineName,"SIL_YETKISI") ) {
				SILYETKISI[SIL] = read_flags(LinePW)
				
			}
			if(!equali(LineName,";") && equali(LineName,"VERSION") ) {
				copy(VERSION[VERSIONN],charsmax(VERSION),LineName)
			}
			
			
		}
	}
	
	return PLUGIN_HANDLED;	
		
		
}


stock admin_exists(const Name[]) {
	if(get_pcvar_num(g_onay) == 1){
	new szLine[248];
	new LineName[32],blabla[32];
	new maxlines,txtlen;
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		read_file(ofile,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			return 1;
		}
	}
	return 0;
	}
	else
	{
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
}  
stock yetkili_kontrol(const Name[]){
	
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
	
	
stock kayitdenetim(const Name[]) {
	if(get_pcvar_num(g_onay) == 1){
	new szLine[248];
	new LineName[32],blabla[32];
	new maxlines,txtlen;
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
		read_file(ofile,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			return 1;
		}
	}
	return 0;
	}
	else
	{
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
}  
stock kayitdenetim_web(const Name[]) {

	
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


public reklam(id){

	client_print_color(id,id,"^4[%s] ^3Clanimiza Katilmak Ve Bedava Yetkili Slotlugu Kapmak icin say'a ^4/yetkiliol^3 Yaziniz..!",REK)
	
}



/*														    WEBSIS DEVELOPER TEAM
**********************************************************************************************************************************************/

/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1055\\ f0\\ fs16 \n\\ par }
*/
