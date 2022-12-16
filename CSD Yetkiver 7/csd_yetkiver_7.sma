
/*
                //----- *****{        CSD YETKIVER 7          }***** -----\\
		|                                                         |
		|   Bu Eklenti Forum.CSDURAGI       Icin Ozel Yazilmistir.  | 
		|    Istenilen Her modda Yetkiver olarak kullanilabilir   |
		|                      FORUM CSD 2020                     |
		|                                 			  |
                \\-------------------------------------------------------//


*/



#include <amxmodx>
#include <amxmisc>




#define PLUGIN "CSD YETKILIOL EKLENTISI(YETSIS 7)"
#define VERSIONNAME "7.0" 
#define AUTHOR "TahaDemirbas" 




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


new menuyetki[MAX_ACCESS_FLAGS],ADMYETKI[MAX_ACCESS_FLAGS],ONAYLAYETKI[MAX_ACCESS_FLAGS],YONETYETKI[MAX_ACCESS_FLAGS],SILYETKISI[MAX_ACCESS_FLAGS],VERSION[33]
new Rutbe[33]
new const islemkodu[][]={
	"AnemenuKod",		
	"YetkiliMenuKod",
	"YeniYetkiliMenuKod",
	"YetkiTuruIslemleri"
}
	

new const datafile[] = "addons/amxmodx/configs/yetsis_config.ini";
new const ofile[] = "addons/amxmodx/configs/onaylanacak_yetkililer.ini";
new const file[] = "addons/amxmodx/configs/users.ini";
new const filesay[] = "addons/amxmodx/configs/yetsis_chats.ini";
new bool:Slot_Nick_Giris[33]
new bool:Slot_Pw_Giris[33]
new bool:YeniYetki_Giris[33]
new bool:KendineYaz[33] = false
new g_szName[33];
new g_onay
new g_enabled
new sozlesme
new ilkbakiye_cvar,bakiyesistemi_cvar,bakiyeturu
new bakiye[33] = 0,g_bakiyeturu[33]
new yetkisecmeturu[33] = 0


new tagreklam
new REK[64]


new g_mapsiniri[64];
new g_sozlesme[64],silineceksatir[33];



new g_menuyetki[MAX_ACCESS_FLAGS];


new sifrem[64]
new modecvar

new nickendprefix
new ayar[32][32]
new SecilenYetkiler[64] = 0
new Bakiyem[33],yetkiyiyukselt[33] = 0,yukseltilecekyetki[33]
new yetsiskayit_tag,yetsiskayit_sontag,yetsiskayit_ykodu
new g_yts_tag[64],g_yts_sontag[64],g_yts_kyt_yetkikodu[64]
new Yetkim[33],Uyarim[33],BaslamaTarihi[33],BitisTarih[33]

public plugin_init() {
	register_plugin(PLUGIN, VERSIONNAME, AUTHOR)
	
	 
	g_enabled = register_cvar("sv_yetsis_server","1")
	if(get_pcvar_num(g_enabled)){
	set_task(120.0,"reklam",_,_,_,"b")
	register_clcmd("say /yetkiliol","karsilamenu")
	register_clcmd("say /yetkiver","karsilamenu")
	register_clcmd("say /yetsis","karsilamenu")
	register_clcmd("YetkiNicki","mSlot_Nick")
	register_clcmd("YetkiSifre","mSlot_Sifre")
	register_clcmd("yt_adi","yetkiekle2")
	register_clcmd("yt_veryetki","yetkiekle3")
	register_clcmd("yt_aciklama","yetkiekle4")
	register_clcmd("yt_yetyetki","yetkiekle5")
	register_clcmd("yt_tag","yetkiekle6")
	register_clcmd("yt_rutbe","yetkiekle7")
	register_clcmd("yt_fiyati","yetkiekle8")
	register_clcmd("amx_yetkiver","addcmd",ADMYETKI[ADMINMENUYETKISI], "Kullanimi : ^"Clan | Nick^" ^"PW^" ^"Aciklama^"")
	register_clcmd("YeniNick","NickDegis")
	register_clcmd("YeniSifre","SifreDegistir")
	
	register_clcmd(islemkodu[0],"Karsila_Handler")
	register_clcmd(islemkodu[1],"MainMenu_Handler")
	register_clcmd(islemkodu[2],"Yetkituru_Handler")
	register_clcmd(islemkodu[3],"YMainMenu_Handler")
	
	}
	

	
	
	
	yetsiskayit_tag = register_cvar("yetkiver_webyetsiskayit_tag","YETSIS |") // WEB KAYDI ICIN ILK TAG BURADAN DEGISTIRILIR
	yetsiskayit_sontag = register_cvar("yetkiver_webyetsiskayit_sontag","[Slot]") // WEB KAYDI ICIN SON TAG BURADAN DEGISTIRILIR
	yetsiskayit_ykodu = register_cvar("yetkiver_kayit_ykodu","b") // WEB KAYDI ICIN YETKI KODU BURADAN DEGISTIRILIR
	get_pcvar_string(yetsiskayit_tag,g_yts_tag,63)
	get_pcvar_string(yetsiskayit_sontag,g_yts_sontag,63)
	get_pcvar_string(yetsiskayit_ykodu,g_yts_kyt_yetkikodu,63)
	tagreklam = register_cvar("yetkiliol_reklamtag","YETSIS 7")
	get_pcvar_string(tagreklam,REK,charsmax(REK))
	
	

	
	g_onay = register_cvar("sv_clan_onay","1") // ONAY DENETIMI 0 OLUR ISE DIREKTMAN BELIRLENEN YETKILER VERILIR.
	sozlesme = register_cvar("yetkiver_sozlesme","1")
	modecvar = register_cvar("yetkiver_mod","0") // 0 - YETKILERE GORE HERKEZ | 1- SADECE YETKILILER
	nickendprefix = register_cvar("yetkiver_yetkiprefix","1")
	bakiyesistemi_cvar = register_cvar("yetkiver_bakiyesistemi","1")
	ilkbakiye_cvar = register_cvar("yetkiver_bakiyesistemi_bBakiye","0")
	bakiyeturu = register_cvar("yetkiver_bakiyeturu","TL")
	get_pcvar_string(bakiyeturu,g_bakiyeturu,charsmax(g_bakiyeturu))
	
	dosyalaridogrula() // KESINLIKLE SILMEYIN
	ayarcek2(); // SÝLMEYÝNÝZ
	
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
		formatex(satir,1027,";// YETSIS 7(YETKIVER) AYAR DOSYASI^n^n^"MENUYETKI^" ^"ab^"^n^"YAZIM_SILIM_YETKISI^" ^"l^"^n^"ONAYLAMA_YETKISI^" ^"c^"^n^"YONETIMYETKISI^" ^"l^"^n^n")
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
	if(!VERSION[VERSIONN]){
		if(get_user_flags(id) & ADMIN_RCON) {
			client_print_color(id,id,"^4[%s] ^3Yetkiver Acilamiyor..!",REK)
			client_print_color(id,id,"^4[%s] ^3Yetkiverin Acilmasi Icin Config.ini Ve yetkili kutuphanelerinin guncellenmesi gereklidir.",REK)
			Yapilandirmenu(id)
		}
		else
		{
			client_print_color(id,id,"^4[%s] ^3Yetkiver Teknik Hata Nedeni Ile Kapalidir.",REK)
			client_print_color(id,id,"^4[%s] ^3Sorunun Devam Etmesi Durumnda Yoneticilere Danisiniz..!",REK)
			
		}	
		
		return PLUGIN_HANDLED
		
	}
	
	bakiyeyukle(id)
	new name[32]
	get_user_name(id,name,31)
	
	if(get_pcvar_num(modecvar)){
		
		if(get_user_flags(id) & g_menuyetki[GenelMenuAcmaYetkisi]){
		
		}
		else
		{
			client_print_color(id,id,"^4[%s] ^3Yetkiver'i Kullanabilmeniz Icin^4 %s^3 Yetkisinde Olmalisiniz.",REK,g_menuyetki[0])
			return PLUGIN_HANDLED
		}
					
			
			
	}
	yetkilibilgisicek(id,name)
	new message[1000],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yetkili Sistemine Hos Geldiniz.</h3>^nDevam Edebileceginiz Yolu Secip Islemlerinizi Gerceklestirebilirsiniz.^n")
			if(get_user_flags(id) & g_menuyetki[GenelMenuAcmaYetkisi]) {
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[1] - YETKILI MENUSU</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[4] - YETKILI PANELIM</h4>^n")
			
			
			}
			else
			{
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[2] - YETKILI OL</h4>^n")	
			}
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[3] - YETKILI KURALLARI</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br>Seceneklerin Yanindaki [sayi] tuslari ile secimi tuslayip entere basiniz.</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
						
						
		}
	}
	show_motd(id,message,"Yetkili Sis."); 
	
	client_cmd(id,"messagemode %s",islemkodu[0])
	/*
	new menu = menu_create("\yCSD GELISMIS YETKILI EKLEME SISTEMI \w|\d YETSISv4","Karsila_Handler")
	if(get_user_flags(id) & g_menuyetki[GenelMenuAcmaYetkisi]) {
		menu_additem(menu,"\yYetkili Menusu","1")
		menu_additem(menu,"\wHesap Panelim","4")
	
	}
	else
	{
		menu_additem(menu,"\yYetkili Ol","2")
	}	
	
	menu_additem(menu,"Yetkili Kurallari","3")
	
	

	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	*/
	return PLUGIN_HANDLED
	
	
	
	

}

public bakiyeyukle(id){
		
		new isim[33]
		get_user_name(id,isim,32)
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32];
		new maxlines,txtlen,durum = 0
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
			if(!equali(LineName,";") && equali(LineName,isim) ) {
				new para = str_to_num(g_bakiye)
				if(para){
					bakiye[id] = para
					client_print_color(id,id,"^4[%s]^3 Hesap Bilgilerin Cekildi.",REK)
					durum = 1
				}
				
			}
		}
		}
		if(!durum){
			bakiye[id] = 0	
		}
		return PLUGIN_HANDLED
	
}

public bakiyekaydet(id){
	
		new isim[33]
		get_user_name(id,isim,32)
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[32];
		new maxlines,txtlen
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
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,31)
			if(!equali(LineName,";") && equali(LineName,isim) ) {
		
				write_file(file,"",line)
				new satir[128]
				formatex(satir,charsmax(satir),"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%d^" ^"%s^" // Tur : AKTIF",LineName,LinePW,LineAccess,LineFlag,bakiye[id],g_uyari)
				write_file(file,satir,line)
				
			}
		}
		}
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


public Karsila_Handler(id) {
	new key[33]
	read_args(key,32)
	remove_quotes(key)
	switch(str_to_num(key)){
	case 1: {
		yetkiliekle(id)
		
	}
	case 2: {
		
		if(get_pcvar_num(sozlesme) == 0){
			Slot_Nick_Giris[id] = true;
			new message[1000],len;  
			len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
			for(new i = 1; i < 12; i++)
			{
			if(is_user_connected(i))
			{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yetkili Olarak Kaydol</h3>^nYetkili olarak kaydolmak icin asagidaki yonergeleri takip etmelisiniz..^n")
			
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Yetkili Olarak Kaydolacaginiz Nicki Klavyenizden Girin. Ve Entere Basin.</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Kayit Islemi basarili oldugunda kullanici Klan kurallarina mutabik sayilir.</h4>^n")
			
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br></div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
			}
			}
			show_motd(id,message,"YETSIS | Kaydol"); 
			client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
			client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
			client_cmd(id,"messagemode YetkiNicki")
		
			
		
		}
		else	
		{
			
			if(g_sozlesme[id] < 1){
				client_print_color(id,id,"^4[%s] ^3Klan Sozlesmesini okumadan Kaydolamazsiniz. Okuyup Tekrar Deneyiniz",REK)
				show_motd(id,"CSDYetkiVer/ClanSozlesmesi.txt", "Kayit Oncesi Sartlar")
				g_sozlesme[id] += 1
				karsilamenu(id)
				return PLUGIN_HANDLED
			}
			
			Slot_Nick_Giris[id] = true;
			new message[1000],len;  
			len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
			for(new i = 1; i < 12; i++)
			{
			if(is_user_connected(i))
			{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yetkili Olarak Kaydol</h3>^nYetkili olarak kaydolmak icin asagidaki yonergeleri takip etmelisiniz..^n")
			
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Yetkili Olarak Kaydolacaginiz Nicki Klavyenizden Girin. Ve Entere Basin.</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Kayit Islemi basarili oldugunda kullanici Klan kurallarina mutabik sayilir.</h4>^n")
			
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br></div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
			}
			}
			show_motd(id,message,"YETSIS | Kaydol"); 
			client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
			client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
			client_cmd(id,"messagemode YetkiNicki")
			
		
		}
	}
	
	case 3: {
		show_motd(id,"CSDYetkiVer/ClanSozlesmesi.txt", "Yetkili Sartlari")
		
	}
	case 4:{
		KullaniciPaneli(id)	
	}
	}

	return PLUGIN_HANDLED
}/*
public Karsila_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)
	new secenekdata = str_to_num(data)
	switch(secenekdata){
	case 1: {
		yetkiliekle(id)
		
	}
	case 2: {
		
		if(get_pcvar_num(sozlesme) == 0){
			Slot_Nick_Giris[id] = true;
		
			client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
			client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
			client_cmd(id,"messagemode YetkiNicki")
		
			
		
		}
		else	
		{
			
			if(g_sozlesme[id] < 1){
				client_print_color(id,id,"^4[%s] ^3Klan Sozlesmesini okumadan Kaydolamazsiniz. Okuyup Tekrar Deneyiniz",REK)
				show_motd(id,"CSDYetkiVer/ClanSozlesmesi.txt", "Kayit Oncesi Sartlar")
				g_sozlesme[id] += 1
				karsilamenu(id)
				return PLUGIN_HANDLED
			}
			
			Slot_Nick_Giris[id] = true;
		
			client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
			client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
			client_cmd(id,"messagemode YetkiNicki")
			
		
		}
	}
	
	case 3: {
		show_motd(id,"CSDYetkiVer/ClanSozlesmesi.txt", "Yetkili Sartlari")
		
	}
	case 4:{
		KullaniciPaneli(id)	
	}
	}

	return PLUGIN_HANDLED
}*/



public step2(id){
		
		
	Slot_Nick_Giris[id] = true;
		
	client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
	client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
	client_cmd(id,"messagemode YetkiNicki")		
		
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

public yetkiliekle(id){

	new message[1000],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">YETKILI ISLEMLERI</h3>^nSizin Icin Tanimlanan Islemler Uzerinde Islem Yapmak Icin Secin..^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[4] - Yeni Yetkili Ekle</h4>^n")
			if(get_user_flags(id) & SILYETKISI[SIL]) {
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[2] - YETKILI SIL</h4>^n")
			}
			if(get_user_flags(id) &ONAYLAYETKI[ONAYLAMAYETKISI]) {
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[3] - YETKILI ONAYLA</h4>^n")
			}
			if(get_user_flags(id) &YONETYETKI[YONETIMYETKISI]) {
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[5] - YETKI TURLERINI YONET</h4>^n")
			}
			if(get_user_flags(id) &ADMYETKI[ADMINMENUYETKISI]) {
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[7] - ONAYLANMAMIS YETKILI SIL</h4>^n")
			}
	
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br>Seceneklerin Yanindaki [sayi] tuslari ile secimi tuslayip entere basiniz.</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
						
						
		}
	}
	show_motd(id,message,"YETSIS | YETKILI ISLEMLERI"); 
	
	client_cmd(id,"messagemode %s",islemkodu[1])

	return PLUGIN_HANDLED
	
	
}

public yetkiliekle_tursecimi(id){
	
	new message[1000],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yeni Yetkili Ekle</h3>^nSizin Icin Tanimlanan Islemler Uzerinde Islem Yapmak Icin Secin..^n")
			
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[1] - Elle Girerek Ekle</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[2] - Oyunculardan Secerek Ekle</h4>^n")
			
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br>Seceneklerin Yanindaki [sayi] tuslari ile secimi tuslayip entere basiniz.</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
		}
	}
	show_motd(id,message,"YETSIS | YETKILI EKLE"); 
	
	client_cmd(id,"messagemode %s",islemkodu[2])
		
	return PLUGIN_HANDLED
	
	
}
public Yetkituru_Handler(id) {

	new data[6]
	read_args(data,5)
	remove_quotes(data)
	new secenek = str_to_num(data)
	switch(secenek){
	case 1: {
		
		step2(id)
		
	}
	case 2: {
		oyunculistesi(id)
		
	}
	}
	return PLUGIN_HANDLED
	}

public oyunculistesi( id )
	{	
		new iPlayers[ 32 ], iNum;
		get_players( iPlayers, iNum );
		
		new szInfo[ 6 ], hMenu;
		hMenu = menu_create( "\yCSD GELISMIS YETKILI EKLEME SISTEMI \w|\d Yonetici Modu^n\wCevrimici Oyunculardan Sec", "oyunculistesi_Handler" );
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

public oyunculistesi_Handler( id, hMenu, iItem )
	{
		if( iItem == MENU_EXIT )
		{
			yetkiliekle(id)
			return PLUGIN_HANDLED;
		}
		new szData[ 6 ], iAccess, hCallback, szName[ 32 ];
		menu_item_getinfo( hMenu, iItem, iAccess, szData, 5, szName, 31, hCallback );
		new iPlayer = str_to_num( szData );
		if( !is_user_connected( iPlayer ) ){
			client_print_color(id,id,"^4[%s] ^3Secilen Oyuncu Suanda Cevrimici Degil!",REK)
			oyunculistesi(id)
			return PLUGIN_HANDLED;
		}
		Slot_Pw_Giris[id] = true;
		copy(g_szName[id],31,szName)
				
		client_cmd(id,"messagemode YetkiSifre")
		
		return PLUGIN_HANDLED;
}

public menusdas(id) {
	
	
	if(get_pcvar_num(g_enabled) == 1){
	new menu = menu_create("\yYetki Turu Secin.. | \dCSD GELISMIS YETKILI EKLEYICI","MainMenu_Handler")
	if(yetkisecmeturu[id] == 0){
	//menu_additem(menu,"\rKlan Sozlesmesini Oku","8")
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32];
	new maxlines,txtlen,linee[6],Yetki[32];
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
			if(!equali(LineName,";") && equali(menutanit,"menu") ) {
				num_to_str(line,linee,5)
				copy(Yetki,charsmax(Yetki),LineFlag)
				
				menu_additem(menu,LineName,"1")
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	}
	else if(yetkisecmeturu[id] == 1){
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32],ontag[33],sontag[33],g_bakiye[33];
	new maxlines,txtlen,linee[6],Yetki[32];
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
			parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,ontag,32,sontag,32,g_bakiye,32)
			new secenekbak = str_to_num(g_bakiye)
			if(!equali(LineName,";") && equali(menutanit,"menu") && secenekbak > 0 ) {
				num_to_str(line,linee,5)
				new para = str_to_num(g_bakiye)
				copy(Yetki,charsmax(Yetki),LineFlag)
				if(bakiye[id] >= para)
					menu_additem(menu,LineName,"1")
				
				if(bakiye[id] < para)
					menu_additem(menu,LineName,"9")
			}
		}
	}
	
	
	
	
	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED		
		
	}
	}
	
	if(g_mapsiniri[0] == 5){
	
	client_print_color(id,id,"^4[%s] ^1Maalesef Clana Alim bu Map icin Sinira Varmistir. Mapin Degismesini Bekleyiniz..!",REK)
	
	
	
	}
	
	
	return PLUGIN_HANDLED

}

public MainMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	
	new data[6],name[333];
	new access,callback;
	read_args(data,5)
	remove_quotes(data)
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	
	
	new secenek = str_to_num(data)
	
	
	switch(secenek){
	case 1: {
		
		
		new isim[32];
		get_user_name(id,isim,31)
		if(kayitdenetim(isim)) {
			client_print_color(id,id,"^4[%s] ^3Erisim Engellendi: ^1Zaten Kayitlisiniz..!",REK)
			return PLUGIN_HANDLED
		}
		
		
		new secenek[120]
		format(secenek,charsmax(secenek),name)
		if(yetkisecmeturu[id] == 0){
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32],yetkiacikla[333],g_yetki[64],g_tag[64],tagi[33],g_endprefix[33],nicksonutag[64];
		new maxlines,txtlen,linee[6];
		maxlines = file_size(datafile,1);
		linee[0] = 1
		
	
		for(new line;line<maxlines;line++) {
			szLine[0] = 0;
			LineName[0] = 0;
			LinePW[0] = 0;
			LineAccess[0] = 0;
			LineFlag[0] = 0;
			menutanit[0] = 0;
			g_tag[0] = 0;
			g_endprefix[0] = 0;
			read_file(datafile,line,szLine,247,txtlen)
			if(szLine[0]) {
				parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_tag,63,g_endprefix,32)
				if(!equali(LineName,";") && equali(LineName,secenek)) {
					
					menuyetki[MenuAcmaYetkisi] = read_flags(LineFlag)
					
					
						
					
				
					if((get_user_flags(id) & menuyetki[MenuAcmaYetkisi])){ 
				
						copy(g_yetki[id],63,LinePW)
						copy(yetkiacikla[id],332,LineAccess)
						copy(tagi[id],32,g_tag)
						copy(nicksonutag[id],63,g_endprefix)
						if(!yetkiyiyukselt[id])
							add_slot(id,g_szName[id],sifrem[id],g_yetki[id],yetkiacikla[id],tagi[id],nicksonutag[id])
						
					}
					else
					{
						client_print_color(id,id,"^4[%s] ^3 %s ^4 Yetki Turu Kaydi Icin suanda %s Yetkiniz Yetmemekte.!",REK,name,LineFlag)	
						menusdas(id);
						return PLUGIN_HANDLED;
						
						
					}
					
					
					
					
				
				}
			}
		}
		
		
		}
		else if(yetkisecmeturu[id] == 1){
		
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32],yetkiacikla[333],g_yetki[64],g_tag[64],tagi[33],g_endprefix[33],nicksonutag[64],g_bakiye[33];
		new maxlines,txtlen,linee[6];
		maxlines = file_size(datafile,1);
		linee[0] = 1
		
	
		for(new line;line<maxlines;line++) {
			szLine[0] = 0;
			LineName[0] = 0;
			LinePW[0] = 0;
			LineAccess[0] = 0;
			LineFlag[0] = 0;
			menutanit[0] = 0;
			g_tag[0] = 0;
			g_endprefix[0] = 0;
			read_file(datafile,line,szLine,247,txtlen)
			if(szLine[0]) {
				parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_tag,63,g_endprefix,32,g_bakiye,32)
				if(!equali(LineName,";") && equali(LineName,secenek)) {
					new para = str_to_num(g_bakiye)
					copy(yukseltilecekyetki,32,LinePW)
					copy(yetkiacikla[id],332,LineAccess)
					copy(tagi[id],32,g_tag)
					copy(nicksonutag[id],63,g_endprefix)
					bakiye[id] -= para
					if(!yetkiyiyukselt[id])
						add_slot(id,g_szName[id],sifrem[id],g_yetki[id],yetkiacikla[id],tagi[id],nicksonutag[id])
				}
			}
		}
		
		
	}
		
		if(yetkiyiyukselt[id]){
			client_print_color(id,id,"^4[%s] ^3 %s ^4 Yetki Turune Yukseltileceksiniz..",REK,name)
			write_file(file,"",silineceksatir[id])
			
			yetkiliyiyukselt(id)			
		}
		else
		{
					
		
		client_print_color(id,id,"^4[%s] ^3 %s ^4 Yetki Turu Ile Kayit Edileceksiniz...",REK,name)
		
		
		
		}
		
	
	}
	case 2: {
		ShowAdminList(id);
	}
	case 3: {
		Onaylamalistesi(id);	
	}
	case 4: {
		yetkiliekle_tursecimi(id)
	}
	case 5: {
		yonetmenu(id)
	}
	case 6: {
		ShowAdminList(id)
	}
	case 7:{
		oShowAdminList(id)
	}
	case 8:{
		show_motd(id,"CSDYetkiVer/ClanSozlesmesi.txt", "Kayit Oncesi Sartlar")
		g_sozlesme[id] += 1
	}
	case 9:{
		
		
		
		new szLine[248],durum = 0;
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],menutanit[32],ontag[33],sontag[33],g_bakiye[33];
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
			parse(szLine,menutanit,31,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,ontag,32,sontag,32,g_bakiye,32)
			if(!equali(LineName,";") && equali(menutanit,"menu") && equali(LineName,name)) {
				client_print_color(id,id,"[%s] ^3 %s ^4 Yetki Turu Icin^3 %d%s^4 Gerekmektedir.",REK,LineName,g_bakiye,g_bakiyeturu)
				menusdas(id)
				durum = 1
			}
			
		}
		}
		if(!durum){
			client_print_color(id,id,"[%s] ^3 Beklenmedik Hata...!",REK)
			
		}
	}
	}
	
	return PLUGIN_HANDLED
}

public yonetmenu(id){
	
	new message[1000],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yetki Turu Islemleri</h3>^nSizin Icin Tanimlanan Islemler Uzerinde Islem Yapmak Icin Secin..^n")
			
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[1] - Yeni Yetki Turu Ekle</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">[2] - Yetki Turu Sil</h4>^n")
			
			len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br>Seceneklerin Yanindaki [sayi] tuslari ile secimi tuslayip entere basiniz.</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
		}
	}
	show_motd(id,message,"YETSIS | YETKI TURU ISLEMLERI"); 
	
	client_cmd(id,"messagemode %s",islemkodu[3])
	
	return PLUGIN_HANDLED
	
	
}

public YMainMenu_Handler(id) {

	new data[6]
	read_args(data,5)
	remove_quotes(data)
	new secenek = str_to_num(data)
	switch(secenek){
	case 1:{
		
		YeniYetki_Giris[id] = true
		yeniyetki(id)
		

	}
	case 2: {
		
		yetkisil(id)

	}
	}
	
	return PLUGIN_HANDLED
}

public yetkisil(id){
	
		
	new menu = menu_create("\yYetki Turleri \d| \rYONETICI:\d YETKI SIL","YsilMainMenu_Handler")
	
	
	
	
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
			if(!equali(LineName,";") && equali(menutanit,"menu") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineName,linee)
			}
		}
	}
	
	
	
	
	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public YsilMainMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		yetkiliekle(id)
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	
		
	write_file(datafile,"",str_to_num(data))
	client_print_color(id,id,"^4[%s] ^1%s^4 Adli Yetki Ayari Silinmistir.",REK,name)
	yetkisil(id)
	
	return PLUGIN_HANDLED
}





public yeniyetki(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED
	client_print_color(id,id,"^3[%s]^4 Yeni Yetki turu Icin Tur Adi Secin^1 [^3ORN: Slot-1^1]",REK)
	
	
	client_cmd(id,"messagemode yt_adi")
	
	return PLUGIN_HANDLED
	
	
}

public yetkiekle2(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED
		
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(ayar[1],charsmax(ayar),text)
	
	
	client_print_color(id,id,"^3[%s]^1 %s^4 Yeni Yetki turu Icin Verilecek Yetki Secin..^1 [^3ORN: Slot-1 icin bep^1]",REK,ayar[1])
	
	
	YetkiListesi_Yetkituruolustur(id)
	
	
	/*
	client_cmd(id,"messagemode yt_veryetki")*/
	
	return PLUGIN_HANDLED
	
	
}
public YetkiListesi_Yetkituruolustur(id){
	
	new baslik[188]
	formatex(baslik,charsmax(baslik),"\yCSD GELISMIS YETKILI EKLEME SISTEMI \w|\d Yonetici Modu^n\ySecilen Yetkiler:\r %s",SecilenYetkiler[id])
	
	new menu = menu_create(baslik,"YetkiListesi_Handler")
	new secenek[33]
	menu_additem(menu,"\yKaydet Ve Ilerle","kaydet")
	secenek[id] = read_flags("a")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"a") == -1)
			menu_additem(menu,"Kick,slap,ban vs yemesin","a")
	secenek[id] = read_flags("l")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"l") == -1)
			menu_additem(menu,"\rRcon olabilsin*","l")
	secenek[id] = read_flags("b")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"b") == -1)
			menu_additem(menu,"\yServer Rezervasyon","b")
	secenek[id] = read_flags("g")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"g") == -1)
			menu_additem(menu,"\rCvar Kullanabilsin*","g")
	secenek[id] = read_flags("c")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"c") == -1)
			menu_additem(menu,"Oyuncu kickleyebilsin","c")
	secenek[id] = read_flags("h")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"h") == -1)
			menu_additem(menu,"\yCFG Menuyu Kullanabilsin","h")	
	secenek[id] = read_flags("d")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"d") == -1)
			menu_additem(menu,"\rOyuncu Banlayabilsin","d")
	secenek[id] = read_flags("i")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"i") == -1)
			menu_additem(menu,"Tsay,amx_say atabilsin","i")
	secenek[id] = read_flags("e")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"e") == -1)
			menu_additem(menu,"Oyuncu Slay(p)layabilsin","e")
	secenek[id] = read_flags("j")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"j") == -1)
			menu_additem(menu,"Oylama Yapabilsin","j")
	secenek[id] = read_flags("f")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"f") == -1)
			menu_additem(menu,"Harita degistirebilsin","f")
	secenek[id] = read_flags("k")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"k") == -1)
			menu_additem(menu,"\rServera Sifre koyabilsin","k")
	secenek[id] = read_flags("u")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"u") == -1)
			menu_additem(menu,"\yMenuleri kullanabilsin","u")
	secenek[id] = read_flags("m")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"m") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","m")
	secenek[id] = read_flags("n")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"n") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","n")
	secenek[id] = read_flags("o")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"o") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","o")
	secenek[id] = read_flags("p")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"p") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","p")
	secenek[id] = read_flags("r")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"r") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","r")
	secenek[id] = read_flags("s")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"s") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","s")
	secenek[id] = read_flags("t")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"t") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","t")
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
	
	
}
public YetkiListesi_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333]
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,data)) {
		if(equali(data,"kayde")){
			yetkiekle3(id)
			return PLUGIN_HANDLED
		}
		formatex(SecilenYetkiler[id],charsmax(SecilenYetkiler),"%s%s",SecilenYetkiler[id],data)
		client_print_color(id,id,"^3[%s]^4 Sectigin Yetki:^3 %s^1 |^4 Sectiginiz Yetkiler:^3 %s",REK,data,SecilenYetkiler[id])
		YetkiListesi_Yetkituruolustur(id)
		
	}

	
	return PLUGIN_HANDLED
}
public yetkiekle3(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED	

		
	/*new text[64];
	read_args(text,63)
	remove_quotes(text)*/
	copy(ayar[2],charsmax(ayar),SecilenYetkiler[id])
	
	client_print_color(id,id,"^3[%s]^1 %s^4 Yeni Yetki turu Icin Aciklama.^1 [^3ORN: Slot-1 icin b-yesil yazi gibi..^1]",REK,ayar[1])
	
	client_cmd(id,"messagemode yt_aciklama")
	
	
	return PLUGIN_HANDLED
	
}

public yetkiekle4(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED
	
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(ayar[3],charsmax(ayar),text)
	
	client_print_color(id,id,"^3[%s]^1 %s^4Yeni Yetki turu Icin Yeterli Yetki^1 [^3ORN: Slot-1 icin b-a-c Gibi(Tek HARF)..^1]",REK,ayar[1])
	YetkiListesi_Yetkitursecyetki(id)
	//client_cmd(id,"messagemode yt_yetyetki")
	
	return PLUGIN_HANDLED
	
	
}
public YetkiListesi_Yetkitursecyetki(id){
	
	new baslik[188]
	formatex(baslik,charsmax(baslik),"\yCSD GELISMIS YETKILI EKLEME SISTEMI \w|\d Yonetici Modu^n\r%s\w Yetkisini Kimler Verebilsin ?^n\ySecilen Yetkiler:\r %s",ayar[1],SecilenYetkiler[id])
	
	new menu = menu_create(baslik,"YetkiListesisecyetki_Handler")
	new secenek[33]
	SecilenYetkiler[id] = 0
	secenek[id] = read_flags("a")
	menu_additem(menu,"\yKaydet Ve Ilerle","kaydet")
	menu_additem(menu,"Yetkisiz Oyuncu","z")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"a") == -1)
			menu_additem(menu,"Doku Yetkili","a")
	secenek[id] = read_flags("l")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"l") == -1)
			menu_additem(menu,"\rRcon Yetkili*","l")
	secenek[id] = read_flags("b")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"b") == -1)
			menu_additem(menu,"\yServer Rezervasyonlu","b")
	secenek[id] = read_flags("g")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"g") == -1)
			menu_additem(menu,"\rCvar Kullanabilen*","g")
	secenek[id] = read_flags("c")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"c") == -1)
			menu_additem(menu,"Oyuncu kickleyebilen","c")
	secenek[id] = read_flags("h")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"h") == -1)
			menu_additem(menu,"\yCFG Menuyu Kullanabilsin","h")	
	secenek[id] = read_flags("d")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"d") == -1)
			menu_additem(menu,"\rOyuncu Banlayabilsin","d")
	secenek[id] = read_flags("i")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"i") == -1)
			menu_additem(menu,"Tsay,amx_say atabilsin","i")
	secenek[id] = read_flags("e")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"e") == -1)
			menu_additem(menu,"Oyuncu Slay(p)layabilsin","e")
	secenek[id] = read_flags("j")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"j") == -1)
			menu_additem(menu,"Oylama Yapabilsin","j")
	secenek[id] = read_flags("f")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"f") == -1)
			menu_additem(menu,"Harita degistirebilsin","f")
	secenek[id] = read_flags("k")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"k") == -1)
			menu_additem(menu,"\rServera Sifre koyabilsin","k")
	secenek[id] = read_flags("u")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"u") == -1)
			menu_additem(menu,"\yMenuleri kullanabilsin","u")
	secenek[id] = read_flags("m")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"m") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","m")
	secenek[id] = read_flags("n")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"n") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","n")
	secenek[id] = read_flags("o")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"o") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","o")
	secenek[id] = read_flags("p")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"p") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","p")
	secenek[id] = read_flags("r")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"r") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","r")
	secenek[id] = read_flags("s")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"s") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","s")
	secenek[id] = read_flags("t")
	if(get_user_flags(id) & secenek[id])
		if(contain(SecilenYetkiler[id],"t") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","t")
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
	
	
}
public YetkiListesisecyetki_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333]
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"kayde")){ // Duzeltme!
		
		yetkiekle5(id)
		return PLUGIN_HANDLED
	}
	formatex(SecilenYetkiler[id],charsmax(SecilenYetkiler),"%s%s",SecilenYetkiler[id],data)
	client_print_color(id,id,"^3[%s]^4 Sectigin Yetki:^3 %s^1 |^4 Sectiginiz Yetkiler:^3 %s",REK,data,SecilenYetkiler[id])
	YetkiListesi_Yetkitursecyetki(id)
	
		
	

	
	return PLUGIN_HANDLED
}

public yetkiekle5(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED
	
	
	copy(ayar[4],charsmax(ayar),SecilenYetkiler)
	SecilenYetkiler[id] = 0
	client_print_color(id,id,"^3[%s]^1 %s^4 Yeni Yetki turu Icin Yetki Tagi Girin^1 [^3ORN: Slot-1 icin CSD | NICK Gibi..^1]",REK,ayar[1])
	
	client_cmd(id,"messagemode yt_tag")
	
	
	return PLUGIN_HANDLED
	
}

public yetkiekle6(id){
	if(YeniYetki_Giris[id] == false)
		return PLUGIN_HANDLED
	
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(ayar[5],charsmax(ayar),text)

	client_print_color(id,id,"^3[%s]^1 %s^4 Yeni Yetki turu Icin Yetki Rutbesi Girin^1 [^3ORN: Slot-1 icin CSD | NICK [S-1] Gibi..^1]",REK,ayar[1])
	
	client_cmd(id,"messagemode yt_rutbe")
	
	return PLUGIN_HANDLED
	
	
}

public yetkiekle7(id){
	
	
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(ayar[6],charsmax(ayar),text)
	
	client_print_color(id,id,"^4[%s]^3 Yetki Turu Ayarlaniyor.. ",REK)
	
	if(!YeniYetki_Giris[id]){
		client_cmd(id,"echo GECERSIZ ISTEK")
		client_print_color(id,id,"^4[%s]^3 Tekrar deneyiniz..! ",REK)
		return PLUGIN_HANDLED
	}
	
	client_print_color(id,id,"^3[%s]^1 %s^4 Yeni Yetki turu Icin Yetki Fiyati Girin^1 [^3ORN: Slot-1 icin 1 Gibi TL Gibi Semboller Girmemeniz Gerekmekte^1]",REK,ayar[1])
	client_print_color(id,id,"^3[%s]^4 Eger^1 0^4 Girer Iseniz Yetki Yukseltimi Menusunde Gozukmeyecektir. Ve Yetkiden Bakiye Kesilmez.",REK)
	client_cmd(id,"messagemode yt_fiyati")
	
	
	return PLUGIN_HANDLED
}
public yetkiekle8(id){
	
	if(!YeniYetki_Giris[id]){
		client_cmd(id,"echo GECERSIZ ISTEK")
		client_print_color(id,id,"^4[%s]^3 Tekrar deneyiniz..! ",REK)
		return PLUGIN_HANDLED
	}
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(ayar[7],charsmax(ayar),text)
	
	client_print_color(id,id,"^4[%s]^3 Yetki Turu Ayarlaniyor.. ",REK)
	new szLine[248]
	formatex(szLine,247,"^"menu^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"%d^"^n",ayar[1],ayar[2],ayar[3],ayar[4],ayar[5],ayar[6],ayar[7])
	write_file(datafile,szLine)
	
	client_print_color(id,id,"^4[%s]^3 %s^4 Adli Yetki Turu Basari Ile Kaydedildi..! ",REK,ayar[1])
	YeniYetki_Giris[id] = false 
	Yeniyetkituru_Motd(id)	
	return PLUGIN_HANDLED
	
}
public Yeniyetkituru_Motd(id){

	new message[1500],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">YENI YETKI GRUBU KAYIT BILDIRIMI EKRANI</h3>^nYeni Yetki Grubu Basarili Bir Sekilde Kayit Altina Alinmistir.. Eger Bir Sorun ile Karsilasirsaniz Yoneticilere Basvurunuz.^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">YENI YETKI GRUBU BILGILERI</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetki Turu     </b>: %s</div>^n",ayar[1])
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetki Icerigi  </b>: %s</div>^n",ayar[2])
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkiyi Verecek</b>: %s</div>^n",ayar[4])
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetki Aciklama </b>: %s</div>^n",ayar[3])
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetki Tag/Rutbe</b>: %s/%s</div>^n",ayar[5],ayar[6])
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetki Fiyati   </b>: %d %s</div>^n",ayar[7],g_bakiyeturu)
			len += formatex(message[len],charsmax(message)-len,"<br>Bilgilerinizi unutmayiniz ve saklayiniz.<br>Unutma Gibi Durumlarda Iletisim Adreslerimizden Yoneticiler Ile Iletisim Kurunuz</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">YETSIS | %s | WEBSIS Dev Team 2019 | WEBSIS 2019</footer></body>^n",REK)
						
						
		}
	}
	show_motd(id,message,"Yetkili Sis."); 
	
	
	return PLUGIN_HANDLED
	
}




public mSlot_Nick(id) {
	
	if(!Slot_Nick_Giris[id]){
		client_cmd(id,"echo [%s] Gecersiz Istek!",REK)
		return PLUGIN_HANDLED
	}
	
	
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	if(!text[0]) {
		client_print_color(id,id,"^4[%s] ^3Erisim Engellendi: ^1Nick Kismi Bos Birakilamaz.",REK)
		client_cmd(id,"messagemode SlotNick")
		return PLUGIN_HANDLED
	}
	if(admin_exists(text)) {
		client_print_color(id,id,"^4[%s] ^3Erisim Engellendi: ^1Bu Nickte Zaten Bir Slot Var.",REK)
		client_cmd(id,"messagemode SlotNick")
		return PLUGIN_HANDLED
	}
	

	copy(g_szName[id],31,text)
	Slot_Nick_Giris[id] = false;
	
	new message[1000],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
	if(is_user_connected(i))
	{
	new iName[64]
	get_user_name(i,iName,63)
					
						
	len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
	len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
	len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">Yetkili Olarak Kaydol</h3>^nYetkili olarak kaydolmak icin asagidaki yonergeleri takip etmelisiniz..^n")
			
	len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Kaydolacaginiz Nick : %s</h4>^n",text[0])
	len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">Yetki hesabinizin Sifresini Belirlemek Icin Tuslayin Ve ENTERE Basin..</h4>^n")
			
	len += formatex(message[len],charsmax(message)-len,"<br>CSD Yetkili Sistemi<br></div><div>. </div>^n")
	len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">CSD | %s | 2020 | YETSIS 7</footer></body>^n",REK)
	}
	}
	show_motd(id,message,"YETSIS | Kaydol"); 
	
	Slot_Pw_Giris[id] = true;
	client_cmd(id,"messagemode YetkiSifre")
	client_print_color(id,id,"^4[%s] ^1Yetki Sifresini Giriniz.",REK)
	
	return PLUGIN_HANDLED
}
public mSlot_Nick_steam(id,text[]) {
	
	
	if(!text[0]) {
		client_print_color(id,id,"^4[%s] ^3Erisim Engellendi: ^1Steam ID Cekilemedi",REK)
		return PLUGIN_HANDLED
	}
	if(admin_exists(text)) {
		client_print_color(id,id,"^4[%s] ^3Erisim Engellendi: ^1Bu Hesap Kayitli",REK)
		return PLUGIN_HANDLED
	}
	

	copy(g_szName[id],31,text)
	Slot_Nick_Giris[id] = false;
	
	Slot_Pw_Giris[id] = true;
	
	Slot_Nick_Giris[id] = false;
	Slot_Pw_Giris[id] = true;
	client_cmd(id,"messagemode YetkiSifre")
	client_print_color(id,id,"^4[%s] ^1Yetki Sifresini Giriniz.",REK)
	
	
	return PLUGIN_HANDLED
}
public mSlot_Sifre(id) {
	if(!Slot_Pw_Giris[id]){
		client_cmd(id,"echo [%s] Gecersiz Istek!",REK)
		return PLUGIN_HANDLED
	}
	new text[64];
	read_args(text,63)
	remove_quotes(text)
	copy(sifrem[id],63,text)
	client_print_color(id,id,"^4[%s] ^1Yetki Turu Secilecek Bilgiler :^3 Nick^4 %s ^3PW :^4 %s",REK,g_szName[id],sifrem[id])

	menusdas(id)
	
	
	
	return PLUGIN_HANDLED
	
}

public mSlot_Sifre_steam(id,text[]) {
	
	
	
	copy(sifrem[id],63,text)
	client_print_color(id,id,"^4[%s] ^1Yetki Turu Secilecek Bilgiler :^3 Nick^4 STEAMID ^3PW :^4 STEAMID",REK,g_szName[id],sifrem[id])

	menusdas(id)
	
	
	
	return PLUGIN_HANDLED
	
}


public KullaniciPaneli(id){
	new name[33]
	
	get_user_name(id,name,32)	
	 	
	if(!yetkili_kontrol(name)) {
		client_print_color(id,id,"^4[%s]^3 Kontrol Panelin Devredisi Birakilmis..!",REK)
		client_print_color(id,id,"^4[%s]^3 Nickinin Dogru Oldugundan Emin Ol! Yada Yoneticilere Danisman Gereklidir.^1 Nickin:^4 %s",REK,name)
		return PLUGIN_HANDLED
		
	}
	
	
	yetkidenrutbeye(id,Yetkim[id])
	new baslik[186]
	formatex(baslik,charsmax(baslik),"\rKullanici: \yKontrol Panel^n\yNick:\w %s\d |\y %s:\w %d\d |\yRutben:\w%s |\yBitis:\w%s",name,g_bakiyeturu,bakiye[id],Rutbe[id],BitisTarih[id])
	new menu = menu_create(baslik,"Kullanicpan_handler")
		
	
	menu_additem(menu,"Nick Degistir","1")
	menu_additem(menu,"Sifre Degistir","2")
	
	
	menu_additem(menu,"Yetkilerim^n","5")
	new secenek[33]
	formatex(secenek,32,"\yYetki Yukselt \d | %d %s Ile..^n",bakiye[id],g_bakiyeturu)
	if(get_pcvar_num(bakiyesistemi_cvar))
		menu_additem(menu,secenek,"3")
		
	menu_additem(menu,"\rYetkiyi Sil","4")
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public Kullanicpan_handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
	    client_print_color(id,id,"^4[%s]^3 Yeni Nickinizi Giriniz..!^4 Dikkat bu islem sonucu suanki nickinizin sifresi kaldirilacaktir.",REK)
	    client_print_color(id,id,"^4[%s]^3 UYARI:^4 Nickinizi Klan Tagi Ile Birlikte Girmeniz Gerekecektir.",REK)
	    client_cmd(id,"messagemode YeniNick")
	}
	if(equali(data,"2")) {
	    client_print_color(id,id,"^4[%s]^3 Yeni Sifrenizi Giriniz..!^4 Dikkat bu islem sonucu Serverden^3 ATILACAKSINIZ",REK)
	    client_cmd(id,"messagemode YeniSifre")
	    	
	}
	if(equali(data,"3")) {
	   
	    yetkialmaturu(id)
	    
	    	
	}
	if(equali(data,"4")) {
	    Yetkiiptali(id)	
	    	
	}
	if(equali(data,"5")) {
	    Yetkilistesini_Hazirla(id)	
	    	
	}
	
	

	return PLUGIN_HANDLED
}
public Yetkilistesini_Hazirla(id){
	
	new names[64],durum = 0;
	
	get_user_name(id,names,63)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
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
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(!equali(LineFlag,";") && equali(LineName,names) ) {
			durum = 1
			copy(SecilenYetkiler,charsmax(SecilenYetkiler),LineAccess)
			new baslik[188]
			formatex(baslik,charsmax(baslik),"\yCSD YETSIS 5.0 \w|\d Yetkilerim^n\r%s\w^n\ySuanki Yetkiler:\r %s",names,SecilenYetkiler)
			
			new menu = menu_create(baslik,"Yetkilerim_Handler")
			new secenek[33]
			
			secenek[id] = read_flags("a")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"a") == -1)
			menu_additem(menu,"Doku Yetkili","a")
			secenek[id] = read_flags("l")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"l") == -1)
			menu_additem(menu,"\rRcon Yetkili*","l")
			secenek[id] = read_flags("b")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"b") == -1)
			menu_additem(menu,"\yServer Rezervasyonlu","b")
			secenek[id] = read_flags("g")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"g") == -1)
			menu_additem(menu,"\rCvar Kullanabilen*","g")
			secenek[id] = read_flags("c")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"c") == -1)
			menu_additem(menu,"Oyuncu kickleyebilen","c")
			secenek[id] = read_flags("h")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"h") == -1)
			menu_additem(menu,"\yCFG Menuyu Kullanabilsin","h")	
			secenek[id] = read_flags("d")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"d") == -1)
			menu_additem(menu,"\rOyuncu Banlayabilsin","d")
			secenek[id] = read_flags("i")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"i") == -1)
			menu_additem(menu,"Tsay,amx_say atabilsin","i")
			secenek[id] = read_flags("e")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"e") == -1)
			menu_additem(menu,"Oyuncu Slay(p)layabilsin","e")
			secenek[id] = read_flags("j")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"j") == -1)
			menu_additem(menu,"Oylama Yapabilsin","j")
			secenek[id] = read_flags("f")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"f") == -1)
			menu_additem(menu,"Harita degistirebilsin","f")
			secenek[id] = read_flags("k")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"k") == -1)
			menu_additem(menu,"\rServera Sifre koyabilsin","k")
			secenek[id] = read_flags("u")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"u") == -1)
			menu_additem(menu,"\yMenuleri kullanabilsin","u")
			secenek[id] = read_flags("m")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"m") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","m")
			secenek[id] = read_flags("n")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"n") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","n")
			secenek[id] = read_flags("o")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"o") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","o")
			secenek[id] = read_flags("p")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"p") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","p")
			secenek[id] = read_flags("r")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"r") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","r")
			secenek[id] = read_flags("s")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"s") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","s")
			secenek[id] = read_flags("t")
			if(get_user_flags(id) & secenek[id])
			if(contain(SecilenYetkiler[id],"t") == -1)
			menu_additem(menu,"Ekstra eklentiler(amx_super vb eklentiler)","t")
			menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
			menu_display(id,menu,0)	
			
		}
		
	}
	}
	if(!durum){
		client_print_color(id,id,"^4[%s]^3 Yetkilerin Cekilirken Bir sorun olustu..!",REK)
		durum = 0
	}
	return PLUGIN_HANDLED	
	
	
}
public Yetkilerim_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		KullaniciPaneli(id)
		

		return PLUGIN_HANDLED
	}
	new data[6],name[333]
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	Yetkilistesini_Hazirla(id)





	return PLUGIN_HANDLED
}
public yetkialmaturu(id){
	
	
	new menu = menu_create("\rYETSIS: \yYetkiyi Nasil Alacaksin?","yetkialma_Handler")

	//menu_additem(menu,"\yAyri Hesap Tanimla","1") // YAKINDA
	menu_additem(menu,"\wBu Nick Hesabina Tanimla","2")

	
	
	

	
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}

public yetkialma_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
		Slot_Nick_Giris[id] = true;
		yetkisecmeturu[id] = 1
		yetkiyiyukselt[id] = 1
		client_print_color(id,id,"^4[%s] ^3Yetki Icin Yetki Nickini Giriniz.",REK)
		client_print_color(id,id,"^4[%s] ^3Eger Kayit olursaniz Ekranda Cikmis olan Klan kurallarini Kabul Etmis olursunuz..!",REK)
		
		client_cmd(id,"messagemode YetkiNicki")
	    
	}
	if(equali(data,"2")) {
		
		client_print_color(id,id,"^4[%s] ^3Bakiyenize Gore Alabileceginiz Yetkiler Listelenmekte..",REK)
		yetkisecmeturu[id] = 1
		
		new names[33],durum = 0;
		
		get_user_name(id,names,32)
		
		
		new szLine[248];
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_Bakiye[33];
		new maxlines,txtlen,linee[6];
		maxlines = file_size(file,1);
		for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_Bakiye,32)
			if(!equali(LineName,";") && equali(LineName,names))  {
				num_to_str(line,linee,5)
				silineceksatir[id] = line
				//write_file(file,"",str_to_num(linee))
				copy(g_szName,charsmax(g_szName),names)
				copy(sifrem,charsmax(sifrem),LinePW)
				copy(Bakiyem,charsmax(Bakiyem),g_Bakiye)
				//copy(yukseltilecekyetki,charsmax(yukseltilecekyetki),LineAccess)
				menusdas(id)
				yetkiyiyukselt[id] = 1
				durum = 1
				
			}
		}
		}
		if(!durum){
			client_print_color(id,id,"^4[%s] ^3Yetki Yukseltim Islemi Sirasinda Hata Olustu..!Nick: %s",REK,names)
			durum = 0
		}
	
	}
	return PLUGIN_HANDLED
}


public yetkiliyiyukselt(id){
		
	new yeniyetki[188]
	
	formatex(yeniyetki,charsmax(yeniyetki),"^"%s^" ^"%s^" ^"%s^" ^"a^" ^"%d^" ^"0^" // Tur : Otomatik Yazim : YetkiSatisi^n ",g_szName,sifrem,yukseltilecekyetki,bakiye[id])

	write_file(file,yeniyetki,silineceksatir[id])
	server_cmd("amx_reloadadmins")
	client_print_color(id,id,"^4[%s] ^3Yetkiniz Guncellenmistir.!",REK)
	yetkisecmeturu[id] = 0
	yetkiyiyukselt[id] = 0
	return PLUGIN_HANDLED
	
}


public Yetkiiptali(id){
	client_print_color(id,id,"^4[%s]^1 UYARI:^3 BU ISLEM SUNUCUDAKI YETKINIZI VE BAKIYE VERISINI SILECEKTIR.",REK)

	new menu = menu_create("\rKullanici: \yYetki Sil^n\yYetki Gercekten Silinsin mi ?^n\w Bu Islem Yetkinizi Ve Bakiyenizi Silecektir.!","Yetkiiptal_Handler")

	menu_additem(menu,"\rEvet Silinsin.","1")
	menu_additem(menu,"\yHayir Silinmesin.","2")

	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
}
public Yetkiiptal_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		
		return PLUGIN_HANDLED
	}
	new data[6],name[333];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,332,callback)

	if(equali(data,"1")) {
		new names[33];
		
		get_user_name(id,names,32)	
		
		new szLine[248],durum = 0;
		new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
		new maxlines,txtlen,linee[6];
		maxlines = file_size(file,1);
		for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && equali(LineName,names) ) {
				num_to_str(line,linee,5)
				write_file(file,"",str_to_num(linee))
				server_cmd("amx_reloadadmins")
				durum = 1
				client_print_color(id,id,"^4[%s]^4 Yetkiniz Ve Bakiyeniz Iptal Edilmistir.!",REK)
				client_print_color(id,id,"^4[%s]^4 Tekrardan Yetkili Olmak Icin Say'a^3 /yetsis^4 Yazabilirsiniz.",REK)
			}
		
		}
		}
		if(!durum){
			client_print_color(id,id,"^4[%s]^3 HATA:^4 Yetkili Listesinde Yetkiniz Bulunamadi.",REK)
			client_print_color(id,id,"^4[%s]^1 BILGILENDIRME:^4 Yetkiniz Oldugu Halde Bu hata ile karsilasiyor iseniz yoneticiye danisiniz..",REK)
			durum = 0
			
		}
	    
	}
	if(equali(data,"2")) {
		client_print_color(id,id,"^4[%s]^3 Yetki Iptali Islemleri Durdurulmustur.!",REK)
	    	
	}

	return PLUGIN_HANDLED
}

public SifreDegistir(id){
	
	new text[64],name[33];
	get_user_name(id,name,32)
	read_args(text,63)
	remove_quotes(text)
	// Sifre Devam ----->
	
	new szLine[248],durum = 0;
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_uyari[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		g_uyari[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && equali(LineName,name) ) {
				num_to_str(line,linee,5)
				durum = 1
				write_file(file,"",str_to_num(linee))
				new yeniyetki[188]
				formatex(yeniyetki,charsmax(yeniyetki),"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%d^" ^"%s^" // Tur : Otomatik Yazim : KontrolPanel^n ",LineName,text,LineAccess,LineFlag,bakiye[id],g_uyari)
				write_file(file,yeniyetki,str_to_num(linee))
				if(is_user_connected(id)){
					client_print_color(id,id,"^4[%s]^3 Yeni Sifreniz :^4 %s",REK,text)
					client_print_color(id,id,"^4[%s]^4 Eger Yanlis pw Sonucu Atilmadi Iseniz Konsoldan Yenisini Giriniz.",REK)
				
				}
			}
			
		}
	}
	if(!durum){
		client_print_color(id,id,"^4[%s]^3 HATA:^4 Yetkili Listesinde Yetkiniz Bulunamadi.",REK)
		client_print_color(id,id,"^4[%s]^1 BILGILENDIRME:^4 Yetkiniz Oldugu Halde Bu hata ile karsilasiyor iseniz yoneticiye danisiniz..",REK)
		durum = 0
	}

	return PLUGIN_HANDLED	
}
public pubfix(){} // pubfixer



public ShowAdminList(id) {
	new menu = menu_create("\rYonetici: \yYetkili Sil","DeleteAdminMenu_Handler")
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineName,linee,ADMYETKI[ADMINMENUYETKISI])
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	
	
}
public DeleteAdminMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		yetkiliekle(id)
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[64];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,63,callback)
	write_file(file,"",str_to_num(data))
	client_print_color(id,id,"[%s] ^1Yetkili Basariyla Silindi ! ^4Nick: ^3%s",REK,name)
	ShowAdminList(id)
	return PLUGIN_HANDLED
}

public oShowAdminList(id) {
	new menu = menu_create("\rYonetici: \y Onaylanmamis Yetkili Sil","oDeleteAdminMenu_Handler")
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(ofile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineName,linee,ADMYETKI[ADMINMENUYETKISI])
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
}
public oDeleteAdminMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		yetkiliekle(id)
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[64];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,63,callback)
	write_file(ofile,"",str_to_num(data))
	client_print_color(id,id,"^4[%s] ^3Yetkili Basariyla Silindi ! ^4Nick: ^3%s",REK,name)
	oShowAdminList(id)
	return PLUGIN_HANDLED
}


//-----------------------------------------------------------------------------------
new pw[64],yetki[64]
public Onaylamalistesi(id) {
	new menu = menu_create("\rYonetici: \y Yetkili Onayla","onaylaAdminMenu_Handler")
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(ofile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(ofile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") ) {
				num_to_str(line,linee,5)
				menu_additem(menu,LineName,linee,ONAYLAYETKI[ADMINMENUYETKISI])
			}
		}
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
}
public onaylaAdminMenu_Handler(id,menu,item) {
	if(item == MENU_EXIT) {
		yetkiliekle(id)
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	new data[6],name[64];
	new access,callback;
	menu_item_getinfo(menu,item,access,data,5,name,63,callback)
	
	
	new filter[333]
	format(filter,charsmax(filter),name)
	
	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
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
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") && equali(LineName,filter) ) {
				
				copy(pw[id],63,LinePW)
				copy(yetki[id],63,LineAccess)
				write_file(ofile,"",str_to_num(data))
	
				if(get_pcvar_num(bakiyesistemi_cvar))
					formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%d^" ^"0^" // Tur : Otomatik Yazim : Onaylandi^n ",name,pw[id],yetki[id],LineFlag,get_pcvar_num(ilkbakiye_cvar))
	
				if(!get_pcvar_num(bakiyesistemi_cvar))
					formatex(szLine,247,"^"%s^" ^"%s^" ^"%s^" ^"%s^" ^"0^" ^"0^" // Tur : Otomatik Yazim : Onaylandi^n ",name,pw[id],yetki[id],LineFlag)
	
				write_file(file,szLine)
				Onaylamalistesi(id)
				client_print_color(id,id,"^4[%s] ^1Yetkili Basariyla Onaylandi ! ^4Nick: ^3%s",REK,name)
				
				
			}
		}
	}
	
	
	
	
	
	
	
	
	
	return PLUGIN_HANDLED
}

public NickDegis(id){
	
	new text[64],name[33];
	get_user_name(id,name,32)
	read_args(text,63)
	remove_quotes(text)
	
	if(yetkili_kontrol(text)) {
		client_print_color(id,id,"^4[%s]^3 Istediginiz Nickte Bir Yetkili Var. Tekrar Baska Bir Nick Ile Deneyin...",REK)
		client_cmd(id,"messagemode YeniNick")
		return PLUGIN_HANDLED
	}
	// Nick Devam ----->
	// Nicki Cek
	new szLine[248],durum = 0;
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32],g_bakiye[32],g_uyari[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(file,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(file,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31,g_bakiye,31,g_uyari,31)
			if(equali(LineFlag,"a") && equali(LineName,name) ) {
				num_to_str(line,linee,5)
				durum = 1
				write_file(file,"",str_to_num(linee))
				new yeniyetki[188]
				formatex(yeniyetki,charsmax(yeniyetki),"^"%s^" ^"%s^" ^"%s^" ^"%s^"  ^"%d^" ^"%d^" // Tur : Otomatik Yazim : KontrolPanel^n ",text,LinePW,LineAccess,LineFlag,bakiye[id],g_uyari)
				write_file(file,yeniyetki,line)
				client_print_color(id,id,"^4[%s]^3 Yeni Yetki Nickiniz :^4 %s",REK,text)
				client_print_color(id,id,"^4[%s]^4 Nickinizi Degistirerek Tekrardan Yetkili olarak Devam Edebilirsiniz.",REK)
			}
			
		}
	}
	if(!durum){
		client_print_color(id,id,"^4[%s]^3 HATA:^4 Yetkili Listesinde Yetkiniz Bulunamadi.",REK)
		client_print_color(id,id,"^4[%s]^1 BILGILENDIRME:^4 Yetkiniz Oldugu Halde Bu hata ile karsilasiyor iseniz yoneticiye danisiniz..",REK)
		durum = 0
			
	}

	return PLUGIN_HANDLED	
	
	
}




public add_slot(id,const Name[],const Pw[],const yetkikodu[],const yetkiaciklamasi[],const taglar[],const tag2[]) {
	new szLine[248]
	
	if(KendineYaz[id]){
	
	KendineYaz[id] = false
	return PLUGIN_HANDLED
	}
	else
	{
	

		

	if(get_pcvar_num(nickendprefix) == 0){

	
		if(get_pcvar_num(g_onay) == 0){
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"a^"  ^"%d^" ^"0^"  // DURUM :AKTIF ",taglar,Name,Pw,yetkikodu,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"a^" ^"0^" ^"0^"  // DURUM :AKTIF ",taglar,Name,Pw,yetkikodu)
			
			write_file(file,szLine)
		}
		else
		{
			formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"a^" // DURUM :DEAKTIF(ONAY BEKLIYOR) ",taglar,Name,Pw,yetkikodu)
			write_file(ofile,szLine)
		}
	}
	else
	{
	
		if(get_pcvar_num(g_onay) == 0){
			if(get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"a^"  ^"%d^"  ^"0^"  // DURUM :ONAY BEKLIYOR",taglar,Name,Pw,yetkikodu,get_pcvar_num(ilkbakiye_cvar))
			if(!get_pcvar_num(bakiyesistemi_cvar))
				formatex(szLine,247,"^"%s %s^" ^"%s^" ^"%s^" ^"a^" ^"0^" ^"0^"  // DURUM :ONAY BEKLIYOR ",taglar,Name,Pw,yetkikodu)
			
			write_file(file,szLine)
		}
		else
		{
			formatex(szLine,247,"^"%s %s %s^" ^"%s^" ^"%s^" ^"a^" ^"0^" ^"0^" // DURUM :DEAKTIF(ONAY BEKLIYOR)",taglar,Name,tag2,Pw,yetkikodu)
			write_file(ofile,szLine)
		}
	
	
	}
	}
	
	g_mapsiniri[0] += 1
	
	
	if(get_pcvar_num(g_onay) == 1)
	{
	
		Slot_Nick_Giris[id] = false;
		Slot_Pw_Giris[id] = false;
		client_print_color(id,id,"^4[%s] ^3Yetkin Basariyla Onaylanacaklar Listesine Eklendi ^4Nick: ^3%s %s %s  ^4PW: ^3%s",REK,taglar,Name,tag2,Pw)
		client_print_color(id,id,"^4[%s] ^3Yetkin Onaylanana Kadar Suanda Belirlenen Yetki (^4%s^3)",REK,yetkikodu)
		
		Yeniyetkili_motd(id,Name,Pw,yetkikodu,taglar,tag2)
		
	}
	else
	{
		Slot_Nick_Giris[id] = false;
		Slot_Pw_Giris[id] = false;
		client_print_color(id,id,"^4[%s] ^1Yetkin Basariyla  Aktiflestirildi ^4Nick: ^3%s %s %s  ^4PW: ^3%s",REK,taglar,Name,tag2,Pw)
		client_print_color(id,id,"^4[%s] ^3Artik Bu Serverin Bir Yetkilisisin..! Kurallara Uymassan Yetkin Silinir..'",REK)
		client_print_color(id,id,"^4[%s] ^3Yetkin:^4%s(%s)^3",REK,yetkikodu,yetkiaciklamasi)
	
		Yeniyetkili_motd(id,Name,Pw,yetkikodu,taglar,tag2)
			
	
	}
	if(get_user_flags(id) & g_menuyetki[GenelMenuAcmaYetkisi]){
		yetkiliekle(id)
	}
	else
	{
		karsilamenu(id)	
	}
	if(yetkisecmeturu[id]){
		yetkisecmeturu[id] = 0
		bakiyekaydet(id)
	}
	return PLUGIN_HANDLED
	

	
	
}

public Yeniyetkili_motd(id,const Name[],const Pw[],const yetkikodu[],const taglar[],const tag2[]){
	new message[1500],len;  
	len = formatex(message,charsmax(message),"<body style=^"background-color: #2B2B2B^">^n");  
	for(new i = 1; i < 12; i++)
	{
		if(is_user_connected(i))
		{
			new iName[64]
			get_user_name(i,iName,63)
					
						
			len += formatex(message[len],charsmax(message)-len,"<header style=^"background-color:#2478A0; color: aliceblue^"><h2 style=^"text-align: center;font-family:Calibri^">%s</h2></header>^n",REK)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color:aliceblue;font-family: Calibri;text-align: center^">^n")
			len += formatex(message[len],charsmax(message)-len,"<h3 style=^"text-align: center^">YENI YETKILI KAYIT BILDIRIMI</h3>^nYeni Yetkili Basarili Bir Sekilde Kayit Altina Alinmistir.. Eger Bir Sorun ile Karsilasirsaniz Yoneticilere Basvurunuz.^n")
			len += formatex(message[len],charsmax(message)-len,"<h4 style=^"background-color:#1D64AF;color: antiquewhite^">YENI YETKILI BILGILERI</h4>^n")
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili Nicki</b>: %s</div>^n",Name)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili PW   </b>: %s</div>^n",Pw)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili Y.Kod</b>: %s</div>^n",yetkikodu)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili Tagi </b>: %s</div>^n",taglar)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili Rutbe</b>: %s</div>^n",tag2)
			len += formatex(message[len],charsmax(message)-len,"<div style=^"background-color: #C1C1C1^"><b>Yetkili Bakiye</b>: %d</div>^n",get_pcvar_num(ilkbakiye_cvar))
			len += formatex(message[len],charsmax(message)-len,"<br>Bilgilerinizi unutmayiniz ve saklayiniz.<br>Unutma Gibi Durumlarda Iletisim Adreslerimizden Yoneticiler Ile Iletisim Kurunuz</div><div>. </div>^n")
			len += formatex(message[len],charsmax(message)-len,"<footer style=^"background-color: #555555; text-align: center;color:aliceblue ;font-family: Calibri^">YETKILI SISTEMI | %s | 2020 | YETSIS 7</footer></body>^n",REK)
						
						
		}
	}
	show_motd(id,message,"YETSIS | SONUC EKRANI"); 
	
	
	return PLUGIN_HANDLED
	
	
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
public yetkidenrutbeye(id,Yetki[]){
	
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
			copy(Rutbe[id],charsmax(Rutbe),LinePW)
			
			return PLUGIN_HANDLED
			 
		}
		
		
		
			
	}
	}
	
	return PLUGIN_HANDLED
	
	
}
public yetkilibilgisicek(id,Nick[]){
	
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
		if(!equali(LineName,";") && equali(LineName,Nick) ) {	
			copy(Yetkim[id],charsmax(Yetkim),LineAccess)
			copy(Uyarim[id],charsmax(Uyarim),g_uyari)
			copy(BaslamaTarihi[id],charsmax(BaslamaTarihi),bastarih)
			copy(BitisTarih[id],charsmax(BitisTarih),bittarih)
			return PLUGIN_HANDLED
		}
		
			
		}
	}
	
	return PLUGIN_HANDLED
	
	
}

public reklam(id){

	client_print_color(id,id,"^4[%s] ^3Clanimiza Katilmak Ve Bedava Yetkili Slotlugu Kapmak icin say'a ^4/yetkiliol^3 Yaziniz..!",REK)
	
}



/*														    WEBSIS DEVELOPER TEAM
**********************************************************************************************************************************************/


