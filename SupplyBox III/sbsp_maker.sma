#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

#define PLUGIN "SupplyBox SubPlugin: SpawnPoint Maker"
#define VERSION "1.0"
#define AUTHOR "Nguyen Son Tung" // ORIGINAL BY SONTUNG0

new const BOXS_URL[] = "%s/supplybox/%s.cfg"
const MAX_BOXS = 128
const MAX_SPAWNS = 128
const MAX_WAYS = 64
const MAX_POINTS = 32
new g_spawns[MAX_SPAWNS][4], g_spawns_r[MAX_SPAWNS][4],
g_boxs[MAX_BOXS][3], g_total_boxs, g_box_edit, g_boxs_r[MAX_SPAWNS][3]
new cache_spr_line
new const color_way_point[3] = {0,255,0}
new const color_point_edit[3] = {162,17,237}

// Task offsets
enum (+= 100)
{
	TASK_SHOW_BOXS = 1000
}
// IDs inside tasks
#define ID_SHOW_BOXS (taskid - TASK_SHOW_BOXS)


//######################################################################
// REG PLUGIN
//######################################################################
public plugin_precache()
{
	cache_spr_line = precache_model("sprites/laserbeam.spr")
}
public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	// Cmd
	register_concmd("supplybox_sp_maker", "menu_main")
	//register_concmd("ww","ww")
}


//######################################################################
// MENU MAIN
//######################################################################
public menu_main(id)
{
	// check is admin
	if (!check_user_admin(id)) return PLUGIN_HANDLED;
	
	// set task show point
	if (task_exists(id+TASK_SHOW_BOXS)) remove_task(id+TASK_SHOW_BOXS)
	set_task(1.0, "task_show_boxs", id+TASK_SHOW_BOXS, _, _, "b")
	
	box_main(id)
	
	return PLUGIN_HANDLED
}

public task_show_boxs(taskid)
{
	new id = ID_SHOW_BOXS
	box_show(id)
}


//######################################################################
// BOX SPAWNS POINTS
//######################################################################
// ===================== BOX MAIN MENU =====================
public box_main(id)
{
	// remove boxs choose
	g_box_edit = -1
	
	// create menu
	new title[64], item_name[5][64]
	format(title, charsmax(title), "[SP Editor] Kutu Merkezleri Kontrol Paneli", LANG_PLAYER, "MENU_BOXS_TITLE", g_total_boxs, MAX_BOXS)
	format(item_name[0], 63, "Ekle")
	format(item_name[1], 63, "Duzenle")
	format(item_name[2], 63, "Kaydet")
	format(item_name[3], 63, "Yukle")
	format(item_name[4], 63, "Sil")

	new mHandleID = menu_create(title, "box_main_handler")
	menu_additem(mHandleID, item_name[0], "add", 0)
	menu_additem(mHandleID, item_name[1], "edit", 0)
	menu_additem(mHandleID, item_name[2], "save", 0)
	menu_additem(mHandleID, item_name[3], "load", 0)
	menu_additem(mHandleID, item_name[4], "del", 0)
	
	menu_additem(mHandleID, "Cikis", "exit", 0)

	menu_display(id, mHandleID, 0)
}
public box_main_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		// destroy menu
		menu_destroy(menu)
		// show menu main
		menu_main(id)
		return;
	}
	
	new itemid[32], itemname[32], access
	menu_item_getinfo(menu, item, access, itemid, charsmax(itemid), itemname, charsmax(itemname), access)
	menu_destroy(menu)
	
	if (equal(itemid, "add"))
	{
		box_create(id)
		return;
	}
	else if (equal(itemid, "edit"))
	{
		// set first value for g_box_edit
		g_box_edit = 0
		box_edit(id)
		return;
	}
	else if (equal(itemid, "save")) box_save()
	else if (equal(itemid, "load")) box_load()
	else if (equal(itemid, "del")) box_del(1)
	else if (equal(itemid, "exit")) 
	{
		if (task_exists(id+TASK_SHOW_BOXS)) remove_task(id+TASK_SHOW_BOXS)
		menu_destroy(menu)
	}
	
	// show main menu
	box_main(id)
}

// ===================== box create =====================
public box_create(id)
{
	// remove boxs choose
	g_box_edit = -1
	
	// create menu
	new title[64], item_name[2][64]
	format(title, charsmax(title), "[SP Editor] Kutularin Atilacagi Noktalar", LANG_PLAYER, "MENU_BOXS_ADD_TITLE", g_total_boxs, MAX_BOXS)
	format(item_name[0], 63, "Bulundugun Yere Koordinasyon Ekle \y[\r%d\y]",g_total_boxs, LANG_PLAYER, "MENU_BOXS_ADD_ITEM_ADD")
	format(item_name[1], 63, "Son Eklenen Koordinasyon Noktasini Sil", LANG_PLAYER, "MENU_BOXS_ADD_ITEM_DEL")

	new mHandleID = menu_create(title, "box_create_handler")
	menu_additem(mHandleID, item_name[0], "add", 0)
	menu_additem(mHandleID, item_name[1], "del", 0)
	menu_display(id, mHandleID, 0)
}
public box_create_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		// destroy menu
		menu_destroy(menu)
		// show menu main
		box_main(id)
		return;
	}
	
	new itemid[32], itemname[32], access
	menu_item_getinfo(menu, item, access, itemid, charsmax(itemid), itemname, charsmax(itemname), access)
	menu_destroy(menu)

	if (equali(itemid, "add")) box_create_add(id)
	else if (equali(itemid, "del")) box_del()

	// return menu create boxs
	box_create(id)
	
	return;
}
box_create_add(id)
{
	// check max points
	if (g_total_boxs>=MAX_BOXS)
	{
		new message[128]
		format(message, charsmax(message), ">x04[[SP Editor]] >x01Uzgunum Kutu ekleme Siniri Doldu", LANG_PLAYER, "NOTICE_MAX_BOXS", MAX_BOXS)
		color_saytext(id, message)
		return;
	}
	
	// add current points
	new Float:originF[3], origin[3]
	pev(id, pev_origin, originF)
	origin[0] = floatround(originF[0])
	origin[1] = floatround(originF[1])
	origin[2] = floatround(originF[2])
	
	if (!is_point(origin) || !box_check_dist(originF))
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Editor] >xMax Yukseklik Asildi.!", LANG_PLAYER, "NOTICE_BOXS_DIST")
		color_saytext(id, message)
		return;
	}
	
	g_boxs[g_total_boxs][0] = origin[0]
	g_boxs[g_total_boxs][1] = origin[1]
	g_boxs[g_total_boxs][2] = origin[2]
	g_total_boxs ++
}

// ===================== box edit =====================
public box_edit(id)
{
	// check total
	if (!g_total_boxs)
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Editor] >x01 Bulunamadi Ilk Once Noktalari Yukleyin.", LANG_PLAYER, "NOTICE_BOXS_NOTVALUE")
		color_saytext(id, message)
		box_main(id)
		return;
	}
	
	// create menu
	new title[64], item_name[4][64]
	format(title, charsmax(title), "[SP Editor] Kutu Noktalarini Duzenle", LANG_PLAYER, "MENU_BOXS_EDIT_TITLE")
	format(item_name[0], 63, "Geri", LANG_PLAYER, "MENU_BOXS_EDIT_ITEM_BACK")
	format(item_name[1], 63, "Ileri", LANG_PLAYER, "MENU_BOXS_EDIT_ITEM_NEXT")
	format(item_name[2], 63, "Duzenle", LANG_PLAYER, "MENU_BOXS_EDIT_ITEM_EDIT")
	format(item_name[3], 63, "Sil", LANG_PLAYER, "MENU_BOXS_EDIT_ITEM_DEL")

	new mHandleID = menu_create(title, "box_edit_handler")
	menu_additem(mHandleID, item_name[0], "back", 0)
	menu_additem(mHandleID, item_name[1], "next", 0)
	menu_additem(mHandleID, item_name[2], "edit", 0)
	menu_additem(mHandleID, item_name[3], "del", 0)
	menu_display(id, mHandleID, 0)
}
public box_edit_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		// destroy menu
		menu_destroy(menu)
		// show menu main
		box_main(id)
		return;
	}
	
	new itemid[32], itemname[32], access
	menu_item_getinfo(menu, item, access, itemid, charsmax(itemid), itemname, charsmax(itemname), access)
	
	if (equal(itemid, "back")) box_edit_back()
	else if (equal(itemid, "next")) box_edit_next()
	else if (equal(itemid, "edit")) box_edit_edit(id, g_box_edit)
	else if (equal(itemid, "del")) box_edit_del(g_box_edit)
	
	menu_destroy(menu)
	
	// return menu
	box_edit(id)
}
box_edit_back()
{
	if (g_box_edit<=0) g_box_edit = g_total_boxs-1
	else g_box_edit --
}
box_edit_next()
{
	if (g_box_edit<0 || g_box_edit>=g_total_boxs-1) g_box_edit = 0
	else g_box_edit ++
}
box_edit_edit(id, point)
{
	// check value
	if (point<0 || point>=g_total_boxs) return;

	// get points
	new Float:originF[3], origin[3]
	pev(id, pev_origin, originF)
	origin[0] = floatround(originF[0])
	origin[1] = floatround(originF[1])
	origin[2] = floatround(originF[2])
	
	// check point
	if (!is_point(origin) || !box_check_dist(originF, point))
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Maker] >x01Sorry. Distance...", LANG_PLAYER, "NOTICE_BOXS_DIST")
		color_saytext(0, message)
		return;
	}
	
	// update
	g_boxs[point][0] = origin[0]
	g_boxs[point][1] = origin[1]
	g_boxs[point][2] = origin[2]
}
box_edit_del(box)
{
	// check value
	if (box<0 || box>=g_total_boxs) return;
	
	// del box point
	new box_r[3]
	g_boxs[box] = box_r
	
	// create g_boxs_r
	reset_box(1)
	new total_s, point[3]
	for (new i=0; i<g_total_boxs; i++)
	{
		point[0] = g_boxs[i][0]
		point[1] = g_boxs[i][1]
		point[2] = g_boxs[i][2]
		if (is_point(point))
		{
			g_boxs_r[total_s][0] = point[0]
			g_boxs_r[total_s][1] = point[1]
			g_boxs_r[total_s][2] = point[2]
			total_s ++
		}
	}
	
	// update g_boxs
	box_del(1)
	for (new s=0; s<total_s; s++)
	{
		g_boxs[s][0] = g_boxs_r[s][0]
		g_boxs[s][1] = g_boxs_r[s][1]
		g_boxs[s][2] = g_boxs_r[s][2]
	}
	g_total_boxs = total_s
	if (box) g_box_edit = box-1
}

// ===================== box save =====================
box_save()
{
	// check total
	if (!g_total_boxs)
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Editor] >x01 Kaydetmeden Once Bolgeler Olusturun.!", LANG_PLAYER, "NOTICE_BOXS_NOTVALUE")
		color_saytext(0, message)
		return;
	}

	// get url file
	new cfgdir[32], mapname[32], urlfile[64]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(urlfile, charsmax(urlfile), BOXS_URL, cfgdir, mapname)

	// save file
	if (file_exists(urlfile)) delete_file(urlfile)
	new lineset[128]
	for (new i=0; i<g_total_boxs; i++)
	{
		if (!g_boxs[i][0] && !g_boxs[i][1] && !g_boxs[i][2]) break;
		
		format(lineset, charsmax(lineset), "%i %i %i", g_boxs[i][0], g_boxs[i][1], g_boxs[i][2])
		write_file(urlfile, lineset, i)
	}
	
	// show notice
	new message[128]
	format(message, charsmax(message), ">x04[SP Editor] >x01 Kaydedildi.!", LANG_PLAYER, "NOTICE_SAVEBOX_COMPLETE")
	color_saytext(0, message)
}

// ===================== box load =====================
box_load()
{
	// Check for boxs points of the current map
	new cfgdir[32], mapname[32], filepath[100], linedata[64], point[3]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(filepath, charsmax(filepath), BOXS_URL, cfgdir, mapname)
	
	// check file exit
	if (!file_exists(filepath))
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Maker] >x01 Dosya Bulunamadi.!", LANG_PLAYER, "NOTICE_FILE_EXIT", filepath)
		color_saytext(0, message)
		return;
	}
	
	// first reset value
	reset_box()
	
	// Load boxs points
	new file = fopen(filepath,"rt"), row[3][6]
	while (file && !feof(file))
	{
		fgets(file, linedata, charsmax(linedata))
		
		// invalid box
		if(!linedata[0] || str_count(linedata,' ') < 2) continue;
		
		// get box point data
		parse(linedata,row[0],5,row[1],5,row[2],5)
		
		// set boxst
		point[0] = str_to_num(row[0])
		point[1] = str_to_num(row[1])
		point[2] = str_to_num(row[2])
		if (is_point(point))
		{
			g_boxs[g_total_boxs][0] = point[0]
			g_boxs[g_total_boxs][1] = point[1]
			g_boxs[g_total_boxs][2] = point[2]
	
			// increase box count
			g_total_boxs ++
			if (g_total_boxs>=MAX_BOXS) break;
		}
	}
	if (file) fclose(file)
	
	// notice
	if (g_total_boxs)
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Maker] >x01 Yukleme Tamamlandi", LANG_PLAYER, "NOTICE_LOADBOX_COMPLETE", g_total_boxs)
		color_saytext(0, message)
	}
}

// ===================== box del all =====================
box_del(all=0)
{
	// check total
	if (!g_total_boxs)
	{
		new message[128]
		format(message, charsmax(message), ">x04[SP Maker] >x01 Silinecek Kutu Bulunamadi.!", LANG_PLAYER, "NOTICE_BOXS_NOTVALUE")
		color_saytext(0, message)
		return;
	}
	
	// del all
	if (all)
	{
		reset_box()
	}
	// del newest points
	else
	{
		static reset[3]
		g_total_boxs --
		g_boxs[g_total_boxs] = reset
	}
}

// ===================== other function =====================
box_show(id)
{
	if (!g_total_boxs) return;
	
	new color[3], start[3], end[3]
	for (new i=0; i<g_total_boxs; i++)
	{
		if (i==g_box_edit) color = color_point_edit
		else color = color_way_point
		start[0] = g_boxs[i][0]
		start[1] = g_boxs[i][1]
		start[2] = g_boxs[i][2]
		if (!is_point(start)) return;
		end = start
		start[2] -= 36
		end[2] += 36

		create_line_point(id, start, end, color)
	}
}
box_check_dist(Float:origin[3], point=-1)
{
	new Float:originE[3], Float:origin1[3], Float:origin2[3]
	
	for (new i=0; i<g_total_boxs; i++)
	{
		if (i==point) continue;
		
		originE[0] = float(g_boxs[i][0])
		originE[1] = float(g_boxs[i][1])
		originE[2] = float(g_boxs[i][2])
		
		// xoy
		origin1 = origin
		origin2 = originE
		origin1[2] = origin2[2] = 0.0
		if (vector_distance(origin1, origin2)<=2*16.0) return 0;
	}

	return 1;
}



//######################################################################
// FUNCTION MAIN
//######################################################################
reset_box(t=0)
{
	for (new s=0; s<MAX_BOXS; s++)
	{
		for (new i=0; i<3; i++)
		{
			if (t) g_spawns_r[s][i] = 0
			else g_spawns[s][i] = 0
		}
	}
}
is_point(point[3])
{
	if (!point[0] && !point[1] && !point[2]) return 0
	return 1
}
create_line_point(id, const start[3], const end[3], const color[3])
{
	if (!is_user_connected(id)) return;
	
	message_begin(MSG_ONE, SVC_TEMPENTITY, {0,0,0}, id)
	write_byte(TE_BEAMPOINTS)	// temp entity event
	write_coord(start[0])		// startposition: x
	write_coord(start[1])		// startposition: y
	write_coord(start[2])		// startposition: z
	write_coord(end[0])		// endposition: x
	write_coord(end[1])		// endposition: y
	write_coord(end[2])		// endposition: z
	write_short(cache_spr_line)	// sprite index
	write_byte(0)			// start frame
	write_byte(0)			// framerate
	write_byte(10)			// life in 0.1's
	write_byte(15)			// line width in 0.1's
	write_byte(0)			// noise amplitude in 0.01's
	write_byte(color[0])		// color: red
	write_byte(color[1])		// color: green
	write_byte(color[2])		// color: blue
	write_byte(200)			// brightness
	write_byte(0)			// scroll speed in 0.1's
	message_end()
}
color_saytext(player, const message[], any:...)
{
	new text[256]
	format(text, charsmax(text), "%s",message)
	format(text, charsmax(text), "%s",check_text(text))
	
	new dest
	if (player) dest = MSG_ONE
	else dest = MSG_ALL
	
	message_begin(dest, get_user_msgid("SayText"), {0,0,0}, player)
	write_byte(1)
	write_string(text)
	message_end()
}
check_text(text1[])
{
	new text[256]
	format(text, charsmax(text), "%s", text1)
	
	replace_all(text, charsmax(text), ">x04", "^x04")
	replace_all(text, charsmax(text), ">x03", "^x03")
	replace_all(text, charsmax(text), ">x01", "^x01")

	return text
}
check_user_admin(id)
{
	if (get_user_flags(id) & ADMIN_KICK) return 1
	return 0;
}
str_count(const str[], searchchar)
{
	new count, i, len = strlen(str)
	
	for (i = 0; i <= len; i++)
	{
		if(str[i] == searchchar)
			count++
	}
	
	return count;
}
