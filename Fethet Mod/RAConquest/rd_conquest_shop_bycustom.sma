/*
OciXCrom's Custom Shop
The shop contains the following items (by default):

[a] +50 Health -- Gives you +50 health points
[b] +100 Armor -- Gives you +100 armor points
[c] Unlimited Clip -- Makes your current weapon have unlimited bullets (without reloading). This item can only be activated on a weapon that actually uses bullets, reloading will remove the unlimited clip
[d] Unlimited Ammo -- Adds unlimited backpack ammo to your current weapon
[e] All Grenades -- Gives you HE Grenade, 2x Flashbang and a Smoke Grenade
[f] Bomber -- Gives you 20 HE Grenades
[g] Silent Footsteps -- You won't make noise when running
[h] Faster Speed -- Makes you run faster
[i] Low Gravity -- Allows you to jump higher
[j] Chameleon -- Use this item to fool your enemies by disguising as them
[k] Drugs (Speed + Health) -- Distorts your screen, makes you run faster and gives you additional health. The distortion is lost when zooming in
[l] Transparency -- Makes you transparent
[m] Invisibility (15 Seconds) -- Buying this will make you fully invisible for 15 seconds
[n] Double Damage -- Doubles the damage you make on an enemy player
[o] GodMode (5 Seconds) -- Become immortal for 5 seconds
[p] Health Regeneration -- Regenerates 1 health point each half of a second
[q] Armor Regeneration -- Regenerates 10 armor points each half of a second
[r] No Recoil -- Removes weapon recoil
[s] AWP -- Gives you an AWP
[t] Golden AK -- Get an Golden AK-47

Every single item can be disabled and modified by using various cvars.
To disable any item, you can use the cvar "customshop_disableditems", add the item's letter in the cvar string to disable it.

Use these cvars to control the main options of the Shop:

* customshop_disableditems <any available item letter (case sensitive)> -- Leave it empty if you want all items to be enabled
* customshop_viponly <default: 0> -- Set to "1" if you want the Shop to be available only for players with a certain flag
* customshop_flag_access <default: b> -- The flag which is used when "customshop_viponly" is set to "1"
* customshop_infomessage_enabled <default: 1> -- Enable/Disable information message showing in chat
* customshop_infomessage_time <default: 90.0> -- Controls the time needed (in seconds) for the information message to display in chat
* customshop_buyequip <default: 1> -- Use "0" if you don't want the shop to be accessed by using the "buyequip" command (or button "o" by default)
* customshop_currency_symbol <default: $ / Pts.> -- Set the currency symbol that is shown in the shop menu
* customshop_teamonly <default: 0> -- Use this to make the shop available only for a certain team (0 = None; 1 = T; 2 = CT; 3 = Spectator)

Cvars for the Points System:

* customshop_points <default: 0> -- Set to "1" if you want to use special points, instead of money
* customshop_savepoints <default: 1> -- Controls whether the plugin will save players' points on disconnect
* customshop_vipbonus <default: 0> -- Set to "1" if you want VIP users to get more points with every kill
* customshop_flag_bonus <default: b> -- The flag which is used when "customshop_vipbonus" is set to "1"
* customshop_teamkillpoints <default: 0> -- If you want players to get points when killing a teammate
* customshop_killmessage <default: 1> -- Use "0" to disable the kill messages in chat
* customshop_reward_normal <default: 15> -- Controls how many points you get for a normal kill
* customshop_reward_headshot <default: 30> -- Controls how many points you get for a headshot
* customshop_reward_knife <default: 50> -- Controls how many points you get for a knife kill
* customshop_reward_bonus <default: 10> -- Controls how many bonus points VIP users get if "customshop_vipbonus" is set to "1"
* customshop_hud <default: 0> -- Use "1" to show the player's points on his HUD
* customshop_hud_red <default: 255> -- HUD: red color amount
* customshop_hud_green <default: 255> -- HUD: green color amount
* customshop_hud_blue <default: 0> -- HUD: blue color amount
* customshop_hud_x <default: 0.01> -- HUD: X coordinates
* customshop_hud_y <default: 0.93> -- HUD: Y coordinates

Commands:

* say /shop -- Opens up the Shop Menu
* say /points -- Shows the player his current points status
* amx_points <nick|#userid|@team> <points to give/take> -- An admin command to give or take points, you can use "0" to take all points from the player

You can change any item's price by using the following cvars:

[a] customshop_health_price <default: 1500>
[b] customshop_armor_price <default: 1000>
[c] customshop_unlclip_price <default: 3000>
[d] customshop_unlammo_price <default: 200>
[e] customshop_allgrenades_price <default: 800>
[f] customshop_bomber_price <default: 1600>
[g] customshop_silentsteps_price <default: 3000>
[h] customshop_fasterspeed_price <default: 4300>
[i] customshop_lowgravity_price <default: 2800>
[j] customshop_chameleon_price <default: 9000>
[k] customshop_drugs_price <default: 8000>
[l] customshop_transparency_price <default: 2500>
[m] customshop_invisibility_price <default: 16000>
[n] customshop_doubledamage_price <default: 10000>
[o] customshop_godmode_price <default: 16000>
[p] customshop_healthregen_price <default: 1800>
[q] customshop_armorregen_price <default: 2000>
[r] customshop_norecoil_price <default: 12000>
[s] customshop_awp_price <default: 4750>
[t] customshop_goldenak_price <default: 16000>

Note: The cvars above are for the regular Money System, and the other ones are for the Points System.

[a] customshop_health_price2 <default: 150>
[b] customshop_armor_price2 <default: 100>
[c] customshop_unlclip_price2 <default: 300>
[d] customshop_unlammo_price2 <default: 20>
[e] customshop_allgrenades_price2 <default: 80>
[f] customshop_bomber_price2 <default: 160>
[g] customshop_silentsteps_price2 <default: 300>
[h] customshop_fasterspeed_price2 <default: 430>
[i] customshop_lowgravity_price2 <default: 280>
[j] customshop_chameleon_price2 <default: 900>
[k] customshop_drugs_price2 <default: 800>
[l] customshop_transparency_price2 <default: 250>
[m] customshop_invisibility_price2 <default: 1600>
[n] customshop_doubledamage_price2 <default: 1000>
[o] customshop_godmode_price2 <default: 1600>
[p] customshop_healthregen_price2 <default: 180>
[q] customshop_armorregen_price2 <default: 200>
[r] customshop_norecoil_price2 <default: 1200>
[s] customshop_awp_price2 <default: 475>
[t] customshop_goldenak_price2 <default: 1600>

Use these cvars to control the item limit:
	
[a] customshop_health_limit <default: 5>
[b] customshop_armor_limit <default: 8>
[c] customshop_unlclip_limit <default: 3>
[d] customshop_unlammo_limit <default: 5>
[e] customshop_allgrenades_limit <default: 10>
[f] customshop_bomber_limit <default: 3>
[g] customshop_silentsteps_limit <default: 1>
[h] customshop_fasterspeed_limit <default: 1>
[i] customshop_lowgravity_limit <default: 1>
[j] customshop_chameleon_limit <default: 1>
[k] customshop_drugs_limit <default: 2>
[l] customshop_transparency_limit <default: 1>
[m] customshop_invisibility_limit <default: 3>
[n] customshop_doubledamage_limit <default: 1>
[o] customshop_godmode_limit <default: 1>
[p] customshop_healthregen_limit <default: 2>
[q] customshop_armorregen_limit <default: 2>
[r] customshop_norecoil_limit <default: 1>
[s] customshop_awp_limit <default: 1>
[t] customshop_goldenak_limit <default: 1>

Other item cvars:

[a] customshop_health_amount <default: 50> -- Controls the health points you get when buying item "a"
[b] customshop_armor_amount <default: 100> -- Controls the armor points you get when buying item "b"
[f] customshop_bomber_amount <default: 20> -- Controls how many HE Grenades you get when buying item "f"
[h] customshop_fasterspeed_amount <default: 300.0> -- Controls the speed boost you get when buying item "h"
[i] customshop_lowgravity_amount <default: 0.5> -- Controls the gravity you get when buying item "i". Be aware that the lower the gravity is, the higher you jump
[k] customshop_drugs_speedamount <default: 300.0> -- Controls the speed boost you get when buying item "k"
[k] customshop_drugs_healthamount <default: 200> -- Controls the health points you get when buying item "k"
[l] customshop_transparency_amount <default: 75> -- Controls the transparency amount when buying item "l". Use a number from 0 to 255, the lower the number, the more transparency you get
[m] customshop_invisibility_time <default: 15.0> -- Controls how many seconds you're invisible when buying item "m"
[o] customshop_godmode_time <default: 5.0> -- Controls how many seconds you're immortal when buying item "o"
[p] customshop_healthregen_amount <default: 1> -- Controls how many health points you get every second when buying item "p"
[p] customshop_healthregen_time <default: 0.5> -- Controls the speed of regeneration when buying item "p"
[p] customshop_healthregen_max <default: 150> -- Controls the maximum amount of regenerated health when buying item "p"
[q] customshop_armorregen_amount <default: 10> -- Controls how many armor points you get every second when buying item "p"
[q] customshop_armorregen_time <default: 0.5> -- Controls the speed of regeneration when buying item "p"
[q] customshop_armorregen_max <default: 150> -- Controls the maximum amount of regenerated armor when buying item "p"
[t] customshop_goldenak_damage <default: 5> -- Controls the the damage multiplier for item "t"
[t] customshop_goldenak_bullets <default: 1> -- Controls whether item "t" will use golden bullets or not
[t] customshop_goldenak_ammo <default: 500> -- Controls how many ammo item "t" has

The plugin also allows you to add a custom sound for every item, check g_itemSounds.
*/

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <nvault>

#define PLUGIN_NAME "RD:Custom Shop"
#define PLUGIN_VERSION "2.2"
#define PLUGIN_AUTHOR "OciXCrom"

#define FLAG_ADMIN ADMIN_RCON
#define MAX_ITEMS 19
#define m_pActiveItem 373

#define sNo "buttons/button11.wav"
#define sOver "buttons/blip2.wav"

#define mGoldenAKp "models/custom_shop/p_goldenak.mdl"
#define mGoldenAKv "models/custom_shop/v_goldenak.mdl"

new const szPrefix[] = "^4[-RD| Market]^3"
new const bnkPrefix[] = "^4[-RD| BANK]^3"

enum Color
{
	NORMAL = 1, // clients scr_concolor cvar color
	GREEN, // Green Color
	TEAM_COLOR, // Red, grey, blue
	GREY, // grey
	RED, // Red
	BLUE, // Blue
}

new TeamName[][] = 
{
	"",
	"TERRORIST",
	"CT",
	"SPECTATOR"
}

new const g_playerModels[][] = {
	"arctic",
	"guerilla",
	"leet",
	"terror",
	"gign",
	"gsg9",
	"sas",
	"urban"
}

new const g_itemSounds[][] = {
	"items/smallmedkit1.wav", // Item "a": +50 Health
	"items/ammopickup2.wav", // Item "b": +50 Armor
	"items/gunpickup2.wav", // Item "c": Unlimited Clip
	"items/gunpickup2.wav", // Item "d": Unlimited Ammo
	"items/gunpickup2.wav", // Item "e": All Grenades
	"x/x_pain2.wav", // Item "f": Bomber
	"items/gunpickup2.wav", // Item "g": Silent Footsteps
	"misc/bipbip.wav", // Item "h": Faster Speed
	"items/gunpickup2.wav", // Item "i": Low Gravity
	"items/gunpickup2.wav", // Item "j": Chameleon
	"items/gunpickup2.wav", // Item "k": Drugs (Speed + Health)
	"items/gunpickup2.wav", // Item "l": Transparency
	"hornet/ag_buzz1.wav", // Item "m": Invisibility (15 Seconds)
	"items/gunpickup2.wav", // Item "n": Double Damage
	"misc/stinger12.wav", // Item "o": GodMode (5 Seconds)
	"items/suitchargeok1.wav", // Item "p": Health Regeneration
	"items/suitchargeok1.wav", // Item "q": Armor Regeneration
	"items/gunpickup2.wav", // Item "r": No Recoil
	"items/gunpickup2.wav", // Item "s": AWP
	"items/gunpickup2.wav" // Item "t": Golden AK
}

new DisabledItems, VIPOnly, VIPBonus, FlagAccess, FlagBonus, gmsg_SetFOV, GoldenBullet
new HealthAmount, HealthPrice, ArmorAmount, ArmorPrice, UnlimitedClipPrice, UnlimitedAmmoPrice, AllGrenadesPrice, BomberPrice, BomberAmount, SilentFootstepsPrice
new FasterSpeedAmount, FasterSpeedPrice, LowGravityAmount, LowGravityPrice, ChameleonPrice, DrugsSpeedAmount, DrugsHealthAmount, DrugsPrice
new TransparencyAmount, TransparencyPrice, InvisibilityTime, InvisibilityPrice, DoubleDamagePrice, GodModeTime, GodModePrice, HealthRegenAmount, HealthRegenTime
new HealthRegenMax, HealthRegenPrice, ArmorRegenAmount, ArmorRegenTime, ArmorRegenMax, ArmorRegenPrice, InfoMessageEnabled, InfoMessageTime, ShopEquip, ShopPoints
new SavePoints, TeamKillPoints, NormalReward, HeadshotReward, KnifeReward, CurrencySymbol, NoRecoilPrice, AWPPrice, TeamOnly
new HealthLimit, ArmorLimit, UnlimitedClipLimit, UnlimitedAmmoLimit, AllGrenadesLimit, BomberLimit, SilentFootstepsLimit, FasterSpeedLimit, LowGravityLimit, ChameleonLimit
new DrugsLimit, TransparencyLimit, InvisibilityLimit, DoubleDamageLimit, GodModeLimit, HealthRegenLimit, ArmorRegenLimit, NoRecoilLimit, AWPLimit, GoldenAKPrice, GoldenAKLimit
new GoldenAKBullets, GoldenAKDamage, GoldenAKAmmo, HUDEnabled, HUDRed, HUDGreen, HUDBlue, HUDX, HUDY, BonusReward
new g_vault, activity, cvar, hudinfo

new weapon[33], points[33], bullets[33]
new userlimit[33][33]

new bool:cshop_speed[33]
new bool:cshop_ddamage[33]
new bool:cshop_healthregen[33]
new bool:cshop_armorregen[33]
new bool:cshop_norecoil[33]
new bool:cshop_goldenak[33]

new bool:use_points

new anavault;
new kredivault;
new username[33][200]
new password[33][200]
new g_username[33][200]
new g_password[33][200]
new k_username[33][200]
new k_password[33][200]
new g_IslemUcreti

new g_banka

new baslik
new g_baslik[1063];

new kupon_cvar

new kupon_kodus[64] = 0
new kupon_hak[64] = 1

new odul
new g_odul[10000];



new kphak
new g_hak[64];


new kayitli_kod
new kayitlikod[64];

new yetkilihak
new g_yetkilihak[64];

new tlsiniri
new g_tlsiniri[64];

new const g_itemLanguage[][] = {
	"CSHOP_HEALTH",
	"CSHOP_ARMOR",
	"CSHOP_UNLCLIP",
	"CSHOP_UNLAMMO",
	"CSHOP_ALLGRENADES",
	"CSHOP_BOMBER",
	"CSHOP_SILENTSTEPS",
	"CSHOP_FASTERSPEED",
	"CSHOP_LOWGRAVITY",
	"CSHOP_CHAMELEON",
	"CSHOP_DRUGS",
	"CSHOP_TRANSPARENCY",
	"CSHOP_INVISIBILITY",
	"CSHOP_DDAMAGE",
	"CSHOP_GODMODE",
	"CSHOP_HEALTHREGEN",
	"CSHOP_ARMORREGEN",
	"CSHOP_NORECOIL",
	"CSHOP_AWP",
	"CSHOP_GOLDENAK"
}

new const kupongirenlerfile[] = "RDConquest/Config/kupongirenler.ini";

public plugin_init()
{
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)
	register_cvar("CustomShop", PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY|FCVAR_UNLOGGED)
	register_dictionary("custom_shop.txt")
	
	register_event("CurWeapon", "change_weapon", "be", "1=1")
	register_event("CurWeapon", "goldenak_bullets", "be", "1=1", "3>0")
	register_event("DeathMsg", "player_killed", "a")
	RegisterHam(Ham_Spawn, "player", "player_spawn", 1)
	RegisterHam(Ham_TakeDamage, "player", "player_damage")
	register_forward(FM_PlayerPreThink, "player_prethink")
	
	register_clcmd("say /market", "cshop_main")
	register_clcmd("say /kuponmenu", "kuponmenusu")
	register_clcmd("kupon_kodus", "kupongirisi")
	register_clcmd("say market", "cshop_main")
	register_clcmd("say_team /market", "cshop_main")
	register_clcmd("say /paralarim", "cmd_points")
	register_clcmd("say_team /paralarim", "cmd_points")
	register_clcmd("say /banka", "login_menusu")
	register_clcmd("say /bank", "login_menusu")
	register_clcmd("say banka", "login_menusu")
	register_clcmd("say bank", "login_menusu")

	
	
	
	
	ShopPoints = register_cvar("customshop_points", "1")
	use_points = (get_pcvar_num(ShopPoints) == 1) ? true : false
	
	DisabledItems = register_cvar("customshop_disableditems", "")
	VIPOnly = register_cvar("customshop_viponly", "0")
	FlagAccess = register_cvar("customshop_flag_access", "l")
	
	g_banka = register_cvar("sv_market_banka","1")

	
	if(use_points)
	{
		VIPBonus = register_cvar("customshop_vipbonus", "1")
		FlagBonus = register_cvar("customshop_flag_bonus", "c")
		HealthPrice = register_cvar("customshop_health_price2", "50") // 150
		ArmorPrice = register_cvar("customshop_armor_price2", "50") // 100
		UnlimitedClipPrice = register_cvar("customshop_unlclip_price2", "100") // 300
		UnlimitedAmmoPrice = register_cvar("customshop_unlammo_price2", "10") // 20
		AllGrenadesPrice = register_cvar("customshop_allgrenades_price2", "50") // 80
		BomberPrice = register_cvar("customshop_bomber_price2", "100") // 190
		SilentFootstepsPrice = register_cvar("customshop_silentsteps_price2", "150") // 300
		FasterSpeedPrice = register_cvar("customshop_fasterspeed_price2", "250") //430
		LowGravityPrice = register_cvar("customshop_lowgravity_price2", "160") // 280
		ChameleonPrice = register_cvar("customshop_chameleon_price2", "445") //900
		DrugsPrice = register_cvar("customshop_drugs_price2", "400") //800
		TransparencyPrice = register_cvar("customshop_transparency_price2", "155") //250
		InvisibilityPrice = register_cvar("customshop_invisibility_price2", "6000") //1600
		DoubleDamagePrice = register_cvar("customshop_doubledamage_price2", "555") //1000
		GodModePrice = register_cvar("customshop_godmode_price2", "5000") //1600
		HealthRegenPrice = register_cvar("customshop_healthregen_price2", "100") //180
		ArmorRegenPrice = register_cvar("customshop_armorregen_price2", "67") //200
		SavePoints = register_cvar("customshop_savepoints", "1")
		TeamKillPoints = register_cvar("customshop_teamkillpoints", "0")
		//KillMessage = register_cvar("customshop_killmessage", "1")
		NormalReward = register_cvar("customshop_reward_normal", "15")
		HeadshotReward = register_cvar("customshop_reward_headshot", "30")
		KnifeReward = register_cvar("customshop_reward_knife", "50")
		CurrencySymbol = register_cvar("customshop_currency_symbol2", "TL")
		NoRecoilPrice = register_cvar("customshop_norecoil_price2", "6000") //1200
		AWPPrice = register_cvar("customshop_awp_price2", "475")
		GoldenAKPrice = register_cvar("customshop_goldenak_price2", "1000") //1600
		HUDEnabled = register_cvar("customshop_hud", "1")
		HUDRed = register_cvar("customshop_hud_red", "255")
		HUDGreen = register_cvar("customshop_hud_green", "255")
		HUDBlue = register_cvar("customshop_hud_blue", "0")
		HUDX = register_cvar("customshop_hud_x", "0.01")
		HUDY = register_cvar("customshop_hud_y", "0.93")
		BonusReward = register_cvar("customshop_reward_bonus", "10")
		
		register_concmd("amx_paraaver", "cmd_givepoints", ADMIN_RCON, "<nick|#userid|@team> <points to give/take>")
	}
	else
	{
		HealthPrice = register_cvar("customshop_health_price", "1500")
		ArmorPrice = register_cvar("customshop_armor_price", "1000")
		UnlimitedClipPrice = register_cvar("customshop_unlclip_price", "3000")
		UnlimitedAmmoPrice = register_cvar("customshop_unlammo_price", "200")
		AllGrenadesPrice = register_cvar("customshop_allgrenades_price", "800")
		BomberPrice = register_cvar("customshop_bomber_price", "1600")
		SilentFootstepsPrice = register_cvar("customshop_silentsteps_price", "3000")
		FasterSpeedPrice = register_cvar("customshop_fasterspeed_price", "4300")
		LowGravityPrice = register_cvar("customshop_lowgravity_price", "2800")
		ChameleonPrice = register_cvar("customshop_chameleon_price", "9000")
		DrugsPrice = register_cvar("customshop_drugs_price", "8000")
		TransparencyPrice = register_cvar("customshop_transparency_price", "2500")
		InvisibilityPrice = register_cvar("customshop_invisibility_price", "16000")
		DoubleDamagePrice = register_cvar("customshop_doubledamage_price", "10000")
		GodModePrice = register_cvar("customshop_godmode_price", "16000")
		HealthRegenPrice = register_cvar("customshop_healthregen_price", "1800")
		ArmorRegenPrice = register_cvar("customshop_armorregen_price", "2000")
		CurrencySymbol = register_cvar("customshop_currency_symbol", "$")
		NoRecoilPrice = register_cvar("customshop_norecoil_price", "12000")
		AWPPrice = register_cvar("customshop_awp_price", "4750")
		GoldenAKPrice = register_cvar("customshop_goldenak_price", "16000")
	}
	
	HealthAmount = register_cvar("customshop_health_amount", "50")
	ArmorAmount = register_cvar("customshop_armor_amount", "100")
	BomberAmount = register_cvar("customshop_bomber_amount", "20")
	FasterSpeedAmount = register_cvar("customshop_fasterspeed_amount", "300.0")
	LowGravityAmount = register_cvar("customshop_lowgravity_amount", "0.5")
	DrugsSpeedAmount = register_cvar("customshop_drugs_speedamount", "300.0")
	DrugsHealthAmount = register_cvar("customshop_drugs_healthamount", "200")
	TransparencyAmount = register_cvar("customshop_transparency_amount", "75")
	InvisibilityTime = register_cvar("customshop_invisibility_time", "15.0")
	GodModeTime = register_cvar("customshop_godmode_time", "5.0")
	HealthRegenAmount = register_cvar("customshop_healthregen_amount", "1")
	HealthRegenTime = register_cvar("customshop_healthregen_time", "0.5")
	HealthRegenMax = register_cvar("customshop_healthregen_max", "150")
	ArmorRegenAmount = register_cvar("customshop_armorregen_amount", "10")
	ArmorRegenTime = register_cvar("customshop_armorregen_time", "0.5")
	ArmorRegenMax = register_cvar("customshop_armorregen_max", "150")
	InfoMessageEnabled = register_cvar("customshop_infomessage_enabled", "1")
	InfoMessageTime = register_cvar("customshop_infomessage_time", "90.0")
	ShopEquip = register_cvar("customshop_buyequip", "1")
	TeamOnly = register_cvar("customshop_teamonly", "0")
	
	HealthLimit = register_cvar("customshop_health_limit", "2")
	ArmorLimit = register_cvar("customshop_armor_limit", "8")
	UnlimitedClipLimit = register_cvar("customshop_unlclip_limit", "3")
	UnlimitedAmmoLimit = register_cvar("customshop_unlammo_limit", "5")
	AllGrenadesLimit = register_cvar("customshop_allgrenades_limit", "10")
	BomberLimit = register_cvar("customshop_bomber_limit", "3")
	SilentFootstepsLimit = register_cvar("customshop_silentsteps_limit", "1")
	FasterSpeedLimit = register_cvar("customshop_fasterspeed_limit", "1")
	LowGravityLimit = register_cvar("customshop_lowgravity_limit", "1")
	ChameleonLimit = register_cvar("customshop_chameleon_limit", "1")
	DrugsLimit = register_cvar("customshop_drugs_limit", "2")
	TransparencyLimit = register_cvar("customshop_transparency_limit", "1")
	InvisibilityLimit = register_cvar("customshop_invisibility_limit", "3")
	DoubleDamageLimit = register_cvar("customshop_doubledamage_limit", "1")
	GodModeLimit = register_cvar("customshop_godmode_limit", "1")
	HealthRegenLimit = register_cvar("customshop_healthregen_limit", "2")
	ArmorRegenLimit = register_cvar("customshop_armorregen_limit", "2")
	NoRecoilLimit = register_cvar("customshop_norecoil_limit", "1")
	AWPLimit = register_cvar("customshop_awp_limit", "1")
	GoldenAKLimit = register_cvar("customshop_goldenak_limit", "1")
	GoldenAKBullets = register_cvar("customshop_goldenak_bullets", "1")
	GoldenAKDamage = register_cvar("customshop_goldenak_damage", "5")
	GoldenAKAmmo = register_cvar("customshop_goldenak_ammo", "500")

	baslik = register_cvar("market_baslik","\yHaftanin Hediyesini Almak icin Say'a\r /kuponmenu \yYaziniz.")
	get_pcvar_string(baslik,g_baslik,1062)
	
	kupon_cvar = register_cvar("market_kupon","1")
	odul = register_cvar("market_kupon_odul","25000")
	get_pcvar_string(odul,g_odul,99999)
	kayitli_kod = register_cvar("market_kupon_kodus","20161221")
	get_pcvar_string(kayitli_kod,kayitlikod,63)
	kphak = register_cvar("market_kupon_hak","1")
	get_pcvar_string(kphak,g_hak,63)
	
	yetkilihak = register_cvar("market_yetkilihak","3")
	tlsiniri = register_cvar("market_tlsiniri","50000")
	get_pcvar_string(tlsiniri,g_tlsiniri,63)
	
	if(get_pcvar_num(kupon_cvar) == 1){
		set_task(290.0,"kupon_reklam",_,_,_,"b")
	
	}
	
	
	
	
	if(get_pcvar_num(ShopEquip) == 1) register_clcmd("buyequip", "cshop_main")
	if(get_pcvar_num(InfoMessageEnabled) == 1) set_task(get_pcvar_float(InfoMessageTime), "infoMessage", 1111, "", 0, "b", 0)
	
	gmsg_SetFOV = get_user_msgid("SetFOV")
	g_vault = nvault_open("rdparalar")

	activity = get_pcvar_num(get_cvar_pointer("amx_show_activity"))
	hudinfo = CreateHudSyncObj()

	g_IslemUcreti = register_cvar("sv_banka_islem_ucreti","5")

	return PLUGIN_HANDLED
	
	
	
}


public plugin_natives() 
{ 
  
    register_native("rd_cuzdan","native_bakiye",1)
    register_native("rd_paraver","native_paraver")
    register_native("rd_paraal","native_paraal")

}


public native_paraver(id, ammount)
{
	new id = get_param(1);
	new ammount = get_param(2);
	points[id] += ammount
	return 1;
}	
public native_paraal(id, ammount)
{
	new id = get_param(1);
	new ammount = get_param(2);
	points[id] -= ammount
	return 1;
}	

public native_bakiye(id){
	
	return points[id]	
	
	
}






public kupon_reklam(id){
	
	ColorChat( id, NORMAL, " %s %s TL ^4 Odulu Almak icin Say'a^3 /kuponmenu^4 Yazin..!",szPrefix,g_odul)
	ColorChat( id, NORMAL, " %s ^4Eger Kupon Kodunuz Yok Ise^3 www.redarmygaming.org^4 Adresinden Alabilirsiniz.!",szPrefix)
	
	
}
public kupongirisi(id){
	
	
		
	new kupon[64];
	read_args(kupon,63)
	remove_quotes(kupon)
	
	new ip[64];
	get_user_authid(id,ip,63)
	
	if(kayit_kontrol(ip)) {
		ColorChat(id, NORMAL, "^4[%s] ^3MALESEF: ^4Bu Hafta Kupon Hakkinizi Doldurmussunuz.!",szPrefix)
		ColorChat(id, NORMAL, "^4[%s] ^3MAALESEF: ^3Pazartesi Gunu^4 Tekrardan Bekleriz..!",szPrefix)
		return PLUGIN_HANDLED
	}
	
	if(!kayit_kontrol(kupon)) {
		ColorChat( id, NORMAL, " %s Malesef :(^4 Girdiginiz kod verilerimizle uyusmuyor..!",szPrefix)
		ColorChat( id, NORMAL, " %s www.redarmygaming.org^4 Adresinden Dogru Kodu Alabilirsin.!",szPrefix)
		return PLUGIN_HANDLED
	}
	
		
			
	new kuponcuismi[32];
	get_user_name(id, kuponcuismi,31)
		
		
	new szLine[248]
		
	formatex(szLine,247,"^"%s^" ^"%s^"//KUPON KODU ^"%s^"^n",ip,kuponcuismi,kupon)
	write_file(kupongirenlerfile,szLine)
	points[id] += 25000
	kupon_kodus[id] = kupon[id]
		
		
	ColorChat( id, NORMAL, " %s %d TL^4 Market Cuzdaniniza Eklendi..!",szPrefix,g_odul)
	ColorChat( id, NORMAL, " %s Pazartesi Gunu^4 Yeni Kodu almaya Geldiginde Gorusmek Uzere..!",szPrefix)
	

	return PLUGIN_HANDLED
	
}


stock kayit_kontrol(const Name[]) {
	new szLine[248];
	new LineName[32],blabla[32];
	new maxlines,txtlen;
	maxlines = file_size(kupongirenlerfile,1);
	for(new line;line<maxlines;line++) {
		read_file(kupongirenlerfile,line,szLine,247,txtlen)
		parse(szLine,LineName,31,blabla,31)
		if(equali(LineName,Name)) {
			return 1;
		}
	}
	return 0;
}
public kayit_cek(id) {
	
	
	new ip[64];
	get_user_authid(id,ip,63)
	
	if(kayit_kontrol(ip)) {

	
	new szLine[248];
	new LineName[32],LinePW[32],LineAccess[32],LineFlag[32];
	new maxlines,txtlen,linee[6];
	maxlines = file_size(kupongirenlerfile,1);
	for(new line;line<maxlines;line++) {
		szLine[0] = 0;
		LineName[0] = 0;
		LinePW[0] = 0;
		LineAccess[0] = 0;
		LineFlag[0] = 0;
		read_file(kupongirenlerfile,line,szLine,247,txtlen)
		
		if(szLine[0]) {
			parse(szLine,LineName,31,LinePW,31,LineAccess,31,LineFlag,31)
			if(equali(LineFlag,"a") && !equali(LineName,";") ) {
				num_to_str(line,linee,5)
				
				if(!LineName[0]){
					kupon_kodus[id] = kayitlikod[id]
						
				}
				
				
			}
		}
	}
}
	else
	{
		kupon_kodus[id] = 0
}
	return PLUGIN_HANDLED
}

public client_authorized(id){
	
	LoadData(id)
	vip_charge(id)
	return PLUGIN_HANDLED
	
	
	
}

public kuponmenusu(id,level,cid) {
	
	if(get_pcvar_num(kupon_cvar) == 0){
		ColorChat( id, NORMAL, " %s Suanda Kupon Sistemi Bakimda.! Bitirdigimizde Haber Verecegiz.!",szPrefix)

		return PLUGIN_HANDLED
	}
	client_cmd(id,"say /kodmatik")
	
	/*new menu, Menuz[512]/
	formatex(Menuz, charsmax(Menuz), "\rCSDURAGI | MARKET \w| \dHEDIYE KUPONU MENUSU^n\wKupon Kodun : \r%s\d |\w Haftalik Hakkin : \r%s",kupon_kodus[id],g_hak[id])
	menu = menu_create(Menuz, "kuponmenusudevam")
	formatex(Menuz, charsmax(Menuz), "\yKupon Kodu Gir[\r+%s TL\y] \d| Her hafta odulunu almak icin www.redarmygaming.org Adresine gidebilirsin.",g_odul)
	menu_additem(menu, Menuz, "1")
	formatex(Menuz, charsmax(Menuz), "\wKupon Kodu Al \d| Kupon Kodu Her Hafta Yenilenir..!")
	menu_additem(menu, Menuz, "2")
	formatex(Menuz, charsmax(Menuz), "\rwww.redarmygaming.org\y Adresine Tarayicinizla Girip daha ayrintili olarak kodunuzu alabilirsiniz.")
	menu_additem(menu, Menuz, "7")
	formatex(Menuz, charsmax(Menuz), "\yIleri")
	menu_setprop(menu,MPROP_NEXTNAME ,Menuz)
	formatex(Menuz, charsmax(Menuz), "\yGeri")
	menu_setprop(menu,MPROP_BACKNAME ,Menuz)
	menu_setprop(menu,MPROP_EXIT, MEXIT_ALL)
	formatex(Menuz, charsmax(Menuz), "\rKapat")
	
	menu_setprop(menu,MPROP_EXITNAME,Menuz)
	
	menu_display(id, menu, 0)*/
	return PLUGIN_HANDLED;
}

public kuponmenusudevam(id, menu, item) {
	
	if (item == MENU_EXIT)
	{
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
			ColorChat( id, NORMAL, " %s www.redarmygaming.org Adresinden aldiginiz kodu girin.",szPrefix)
			client_cmd(id,"messagemode kupon_kodus")

			

		}
		case 2:
		{
			show_motd(id, "http://redarmygaming.org/kupon-kampanyasi/")
		}
	
	
}

	return PLUGIN_HANDLED
}
public client_putinserver(id)
{
		cshop_speed[id] = false
		cshop_ddamage[id] = false
		cshop_healthregen[id] = false
		cshop_armorregen[id] = false
		cshop_norecoil[id] = false
		cshop_goldenak[id] = false
	
		if(get_pcvar_num(HUDEnabled) == 1) set_task(1.0, "hud_bar", id, _, _, "b")
		LoadData(id)
	
		
		if(kupon_kodus[id] == kayitlikod[id]){
			
		}
		else
		{
			kupon_hak[id] = g_hak[id]	

		}
	
		// KREDI ALIMI KONTROL EDILIYOR..!
	
		if(kredikontrol_ammo(username[id]) == 1)
		{
		
		
		set_task(1.0, "kredi_tahsilat2500",id)
		
		}
		
		if(kredikontrol_ammo(username[id]) == 2)
		{
		
		
		set_task(1.0, "kredi_tahsilat6000",id)
		
		}
	
		if(kredikontrol_ammo(username[id]) == 3)
		{
		set_task(1.0, "kredi_tahsilat10000",id)
	
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 4)
		{
		set_task(1.0, "kredi_tahsilat15000",id)
		
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 5)
		{
		set_task(1.0, "kredi_tahsilat25000",id)
	
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 6)
		{
		set_task(1.0, "kredi_tahsilat30000",id)
		
		
		
		}
	
}

public client_disconnected(id){
		if(use_points && get_pcvar_num(SavePoints) == 1){
			SaveData(id)
		}
		
	
	
		if(kredikontrol_ammo(username[id]) == 1)
		{
		
		
		set_task(1.0, "kredi_tahsilat2500",id)
		
		}
		
		if(kredikontrol_ammo(username[id]) == 2)
		{
		
		
		set_task(1.0, "kredi_tahsilat6000",id)
		
		}
	
		if(kredikontrol_ammo(username[id]) == 3)
		{
		set_task(1.0, "kredi_tahsilat10000",id)
	
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 4)
		{
		set_task(1.0, "kredi_tahsilat15000",id)
		
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 5)
		{
		set_task(1.0, "kredi_tahsilat25000",id)
	
		
		
		}
		
		if(kredikontrol_ammo(username[id]) == 6)
		{
		set_task(1.0, "kredi_tahsilat30000",id)
		
		
		
		}
	
}
public SaveData(id)
{
	new name[32]
	get_user_authid(id, name, 31)
	new vaultkey[64], vaultdata[256]
    
	format(vaultkey, 63, "%s", name)
	format(vaultdata, 255, "%i", points[id])
	nvault_set(g_vault, vaultkey, vaultdata)
	

    
	return PLUGIN_CONTINUE
}





public LoadData(id)
{
	new name[32]
	get_user_authid(id, name, 31)
	new vaultkey[64], vaultdata[256]
    
	format(vaultkey, 63, "%s", name)
	format(vaultdata, 255, "%i", points[id])
	nvault_get(g_vault, vaultkey, vaultdata, 255)
	
	new points_user[10]
	parse(vaultdata, points_user, 9)
	
	new points_set = str_to_num(points_user)
	points[id] = points_set
	
	
    
	return PLUGIN_CONTINUE
}


	
	
new silahhakki[64] = 3
public player_spawn(id)
{
	SaveData(id)
	if(g_yetkilihak[id] > 0){
	
		if(silahhakki[id] > 0){
		
			silahhakki[id] -= 1
			ColorChat( id,NORMAL, "[%s] Satin aldigin Itemlerin^3 %d^4 Olus sonrasi geri alinacaktir.",szPrefix,silahhakki[id])
			ColorChat( id,NORMAL, "[%s] Bu Ozellik 15 TL Ve daha uzeri alinan yetkilerde kullanilmaktadir.",szPrefix)
		}
		else
		{
			
			cshop_speed[id] = false
			cshop_ddamage[id] = false
			cshop_healthregen[id] = false
			cshop_armorregen[id] = false
			cshop_norecoil[id] = false
			cshop_goldenak[id] = false	
			
			
		}
	}
	else
	{
		
		cshop_speed[id] = false
		cshop_ddamage[id] = false
		cshop_healthregen[id] = false
		cshop_armorregen[id] = false
		cshop_norecoil[id] = false
		cshop_goldenak[id] = false
		
		
		
		
	}
	
	
	if(is_user_alive(id))
	{
		set_user_footsteps(id, 0)
		set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 255)
	}
	if(is_user_connected(id)) cs_reset_user_model(id)
	
	for(new i = 0; i < MAX_ITEMS + 1; i++)
		set_user_limit(id, i, 0)
}

public change_weapon(id)
{
	weapon[id] = get_user_weapon(id)
	if(cshop_speed[id]) set_user_maxspeed(id, get_pcvar_float(FasterSpeedAmount))
	
	if(cshop_goldenak[id] && weapon[id] == CSW_AK47)
		set_goldenak(id)
}

public set_goldenak(id)
{
	if(cshop_goldenak[id] && weapon[id] == CSW_AK47)
	{
		set_pev(id, pev_viewmodel2, mGoldenAKv)
		set_pev(id, pev_weaponmodel2, mGoldenAKp)
	}
}

public goldenak_bullets(id) // Credits to AlejandroSk [ https://forums.alliedmods.net/showthread.php?p=827532 ]
{
	if(cshop_goldenak[id] && get_pcvar_num(GoldenAKBullets) == 1)
	{
		new clip, ammo
		new wpnid = get_user_weapon(id, clip, ammo)
		new pteam[16]
		
		get_user_team(id, pteam, 15)
		
		if((bullets[id] > clip) && (wpnid == CSW_AK47))
		{
			new vec1[3], vec2[3]
			get_user_origin(id, vec1, 1)
			get_user_origin(id, vec2, 4)
			
			message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
			write_byte(0)
			write_coord(vec1[0])
			write_coord(vec1[1])
			write_coord(vec1[2])
			write_coord(vec2[0])
			write_coord(vec2[1])
			write_coord(vec2[2])
			write_short(GoldenBullet)
			write_byte(1)
			write_byte(5)
			write_byte(2)
			write_byte(10)
			write_byte(0)
			write_byte(255)
			write_byte(215)
			write_byte(0)
			write_byte(200)
			write_byte(150)
			message_end()
		}
		
		bullets[id] = clip
	}
}

public infoMessage()
	ColorChat(0, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_INFO", PLUGIN_NAME, PLUGIN_AUTHOR)

public cmd_points(id)
{
	if(!use_points) ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOPOINTS")	
	else ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_YOURPOINTS", points[id])
	
	return PLUGIN_HANDLED
}

public cmd_givepoints(id, level, cid)
{
	if(!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED

	new arg[32], arg2[8], name[32], name2[32], g_players[32], num, player
	read_argv(1, arg, 31)
	read_argv(2, arg2, 7)
	get_players(g_players, num)
	get_user_name(id, name, 31)
	
	new amount = str_to_num(arg2)	
	new count = 0

	if(arg[0] == '@')
	{
		for(new i = 0; i < num; i++)
		{
			player = g_players[i]
			
			if((equali(arg, "@T") && get_user_team(player) == 1) || (equali(arg, "@CT") && get_user_team(player) == 2) || equali(arg, "@ALL"))
			{
				points[player] += amount
				count++
			}
		}
		
		if(count == 0)
		{
			ColorChat(id, RED, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOPLAYERS")
			client_print(id, print_console, "%s %L", szPrefix, LANG_SERVER, "CSHOP_NOPLAYERS")
			return PLUGIN_HANDLED
		}
		
		if(equali(arg, "@T")) formatex(name2, 31, "%L", LANG_SERVER, "CSHOP_ALL_T")
		else if(equali(arg, "@CT")) formatex(name2, 31, "%L", LANG_SERVER, "CSHOP_ALL_CT")
		else formatex(name2, 31, "%L", LANG_SERVER, "CSHOP_ALL_PLR")
	}
	else
	{
		player = cmd_target(id, arg, 0)
		if(!player) return PLUGIN_HANDLED
		
		get_user_name(player, name2, 31)
		
		if(amount == 0)
		{
			ColorChat(0, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_TOOKALL", name, name2)
			client_print(id, print_console, "%s %L", szPrefix, LANG_SERVER, "CSHOP_TOOKALL_CONSOLE", name2)
			log_amx("%s %L", szPrefix, LANG_SERVER, "CSHOP_TOOKALL_LOG", name, name2)
			
			points[player] = 0
			return PLUGIN_HANDLED
		}
		
		points[player] += amount
	}
	
	switch(activity)
	{
		case 1: ColorChat(0, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_GIVEPOINTS", LANG_SERVER, (amount >= 0) ? "CSHOP_GAVE" : "CSHOP_TOOK", abs(amount), LANG_SERVER, (amount >= 0) ? "CSHOP_TO" : "CSHOP_FROM", name2)
		case 2: ColorChat(0, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_GIVEPOINTS", name, LANG_SERVER, (amount >= 0) ? "CSHOP_GAVE" : "CSHOP_TOOK", abs(amount), LANG_SERVER, (amount >= 0) ? "CSHOP_TO" : "CSHOP_FROM", name2)
	}
	
	client_print(id, print_console, "%s %L", szPrefix, LANG_SERVER, "CSHOP_GIVEPOINTS_CONSOLE", LANG_SERVER, (amount >= 0) ? "CSHOP_GAVE" : "CSHOP_TOOK", abs(amount), LANG_SERVER, (amount >= 0) ? "CSHOP_TO" : "CSHOP_FROM", name2)
	log_amx("%s %L", szPrefix, LANG_SERVER, "CSHOP_GIVEPOINTS_LOG", name, LANG_SERVER, (amount >= 0) ? "CSHOP_GAVE" : "CSHOP_TOOK", abs(amount), LANG_SERVER, (amount >= 0) ? "CSHOP_TO" : "CSHOP_FROM", name2)
	
	return PLUGIN_HANDLED
}

public vip_charge(id){
	
	if(access(id,ADMIN_IMMUNITY)) {
		
		if(g_yetkilihak[id] < 1){
			g_yetkilihak[id] = get_pcvar_num(yetkilihak)
		}
		
		
	}
	
	return PLUGIN_HANDLED
}
	
public cshop_main(id)
{
	if(get_pcvar_num(VIPOnly) == 1)
	{
		if(!(user_has_flag(id, FlagAccess)))
		{
			ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOACCESS")
			client_cmd(id, "spk %s", sNo)
			return PLUGIN_HANDLED
		}
	}
	

	
	
	new shop_team = get_pcvar_num(TeamOnly)
	new team = get_user_team(id)
	
	if(shop_team != 0)
	{
		if(shop_team != team)
		{
			ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_TEAMONLY", (shop_team == 1) ? "T" : (shop_team == 2) ? "CT" : "Spectator")
			client_cmd(id, "spk %s", sNo)
			return PLUGIN_HANDLED
		}
	}
	
	if(!is_user_alive(id))
	{
		ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOTALIVE")
		client_cmd(id, "spk %s", sNo)
		return PLUGIN_HANDLED
	}
	
	new menu_title[200], items[30], symbol[20]
	new amount = use_points ? points[id] : cs_get_user_money(id)
	get_pcvar_string(DisabledItems, items, charsmax(items))
	get_pcvar_string(CurrencySymbol, symbol, charsmax(symbol))
	
	formatex(menu_title, charsmax(menu_title), "\yCSDURAGI | 2017 \rGelismis Market^n %s^n\w%L: \r%i TL \d| \w%L:\d | \wTanimlanan Bedava Hakki : \r%d\d ", g_baslik , LANG_SERVER, use_points ? "CSHOP_POINTS" : "CSHOP_MONEY", amount, LANG_SERVER, "CSHOP_PAGE",g_yetkilihak[id])
	new customshop = menu_create(menu_title, "cshop_handler")
	
	new item[80], close[15], back[15], next[15]
	
	if(contain(items, "a") == -1) // Item "a": +50 Health
	{
		formatex(item, charsmax(item), "%s+%i %L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(HealthPrice)) ? "" : "\d", get_pcvar_num(HealthAmount), LANG_SERVER, "CSHOP_HEALTH", get_pcvar_num(HealthPrice), symbol, get_user_limit(id, 0), itemlimit(0))
		menu_additem(customshop, item, "0", 0)
	}
	
	if(contain(items, "b") == -1) // Item "b": +50 Armor
	{
		formatex(item, charsmax(item), "%s+%i %L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(ArmorPrice)) ? "" : "\d", get_pcvar_num(ArmorAmount), LANG_SERVER, "CSHOP_ARMOR", get_pcvar_num(ArmorPrice), symbol, get_user_limit(id, 1), itemlimit(1))
		menu_additem(customshop, item, "1", 0)
	}	
	
	if(contain(items, "c") == -1) // Item "c": Unlimited Clip
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(UnlimitedClipPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_UNLCLIP", get_pcvar_num(UnlimitedClipPrice), symbol, get_user_limit(id, 2), itemlimit(2))
		menu_additem(customshop, item, "2", 0)
	}
	
	if(contain(items, "d") == -1) // Item "d": Unlimited Ammo
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(UnlimitedAmmoPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_UNLAMMO", get_pcvar_num(UnlimitedAmmoPrice), symbol, get_user_limit(id, 3), itemlimit(3))
		menu_additem(customshop, item, "3", 0)
	}	
	
	if(contain(items, "e") == -1) // Item "e": All Grenades
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(AllGrenadesPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_ALLGRENADES", get_pcvar_num(AllGrenadesPrice), symbol, get_user_limit(id, 4), itemlimit(4))
		menu_additem(customshop, item, "4", 0)
	}	
	
	if(contain(items, "f") == -1) // Item "f": Bomber
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(BomberPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_BOMBER", get_pcvar_num(BomberPrice), symbol, get_user_limit(id, 5), itemlimit(5))
		menu_additem(customshop, item, "5", 0)
	}	
	
	if(contain(items, "g") == -1) // Item "g": Silent Footsteps
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(SilentFootstepsPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_SILENTSTEPS", get_pcvar_num(SilentFootstepsPrice), symbol, get_user_limit(id, 6), itemlimit(6))
		menu_additem(customshop, item, "6", 0)
	}	
	
	if(contain(items, "h") == -1) // Item "h": Faster Speed
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(FasterSpeedPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_FASTERSPEED", get_pcvar_num(FasterSpeedPrice), symbol, get_user_limit(id, 7), itemlimit(7))
		menu_additem(customshop, item, "7", 0)
	}	
	
	if(contain(items, "i") == -1) // Item "i": Low Gravity
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(LowGravityPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_LOWGRAVITY", get_pcvar_num(LowGravityPrice), symbol, get_user_limit(id, 8), itemlimit(8))
		menu_additem(customshop, item, "8", 0)
	}
	
	if(contain(items, "j") == -1) // Item "j": Chameleon
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(ChameleonPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_CHAMELEON", get_pcvar_num(ChameleonPrice), symbol, get_user_limit(id, 9), itemlimit(9))
		menu_additem(customshop, item, "9", 0)
	}	
	
	if(contain(items, "k") == -1) // Item "k": Drugs (Speed + Health)
	{
		formatex(item, charsmax(item), "%s%L (%L) \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(DrugsPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_DRUGS", LANG_SERVER, "CSHOP_DRUGS2", get_pcvar_num(DrugsPrice), symbol, get_user_limit(id, 10), itemlimit(10))
		menu_additem(customshop, item, "10", 0)
	}	
	
	if(contain(items, "l") == -1) // Item "l": Transparency
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(TransparencyPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_TRANSPARENCY", get_pcvar_num(TransparencyPrice), symbol, get_user_limit(id, 11), itemlimit(11))
		menu_additem(customshop, item, "11", 0)
	}	
	
	if(contain(items, "m") == -1) // Item "m": Invisibility (15 Seconds)
	{
		formatex(item, charsmax(item), "%s%L (%i %L) \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(InvisibilityPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_INVISIBILITY", get_pcvar_num(InvisibilityTime), LANG_SERVER, "CSHOP_SECONDS", get_pcvar_num(InvisibilityPrice), symbol, get_user_limit(id, 12), itemlimit(12))
		menu_additem(customshop, item, "12", 0)
	}	
	
	if(contain(items, "n") == -1) // Item "n": Double Damage
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(DoubleDamagePrice)) ? "" : "\d", LANG_SERVER, "CSHOP_DDAMAGE", get_pcvar_num(DoubleDamagePrice), symbol, get_user_limit(id, 13), itemlimit(13))
		menu_additem(customshop, item, "13", 0)
	}	
	
	if(contain(items, "o") == -1) // Item "o": GodMode (5 Seconds)
	{
		formatex(item, charsmax(item), "%s%L (%i %L) \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(GodModePrice)) ? "" : "\d", LANG_SERVER, "CSHOP_GODMODE", get_pcvar_num(GodModeTime), LANG_SERVER, "CSHOP_SECONDS", get_pcvar_num(InvisibilityPrice), symbol, get_user_limit(id, 14), itemlimit(14))
		menu_additem(customshop, item, "14", 0)
	}
	
	if(contain(items, "p") == -1) // Item "p": Health Regeneration
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(HealthRegenPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_HEALTHREGEN", get_pcvar_num(HealthRegenPrice), symbol, get_user_limit(id, 15), itemlimit(15))
		menu_additem(customshop, item, "15", 0)
	}	
	
	if(contain(items, "q") == -1) // Item "q": Armor Regeneration
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(ArmorRegenPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_ARMORREGEN", get_pcvar_num(ArmorRegenPrice), symbol, get_user_limit(id, 16), itemlimit(16))
		menu_additem(customshop, item, "16", 0)
	}
	
	if(contain(items, "r") == -1) // Item "r": No Recoil
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(NoRecoilPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_NORECOIL", get_pcvar_num(NoRecoilPrice), symbol, get_user_limit(id, 17), itemlimit(17))
		menu_additem(customshop, item, "17", 0)
	}
	
	if(contain(items, "s") == -1) // Item "s": AWP
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(AWPPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_AWP", get_pcvar_num(AWPPrice), symbol, get_user_limit(id, 18), itemlimit(18))
		menu_additem(customshop, item, "18", 0)
	}
	
	if(contain(items, "t") == -1) // Item "t": Golden AK
	{
		formatex(item, charsmax(item), "%s%L \r[\y%i%s\r] [\y%i\r/\y%i\r]", (amount >= get_pcvar_num(GoldenAKPrice)) ? "" : "\d", LANG_SERVER, "CSHOP_GOLDENAK", get_pcvar_num(GoldenAKPrice), symbol, get_user_limit(id, 19), itemlimit(19))
		menu_additem(customshop, item, "19", 0)
	}
	
	formatex(close, charsmax(close), "%L", LANG_SERVER, "CSHOP_EXIT")
	formatex(back, charsmax(back), "%L", LANG_SERVER, "CSHOP_BACK")
	formatex(next, charsmax(next), "%L", LANG_SERVER, "CSHOP_NEXT")
	
	menu_setprop(customshop, MPROP_EXITNAME, close)
	menu_setprop(customshop, MPROP_BACKNAME, back)
	menu_setprop(customshop, MPROP_NEXTNAME, next)
	
	menu_display(id, customshop, 0)
	return PLUGIN_HANDLED
}

public cshop_handler(id, customshop, item)
{
	if(!is_user_alive(id) || item == MENU_EXIT)
	{
		menu_destroy(customshop)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(customshop, item, access, data, charsmax(data), iName, charsmax(iName), callback)
	if(g_yetkilihak[id] < 1 ) {
		
		g_yetkilihak[id] -= 1	
		
	}
	new key = str_to_num(data)
	
	check_cvars(key)
	buy_item(id, key, cvar, g_itemLanguage[key])
	
	menu_destroy(customshop)
	return PLUGIN_HANDLED
}

stock buy_item(id, item, price, const msg[])
{
	if(get_user_limit(id, item) == itemlimit(item))
	{
		ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_LIMITREACHED", itemlimit(item))
		client_cmd(id, "spk %s", sNo)
		return
	}
	
	new amount = (use_points) ? points[id] : cs_get_user_money(id)
	
	new text[50]
	formatex(text, charsmax(text), "%s", msg)
	
	new symbol[20]
	get_pcvar_string(CurrencySymbol, symbol, charsmax(symbol))
	
	
	
	
	if(g_yetkilihak[id] < 1 ) {
		
		
		
		
		
		
	
	
	if(amount >= price)
	{
		if(item == 2 || item == 3)
		{
			buy_unlimited(id, item, price, text, symbol)
			return
		}
		else
		{
			switch(item)
			{
				case 0: set_user_health(id, get_user_health(id) + get_pcvar_num(HealthAmount))
				case 1: set_user_armor(id, get_user_armor(id) + get_pcvar_num(ArmorAmount))
				case 4:
				{
					give_item(id, "weapon_hegrenade")
					give_item(id, "weapon_flashbang")
					give_item(id, "weapon_flashbang")
					give_item(id, "weapon_smokegrenade")
				}
				case 5:
				{
					give_item(id, "weapon_hegrenade")
					cs_set_user_bpammo(id, CSW_HEGRENADE, get_pcvar_num(BomberAmount))
				}
				case 6: set_user_footsteps(id, 1)
				case 7:
				{
					cshop_speed[id] = true
					set_user_maxspeed(id, get_pcvar_float(FasterSpeedAmount))
				}
				case 8: set_user_gravity(id, get_pcvar_float(LowGravityAmount))
				case 9:
				{
					switch(get_user_team(id))
					{
						case 1: cs_set_user_model(id, g_playerModels[random_num(4, 7)])
						case 2: cs_set_user_model(id, g_playerModels[random_num(0, 3)])
					}
				}
				case 10:
				{
					set_user_health(id, get_pcvar_num(DrugsHealthAmount))
					set_user_maxspeed(id, get_pcvar_float(DrugsSpeedAmount))
					drug_player(id)
				}
				case 11: set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, get_pcvar_num(TransparencyAmount))
				case 12:
				{
					set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 0)
					set_task(get_pcvar_float(InvisibilityTime), "NoMoreInvis", id)
				}
				case 13: cshop_ddamage[id] = true
				case 14:
				{
					set_user_godmode(id, 1)
					set_task(get_pcvar_float(GodModeTime), "NoMoreGod", id)
				}
				case 15:
				{
					cshop_healthregen[id] = true
					set_task(get_pcvar_float(HealthRegenTime), "healthRegenTicker", id, "", 0, "b", 0)
				}
				case 16:
				{
					cshop_armorregen[id] = true
					set_task(get_pcvar_float(ArmorRegenTime), "armorRegenTicker", id, "", 0, "b", 0)
				}
				case 17: cshop_norecoil[id] = true
				case 18:
				{
					give_item(id, "weapon_awp")
					cs_set_user_bpammo(id, CSW_AWP, 30)
				}
				case 19:
				{
					if(!user_has_weapon(id, CSW_AK47))
					{
						give_item(id, "weapon_ak47")
						cs_set_user_bpammo(id, CSW_AK47, get_pcvar_num(GoldenAKAmmo))
					}
					
					cshop_goldenak[id] = true
					set_goldenak(id)
				}
			}
		}
		
		set_user_limit(id, item, get_user_limit(id, item) + 1)
		player_charge(id, price)
		ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_BOUGHT", LANG_SERVER, msg, price, symbol)
		emit_sound(id, CHAN_ITEM, g_itemSounds[item], VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	}
	else notenough(id)
	}
	else
	{
	    	silahhakki[id] = 3
		g_yetkilihak[id]--	
		if(item == 2 || item == 3)
		{
				
			buy_unlimited(id, item, price, text, symbol)
			return
		}
		else
		{
			
			switch(item)
			{
				case 0: set_user_health(id, get_user_health(id) + get_pcvar_num(HealthAmount))
				case 1: set_user_armor(id, get_user_armor(id) + get_pcvar_num(ArmorAmount))
				case 4:
				{
					give_item(id, "weapon_hegrenade")
					give_item(id, "weapon_flashbang")
					give_item(id, "weapon_flashbang")
					give_item(id, "weapon_smokegrenade")
				}
				case 5:
				{
					give_item(id, "weapon_hegrenade")
					cs_set_user_bpammo(id, CSW_HEGRENADE, get_pcvar_num(BomberAmount))
				}
				case 6: set_user_footsteps(id, 1)
				case 7:
				{
					cshop_speed[id] = true
					set_user_maxspeed(id, get_pcvar_float(FasterSpeedAmount))
				}
				case 8: set_user_gravity(id, get_pcvar_float(LowGravityAmount))
				case 9:
				{
					switch(get_user_team(id))
					{
						case 1: cs_set_user_model(id, g_playerModels[random_num(4, 7)])
						case 2: cs_set_user_model(id, g_playerModels[random_num(0, 3)])
					}
				}
				case 10:
				{
					set_user_health(id, get_pcvar_num(DrugsHealthAmount))
					set_user_maxspeed(id, get_pcvar_float(DrugsSpeedAmount))
					drug_player(id)
				}
				case 11: set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, get_pcvar_num(TransparencyAmount))
				case 12:
				{
					set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 0)
					set_task(get_pcvar_float(InvisibilityTime), "NoMoreInvis", id)
				}
				case 13: cshop_ddamage[id] = true
				case 14:
				{
					set_user_godmode(id, 1)
					set_task(get_pcvar_float(GodModeTime), "NoMoreGod", id)
				}
				case 15:
				{
					cshop_healthregen[id] = true
					set_task(get_pcvar_float(HealthRegenTime), "healthRegenTicker", id, "", 0, "b", 0)
				}
				case 16:
				{
					cshop_armorregen[id] = true
					set_task(get_pcvar_float(ArmorRegenTime), "armorRegenTicker", id, "", 0, "b", 0)
				}
				case 17: cshop_norecoil[id] = true
				case 18:
				{
					give_item(id, "weapon_awp")
					cs_set_user_bpammo(id, CSW_AWP, 30)
				}
				case 19:
				{
					if(!user_has_weapon(id, CSW_AK47))
					{
						give_item(id, "weapon_ak47")
						cs_set_user_bpammo(id, CSW_AK47, get_pcvar_num(GoldenAKAmmo))
					}
					
					cshop_goldenak[id] = true
					set_goldenak(id)
				}
			}
		}
		
		set_user_limit(id, item, get_user_limit(id, item) + 1)
		ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_VIP_BOUGHT", LANG_SERVER, msg)
		emit_sound(id, CHAN_ITEM, g_itemSounds[item], VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
		
		
		
		
		
		
		
		
		
	}
	
	
		
}

public check_cvars(item)
{
	switch(item)
	{
		case 0: cvar = get_pcvar_num(HealthPrice)
		case 1: cvar = get_pcvar_num(ArmorPrice)
		case 2: cvar = get_pcvar_num(UnlimitedClipPrice)
		case 3: cvar = get_pcvar_num(UnlimitedAmmoPrice)
		case 4: cvar = get_pcvar_num(AllGrenadesPrice)
		case 5: cvar = get_pcvar_num(BomberPrice)
		case 6: cvar = get_pcvar_num(SilentFootstepsPrice)
		case 7: cvar = get_pcvar_num(FasterSpeedPrice)
		case 8: cvar = get_pcvar_num(LowGravityPrice)
		case 9: cvar = get_pcvar_num(ChameleonPrice)
		case 10: cvar = get_pcvar_num(DrugsPrice)
		case 11: cvar = get_pcvar_num(TransparencyPrice)
		case 12: cvar = get_pcvar_num(InvisibilityPrice)
		case 13: cvar = get_pcvar_num(DoubleDamagePrice)
		case 14: cvar = get_pcvar_num(GodModePrice)
		case 15: cvar = get_pcvar_num(HealthRegenPrice)
		case 16: cvar = get_pcvar_num(ArmorRegenPrice)
		case 17: cvar = get_pcvar_num(NoRecoilPrice)
		case 18: cvar = get_pcvar_num(AWPPrice)
		case 19: cvar = get_pcvar_num(GoldenAKPrice)
	}
}

stock buy_unlimited(id, item, price, msg[], symbol[20])
{
	if(weapon[id] == CSW_KNIFE || weapon[id] == CSW_HEGRENADE || weapon[id] == CSW_FLASHBANG || weapon[id] == CSW_SMOKEGRENADE || weapon[id] == CSW_C4)
	{
		cantactivateitem(id, item)
		return
	}
	else switch(item)
	{
		case 2:
		{
			cs_set_weapon_ammo(get_pdata_cbase(id, m_pActiveItem), 97280)
			cs_set_user_bpammo(id, weapon[id], 0)
		}
		case 3: cs_set_user_bpammo(id, weapon[id], 99999)		
	}
	
	set_user_limit(id, item, get_user_limit(id, item) + 1)
	player_charge(id, price)
	ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_BOUGHT", LANG_SERVER, msg, price, symbol)
	emit_sound(id, CHAN_ITEM, g_itemSounds[item], VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
}

stock itemlimit(item)
{
	new limit

	switch(item)
	{
		case 0: limit = get_pcvar_num(HealthLimit)
		case 1: limit = get_pcvar_num(ArmorLimit)
		case 2: limit = get_pcvar_num(UnlimitedClipLimit)
		case 3: limit = get_pcvar_num(UnlimitedAmmoLimit)
		case 4: limit = get_pcvar_num(AllGrenadesLimit)
		case 5: limit = get_pcvar_num(BomberLimit)
		case 6: limit = get_pcvar_num(SilentFootstepsLimit)
		case 7: limit = get_pcvar_num(FasterSpeedLimit)
		case 8: limit = get_pcvar_num(LowGravityLimit)
		case 9: limit = get_pcvar_num(ChameleonLimit)
		case 10: limit = get_pcvar_num(DrugsLimit)
		case 11: limit = get_pcvar_num(TransparencyLimit)
		case 12: limit = get_pcvar_num(InvisibilityLimit)
		case 13: limit = get_pcvar_num(DoubleDamageLimit)
		case 14: limit = get_pcvar_num(GodModeLimit)
		case 15: limit = get_pcvar_num(HealthRegenLimit)
		case 16: limit = get_pcvar_num(ArmorRegenLimit)
		case 17: limit = get_pcvar_num(NoRecoilLimit)
		case 18: limit = get_pcvar_num(AWPLimit)
		case 19: limit = get_pcvar_num(GoldenAKLimit)
	}
	
	return limit
}

stock set_user_limit(id, item, limit)
	userlimit[id][item] = limit

stock get_user_limit(id, item)
	return userlimit[id][item]

stock notenough(id)
{
	ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOTENOUGH", LANG_SERVER, use_points ? "CSHOP_POINTS_SMALL" : "CSHOP_MONEY_SMALL")
	client_cmd(id, "spk %s", sNo)
}

stock cantactivateitem(id, item)
{
	ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_CANNOT_ACTIVATE", LANG_SERVER, (item == 2) ? "CSHOP_UNLCLIP" : "CSHOP_UNLAMMO")
	client_cmd(id, "spk %s", sNo)
}

public NoMoreInvis(id)
{
	set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 255)
	ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOMOREINVIS")
	client_cmd(id, "spk %s", sOver)
}

public NoMoreGod(id)
{
	if(is_user_alive(id)) set_user_godmode(id, 0)
	ColorChat(id, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_NOMOREGOD")
	client_cmd(id, "spk %s", sOver)
}

public player_damage(victim, inflictor, attacker, Float:damage, damage_bits)
{
	if(is_user_alive(attacker) && attacker != victim)
	{
		if(cshop_goldenak[attacker])
			SetHamParamFloat(4, damage * get_pcvar_num(GoldenAKDamage))
		else if(cshop_ddamage[attacker])
			SetHamParamFloat(4, damage * 2)
	}
}

public player_prethink(id)
{
	if(!is_user_alive(id) || !cshop_norecoil[id])
		return
	
	set_pev(id, pev_punchangle, {0.0, 0.0, 0.0})
}

stock player_charge(id, price)
{
	if(use_points) points[id] -= price
	else cs_set_user_money(id, cs_get_user_money(id) - price)
}

stock drug_player(id)
{
	message_begin(MSG_ONE, gmsg_SetFOV, {0, 0, 0}, id)
	write_byte(180)
	message_end()
}

public player_killed()
{	
	new attacker = read_data(1)
	new victim = read_data(2)

	new oldurdugu[64]
	oldurdugu[attacker] += 1
	
	if(!use_points || !is_user_connected(attacker) || !is_user_connected(victim) || attacker == victim)
		return HAM_IGNORED
	
	if(get_pcvar_num(VIPOnly) == 1)
	{
		if(!(user_has_flag(attacker, FlagAccess)))
            return HAM_IGNORED
    }
	
	new headshot = read_data(3)

	new wep[32]
	read_data(4, wep, 31)
	
	new team_attacker = get_user_team(attacker)
	new team_victim = get_user_team(victim)
	
	if(team_attacker == team_victim)
	{
		if(get_pcvar_num(TeamKillPoints) == 0)
			return HAM_IGNORED
	}
	
	new reward
	
	if(equali(wep, "knife")) reward = get_pcvar_num(KnifeReward)
	else if(headshot) reward = get_pcvar_num(HeadshotReward)
	else reward = get_pcvar_num(NormalReward)
	
	if(get_pcvar_num(VIPBonus) == 1 && user_has_flag(attacker, FlagBonus)) reward += get_pcvar_num(BonusReward)
	new name_victim[32]
	if(!access(attacker,ADMIN_RESERVATION)) {
	
		if(points[attacker] > get_pcvar_num(tlsiniri)){
			ColorChat(attacker, TEAM_COLOR, "%s Market Cuzdaninizda Daha Fazla Para Biriktiremiyorsunuz..!^4 /banka^3 Yazarak Banka Hesabiniza Atin..!", szPrefix)
			ColorChat(attacker, TEAM_COLOR, "%s Yada ^4fb.com/redarmygamingserver^3 Adresine Gelerek Adminlik alabilir yada yetkili olabilirsiniz.", szPrefix)

		}
		else
		{	
			
			
			
			
			
			points[attacker] += reward
			ColorChat(attacker, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_KILL", reward, name_victim)
			
		
				
			
			
			
			
			
			
			
		}
	}
	else
	{
		
		
			
			
			points[attacker] += reward
			ColorChat(attacker, TEAM_COLOR, "%s ^1%L", szPrefix, LANG_SERVER, "CSHOP_KILL", reward, name_victim)
				
			
			
			
		
	}
	
	return HAM_IGNORED
}

public healthRegenTicker(id)
{
	if(!is_user_alive(id) || !cshop_healthregen[id]) remove_task(id)
	
	new health = get_user_health(id)
	new healthamount = get_pcvar_num(HealthRegenAmount)
	new healthmax = get_pcvar_num(HealthRegenMax)
	
	if(cshop_healthregen[id] && is_user_alive(id))
	{
		if(health < healthmax)
		{
			if(health + healthamount > healthmax) set_user_health(id, healthmax)
			else set_user_health(id, health + healthamount)
		}
	}
}

public armorRegenTicker(id)
{
	if(!is_user_alive(id) || !cshop_armorregen[id]) remove_task(id)
	
	new armor = get_user_armor(id)
	new armoramount = get_pcvar_num(ArmorRegenAmount)
	new armormax = get_pcvar_num(ArmorRegenMax)
		
	if(cshop_armorregen[id] && is_user_alive(id))
	{
		if(armor < armormax)
		{
			if(armor + armoramount > armormax) set_user_armor(id, armormax)
			else set_user_armor(id, armor + armoramount)
		}
	}
}

public plugin_precache()
{
	for(new i = 0; i < sizeof g_itemSounds; i++)
		precache_sound(g_itemSounds[i])
	
	precache_model(mGoldenAKp)
	precache_model(mGoldenAKv)
	
	GoldenBullet = precache_model("sprites/dot.spr")
}

stock user_has_flag(id, cvar)
{
	new flags[32]
	get_flags(get_user_flags(id), flags, charsmax(flags))
	
	new vip_flag[2]
	get_pcvar_string(cvar, vip_flag, charsmax(vip_flag))
	
	return (contain(flags, vip_flag) != -1) ? true : false
}

/* ======================================================================================================= */
/* ColorChat */
/* ======================================================================================================= */
ColorChat(id, Color:type, const msg[], {Float,Sql,Result,_}:...)
{
	if( !get_playersnum() ) return;
	
	new message[256];

	switch(type)
	{
		case NORMAL: // clients scr_concolor cvar color
		{
			message[0] = 0x01;
		}
		case GREEN: // Green
		{
			message[0] = 0x04;
		}
		default: // White, Red, Blue
		{
			message[0] = 0x03;
		}
	}

	vformat(message[1], 251, msg, 4);

	replace_all(message, 191, "!n", "^x01")
	replace_all(message, 191, "!t", "^x03")
	replace_all(message, 191, "!g", "^x04")
	
	// Make sure message is not longer than 192 character. Will crash the server.
	message[192] = '^0';

	new team, ColorChange, index, MSG_Type;
	
	if(id)
	{
		MSG_Type = MSG_ONE;
		index = id;
	} else {
		index = FindPlayer();
		MSG_Type = MSG_ALL;
	}
	
	team = get_user_team(index);
	ColorChange = ColorSelection(index, MSG_Type, type);

	ShowColorMessage(index, MSG_Type, message);
		
	if(ColorChange)
	{
		Team_Info(index, MSG_Type, TeamName[team]);
	}
}

ShowColorMessage(id, type, message[])
{
	static bool:saytext_used;
	static get_user_msgid_saytext;
	if(!saytext_used)
	{
		get_user_msgid_saytext = get_user_msgid("SayText");
		saytext_used = true;
	}
	message_begin(type, get_user_msgid_saytext, _, id);
	write_byte(id)		
	write_string(message);
	message_end();	
}

Team_Info(id, type, team[])
{
	static bool:teaminfo_used;
	static get_user_msgid_teaminfo;
	if(!teaminfo_used)
	{
		get_user_msgid_teaminfo = get_user_msgid("TeamInfo");
		teaminfo_used = true;
	}
	message_begin(type, get_user_msgid_teaminfo, _, id);
	write_byte(id);
	write_string(team);
	message_end();

	return 1;
}

ColorSelection(index, type, Color:Type)
{
	switch(Type)
	{
		case RED:
		{
			return Team_Info(index, type, TeamName[1]);
		}
		case BLUE:
		{
			return Team_Info(index, type, TeamName[2]);
		}
		case GREY:
		{
			return Team_Info(index, type, TeamName[0]);
		}
	}

	return 0;
}

FindPlayer()
{
	new i = -1;

	while(i <= get_maxplayers())
	{
		if(is_user_connected(++i))
			return i;
	}

	return -1;
}

// BANKA-------------------------------------

public login_menusu(id)
{
	if(get_pcvar_num(g_banka) == 1)
	{
	
	register_clcmd("say /tltransfer","transfer_menu")
	//register_clcmd("say /kredimenu","bankredi")
	//register_clcmd("say /krediler","bankredileri")
	register_clcmd("Hesap_Ismi","Giris_ID")
	register_clcmd("Hesap_Ismi_Secin","Kayit_ID")
	register_clcmd("Vereceginiz_Miktar","Ammo_Yatir")
	register_clcmd("Alacaginiz_Miktar","Ammo_Cek")
	register_clcmd("Sifreniz","Giris_Pw")
	register_clcmd("Sifre_Secin","Kayit_Pw")
	
	register_clcmd("say /banka yatir","Ammo_Yatir")
	register_clcmd("say /banka cek","Ammo_Cek")
	register_clcmd("say /banka durum","Ammo_Durum")
	
	
	
	
	if(!is_user_connected(id) || !is_user_alive(id)) return PLUGIN_HANDLED
	
	
	

	
	
	new banka_ismi[128],map_name[128]
	get_mapname(map_name,127)
	replace_all(map_name,127,"zm_","")
	replace_all(map_name,127,"de_","")
	replace_all(map_name,127,"cs_","")
	replace_all(map_name,127,"fy_","")
	replace_all(map_name,127,"jail_","")
	replace_all(map_name,127,"surf_","")
	
	formatex(banka_ismi,127,"\rCSDURAGI | \wSERVER BANKASI^n\dParani Hesabina Yatir.. ^nYada TL Transfer Et..!",map_name)
	new menu = menu_create(banka_ismi,"login_devam")
	if(equal(username[id],""))
	{
		menu_additem(menu,"Giris Yap","1",0)
		menu_additem(menu,"Kayit Ol","2",0)
		menu_additem(menu,"\rTL Transfer Et","11",0)
		
	}
	else
	{
		
		
		menu_additem(menu,"\rTL Transfer Et","11",0)
		menu_additem(menu,"Para Yatir","3",0)
		menu_additem(menu,"Para Cek","4",0)
		menu_additem(menu,"Hesap Durumu","6",0)
		//menu_additem(menu,"Kisa Yollar","8",0)
		menu_additem(menu,"Cikis Yap","5",0)
		
		
	}
	if(get_user_flags(id) & ADMIN_BAN)
	{
		menu_additem(menu,"Oyuncularin Hesaplarina Bak","7",ADMIN_BAN)
	}
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	return PLUGIN_HANDLED
	}
	return PLUGIN_HANDLED
	
}
public login_devam(id,menu,item)
{
	
	if(!is_user_connected(id) || !is_user_alive(id)) return PLUGIN_HANDLED
	
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED	
	}
	
	new acces,data2[24],iname[64],callback,data
	menu_item_getinfo(menu,item,acces,data2,23,iname,63,callback)
	data = str_to_num(data2)
	
	
	
	switch(data)
	{
		
		case 1:
		{
			client_cmd(id,"messagemode Hesap_Ismi")
			ColorChat( id, NORMAL, " %s Hesabinizin Kullanici Adini Yaziniz..",bnkPrefix)
		}
		case 2:
		{
			client_cmd(id,"messagemode Hesap_Ismi_Secin")
			ColorChat( id, NORMAL, " %s Acmak Istediginiz Hesabin Kullanici Adini Giriniz..",bnkPrefix)
		}
		case 3:
		{
			client_cmd(id,"messagemode Vereceginiz_Miktar")
			ColorChat( id, NORMAL, " %s Hesabiniza Yatirmak istediginiz Miktari Giriniz..^4[Islem Ucr. = %d TL]",bnkPrefix,get_pcvar_num(g_IslemUcreti))
		}
		case 4:
		{
			client_cmd(id,"messagemode Alacaginiz_Miktar")
			ColorChat( id, NORMAL, " %s Hesabinizdan Cekmek  istediginiz Miktari Giriniz..^4[Islem Ucr. = %d TL]",bnkPrefix,get_pcvar_num(g_IslemUcreti))
		}
		case 5:
		{
			copy(username[id],199,"")
			copy(password[id],199,"")
			client_print(id,print_center,"Cikis yaptiniz..")
			ColorChat( id, NORMAL, " %s Hesabinizdan Cikis Yaptiniz.. ^1 /banka ^3Yazarak Giris Yapabilirsiniz.",bnkPrefix)
		}
		case 6:
		{
			set_hudmessage(42, 212, 255, 0.30, 0.93, 0, 6.0, 6.2)
			show_hudmessage(id, "[Bankadaki Miktar : ^n %d TL | /banka yazman Yeterli]",get_hesap_ammo(username[id]))
		}
		case 7:
		{
			if((get_user_flags(id) & ADMIN_BAN))
			{
				new message[8999],len;  
				len = formatex(message,8998,"<body bgcolor=black><b>");  
				for(new i = 1; i < 33; i++)
				{
					if(is_user_connected(i))
					{
						new iName[64]
						get_user_name(i,iName,63)
						if(!equal(username[i],""))
						{
							len += formatex(message[len],8998-len,"<font color=red>%s</font><font color=white> (Uzerinde %d TL) - Hesapta= %d TL ^n<br></font>^n",iName,points[i],get_hesap_ammo(username[i])) 
						}
						else
						{
							len += formatex(message[len],8998-len,"<font color=red>%s</font><font color=white> (Uzerinde %d TL)^n",iName,points[i]);  
						}
					}
				}
				show_motd(id,message," - Acilmis Banka Hesaplari - "); 
				
			}
		}
		case 8:
		{
			
			ColorChat( id, NORMAL, " %s BANKA KISA YOLLARI ^4-----------------------------------------",bnkPrefix)
			ColorChat( id, NORMAL, " %s Menuye girmeden para yatirmak icin : ^4 /banka yatir <miktar>",bnkPrefix)
			ColorChat( id, NORMAL, " %s Menuye girmeden para cekmek icin   : ^4 /banka cek <miktar>",bnkPrefix)
			ColorChat( id, NORMAL, " %s Menuye girmeden hesap durumu icin  : ^4 /banka durum",bnkPrefix)
			ColorChat( id, NORMAL, " %s ^4 Dikkat ! ^1 Kisa yollardan islemlerde belirtilen islm ucreti alinir..!",bnkPrefix)
			
		
			
			
		}
		case 9:
		{
			client_cmd(id,"say /kredimenu")
		}
		case 10:
		{
			ColorChat( id, NORMAL, " %s ^3Kredi Alabilmen Icin Hesabin Olmasi Yada Giris Yapman Gerekiyor..",bnkPrefix)
			client_cmd(id,"say /banka")
			
		}
		case 11:
		{
			
			client_cmd(id,"say /tltransfer")
			
		}
		
		
		
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED
}

public Giris_ID(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(equal(say, "") || !equal(username[id],"") || strlen(say) > 12)
	{
		copy(g_username[id],199,"")	
		copy(g_password[id],199,"")
		copy(k_username[id],199,"")	
		copy(k_password[id],199,"")
		return PLUGIN_HANDLED	
	}
	
	
	copy(g_password[id],199,"")
	copy(k_username[id],199,"")
	copy(k_password[id],199,"")
	copy(g_username[id],199,say)
	client_cmd(id,"messagemode Sifreniz")
	return PLUGIN_CONTINUE
	
}

public Giris_Pw(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(equal(say, "") || !equal(username[id],"") || equal(g_username[id],"") || strlen(say) > 12)
	{
		copy(g_username[id],199,"")	
		copy(g_password[id],199,"")
		copy(k_username[id],199,"")	
		copy(k_password[id],199,"")
		
		return PLUGIN_HANDLED	
	}
	
	copy(g_password[id],199,say)
	giris_yap(id,g_username[id], g_password[id])
	copy(g_password[id],199,"")
	copy(g_username[id],199,"")
	copy(k_password[id],199,"")
	copy(k_username[id],199,"")
	return PLUGIN_CONTINUE
}


/////////////////////////
////#Kayit Islemleri#////
/////////////////////////

public Kayit_ID(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(equal(say, "") || !equal(username[id],"") || strlen(say) > 12)
	{
		copy(g_username[id],199,"")	
		copy(g_password[id],199,"")
		copy(k_username[id],199,"")	
		copy(k_password[id],199,"")
		return PLUGIN_HANDLED
	}
	
	
	copy(k_password[id],199,"")
	copy(g_username[id],199,"")
	copy(g_password[id],199,"")
	copy(k_username[id],199,say)
	client_cmd(id,"messagemode Sifre_Secin")
	return PLUGIN_CONTINUE
	
}

public Kayit_Pw(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(equal(say, "") || !equal(username[id],"") || equal(k_username[id],"") || strlen(say) > 12)
	{
		copy(g_username[id],199,"")	
		copy(g_password[id],199,"")
		copy(k_username[id],199,"")	
		copy(k_password[id],199,"")
		return PLUGIN_HANDLED
	}
	
	copy(k_password[id],199,say)
	kayit_yap(id,k_username[id], k_password[id])
	copy(g_password[id],199,"")
	copy(g_username[id],199,"")
	copy(k_password[id],199,"")
	copy(k_username[id],199,"")
	return PLUGIN_CONTINUE
}

///////////////////////////
///////////////////////////



public giris_yap(id,userid[],psw[])
{
	if(!is_user_connected(id) || equal(userid,"") || equal(psw,"") || !equal(username[id],""))
		return PLUGIN_HANDLED
	
	new getPw[32], IDFormat[64]
	formatex(IDFormat,63,"%s-ID",userid)
	nvault_get(anavault,IDFormat,getPw,31)
	if(equali(psw,getPw))
	{
		copy(username[id],199,userid)
		copy(password[id],199,psw)
		ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
		ColorChat( id, NORMAL, " %s               Hesabiniza Basari Ile Giris Yaptiniz..",bnkPrefix)
		ColorChat( id, NORMAL, " %s     Suanki Hesabinizda Bulunan Bakiye ^4 %d Tl Bulunmaktadir.",bnkPrefix,get_hesap_ammo(userid))
		ColorChat( id, NORMAL, " %s 	     Islemler Icin ^4 /banka ^1 yazmaniz Yeterlidir..",bnkPrefix)
		ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
	
	}
	else
	{
	
		ColorChat( id, NORMAL, " %s Yanlis Hesap Ismi Veya Sifre Girdiniz..!",bnkPrefix)
	}
	return PLUGIN_HANDLED
}



public kayit_yap(id,userid[],psw[])
{
	if(!is_user_connected(id) || equal(userid,"") || equal(psw,"") || !equal(username[id],""))
		return PLUGIN_HANDLED
	
	new getPw[32], IDFormat[64]
	formatex(IDFormat,63,"%s-ID",userid)
	nvault_get(anavault,IDFormat,getPw,31)
	if(equali(getPw,""))
	{
		copy(username[id],199,userid)
		copy(password[id],199,psw)
		new ammoKey[64], hesapKey[64]
		formatex(hesapKey,63,"%s-ID",userid)
		formatex(ammoKey,63,"%s-TL",userid)
		nvault_set(anavault,hesapKey,psw)
		nvault_set(anavault,ammoKey,"0")
		
		ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
		ColorChat( id, NORMAL, " %s         Banka Hesabiniz Basariyla Acildi Ve Aktiflestirildi..",bnkPrefix)
		ColorChat( id, NORMAL, " %s       	 Hesap Adiniz : ^4 %s ^1 Sifreniz : ^4 %s",bnkPrefix,userid,psw)
		ColorChat( id, NORMAL, " %s 	Hesap Ve Kredi islemleri icin ^4 /banka ^1 Yazmaniz yeterlidir.",bnkPrefix)
		ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
		
		
	}
	else
	{
		
		ColorChat( id, NORMAL, " %s Bu Hesap Zaten Kayitlarimizda Bulunmaktadir.!",bnkPrefix)
	}
	return PLUGIN_HANDLED
}


public Ammo_Yatir(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		return PLUGIN_HANDLED
	
	if(points[id] < str_to_num(say) + get_pcvar_num(g_IslemUcreti))
	{
		client_print(id,print_center,"O kadar paran var mi ? ( Islem ucreti = %d TL )",get_pcvar_num(g_IslemUcreti))
		ColorChat( id, NORMAL, " %s O kadar Paran Var mi ?? (Islem Ucreti = ^4 %d TL^1)",bnkPrefix,get_pcvar_num(g_IslemUcreti))
		return PLUGIN_HANDLED
	}
	
	points[id] -= (str_to_num(say) + get_pcvar_num(g_IslemUcreti))
	set_hesap_ammo(username[id],get_hesap_ammo(username[id]) + str_to_num(say))
	client_print(id,print_center,"Hesabiniza %d TL transfer edildi..",str_to_num(say))
	ColorChat( id, NORMAL, " %s Hesabiniza Market Cuzdaninizdan ^4 %d TL ^1Transfer Edildi..!",bnkPrefix,str_to_num(say))
	return PLUGIN_HANDLED
}

public Ammo_Cek(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		return PLUGIN_HANDLED
	
	if(get_hesap_ammo(username[id]) < str_to_num(say))
	{
		client_print(id,print_center,"Hesabinizda yeterli para yok..!")	
		ColorChat( id, NORMAL, " %s Islemi Gerceklestirmek Icin Yeterli Bakiye Yok!",bnkPrefix)
		return PLUGIN_HANDLED
	}
	
	points[id] += str_to_num(say)
	set_hesap_ammo(username[id],get_hesap_ammo(username[id]) - str_to_num(say))
	client_print(id,print_center,"Hesabinizdan %d TL cektiniz..",str_to_num(say))
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan Market Cuzdaniniza ^4%d TL ^1Transfer Ettiniz.!",bnkPrefix,str_to_num(say))
	return PLUGIN_HANDLED
}


public Ammo_Durum(id){
	
	
	ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
	ColorChat( id, NORMAL, " %s 	   Suanki Banka Hesabi Durumunuzu Goruntulemektesiniz..",bnkPrefix)
	ColorChat( id, NORMAL, " %s 		   Hesabinizdaki Miktar = ^4 %d ^1TL",bnkPrefix,get_hesap_ammo(username[id]))
	ColorChat( id, NORMAL, " %s         Banka islemleriniz icin ^4 /banka ^1yazabilirsiniz",bnkPrefix)
	ColorChat( id, NORMAL, " %s ===================================================================",bnkPrefix)
	
	
	
}

public get_hesap_ammo(userid[])
{
	new gData[64], gAmmoKey[64]
	formatex(gAmmoKey,63,"%s-TL",userid)
	nvault_get(anavault,gAmmoKey,gData,63)
	return str_to_num(gData)
}

public set_hesap_ammo(userid[],miktar)
{
	new gAmmoKey[64], miktar2[128]
	num_to_str(miktar,miktar2,127)
	formatex(gAmmoKey,63,"%s-TL",userid)
	nvault_set(anavault,gAmmoKey,miktar2)
	return 1
}

public hud_bar(id)
{
	if(is_user_alive(id))
	{
		set_hudmessage(get_pcvar_num(HUDRed), get_pcvar_num(HUDGreen), get_pcvar_num(HUDBlue), get_pcvar_float(HUDX), get_pcvar_float(HUDY), 0, 6.0, 2.5)
		ShowSyncHudMsg(id, hudinfo, "[ %L: %i TL ][Bankadaki Miktar : %d TL | /banka yazman Yeterli]", LANG_SERVER, "CSHOP_POINTS", points[id],get_hesap_ammo(username[id]))
	
		
	
	}
}

public bankredi(id){
	
	
	new banka_ismi[128]
	formatex(banka_ismi,127,"\rCSDURAGI | \wSERVER BANKASI^n\dKredi Alim Bolumune Hos Geldiniz..")
	new menu = menu_create(banka_ismi,"bankredi_devam")
	
	menu_additem(menu,"Kredi Nasil Alinir Nedir ","1",0)
	menu_additem(menu,"Kredi Al \d | Alabileceginiz Kredileri Ve Surelerini Gosterir ","2",0)
	menu_additem(menu,"Suanki Odenecek Kredin \d | Odenmesi Gereken Kredilerin.","3",0)
		
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	
	

	return PLUGIN_HANDLED	
	
	
}

public bankredi_devam(id,menu,item)
{
	
	if(!is_user_connected(id) || !is_user_alive(id)) return PLUGIN_HANDLED
	
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED	
	}
	
	new acces,data2[24],iname[64],callback,data
	menu_item_getinfo(menu,item,acces,data2,23,iname,63,callback)
	data = str_to_num(data2)
	
	
	
	switch(data)
	{
		
		case 1:
		{
		
			new message[899],len;  
			len = formatex(message,898,"<body bgcolor=black><b>");  
			for(new i = 1; i < 33; i++)
			{
				if(is_user_connected(i))
				{
					new iName[64]
					get_user_name(i,iName,63)
					
						
					len += formatex(message[len],898-len,"EK PARA ALIMI (KREDI ALIMI) NEDIR NASIL ISLER ?^n")
					len += formatex(message[len],898-len,"--------------------------------------------------------------------------^n")
					len += formatex(message[len],898-len,"KREDI NEDIR ? : Kredi (borç Tl) serverde paraniz alacaginiz iteme yetmiyor ise servermizin size^n belirli sure ve sartlarda verdigi ekstradan bir Server TLsidir.^n")
					len += formatex(message[len],898-len,"KREDI LIMITLERI : Her ay Serverimizde kredi kullanimlarina gore bakilip belirli kez ard arda(sure bitmeden) kredi kullandirimidir^n")
					len += formatex(message[len],898-len,"NASIL ISLER ? : Kredi aldiginiz taktirden itibaren belirli zaman diliminde kredinizi odemek zorundasiniz. Krediler Geriye tek parca belirli zaman ^n diliminden sonra alinir.^n")
					len += formatex(message[len],898-len,"SURE ICERISINDE OYUNDA OLMAZSAM ? : Kredi aldiginiz zaman oyunan kactiginizda ise Market Cuzdaniniza giris yaptiginiz an tutar otomatik cekilecektir.!^n Cekilemez ise Her zaman asiminda 150 TL Faiz koymaktadir.!^n")
					len += formatex(message[len],898-len,"KREDI ALDIKTAN SONRA BANKA HESABINI KULLANMAZSAM ? : Belirli saatten sonra Market cuzdaninizdaki tum para otomatik cekilecektir.!^n")
					len += formatex(message[len],898-len,"ARD ARDA KREDI CEKERSEM ? : Ard Arda Kredi Cekerseniz Onlarin Hepsini Odemeye mahsur kalirsiniz. Yoneticiler bu duruma el koyamaz.! ")
						
						
						
				}
			}
			show_motd(id,message," Kredi Hakkinda Bilgiler"); 
		
		
		}
		case 2:
		{
			client_cmd(id,"say /krediler")
			
		}
		case 3:
		{
			ColorChat( id, NORMAL, " %s Suan Odenecek yada odemen gereken Kredilerin...!",bnkPrefix)
			
			
			if(kredikontrol_ammo(username[id]) == 0)
			{
		
		
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 Bulunmamaktadir..!^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Aldiginiz Kredileri Odediginiz Ve Geciktirmediginiz icin tesekkur ederiz..",bnkPrefix)
			return PLUGIN_HANDLED
			}

			if(kredikontrol_ammo(username[id]) == 1)
			{
		
		
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 2500 TL - 20  Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
			return PLUGIN_HANDLED
			}
		
			if(kredikontrol_ammo(username[id]) == 2)
			{
		
		
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 6000 TL - 60  Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
			return PLUGIN_HANDLED
			}
	
			if(kredikontrol_ammo(username[id]) == 3)
			{
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 10000 TL - 120  Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
			return PLUGIN_HANDLED
		
			}
		
			if(kredikontrol_ammo(username[id]) == 4)
			{
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 15000 TL - 140 Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
		
			return PLUGIN_HANDLED
		
			}
		
			if(kredikontrol_ammo(username[id]) == 5)
			{
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 25000 TL - 180  Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
	
		
			return PLUGIN_HANDLED
			}
			
			if(kredikontrol_ammo(username[id]) == 6)
			{
			ColorChat( id, NORMAL, " %s Tahsil Edilecek Kredin : ^4 30000 TL - 200  Dakka Sonra odemeli^3",bnkPrefix)
			ColorChat( id, NORMAL, " %s Lutfen Aldiginiz Kredilerinizi Geciktirmeyiniz..",bnkPrefix)
		
			return PLUGIN_HANDLED
		
			}
	
}
}
	return PLUGIN_HANDLED
}

public bankredileri(id){
	

	
	new banka_ismi[128]
	
	formatex(banka_ismi,127,"\rCSDURAGI | \wSERVER BANKASI^n\dMevcut Alabileceginiz Kredilerimiz! \d Eger odeme icin para toplayamazsaniz bir sonraki girisinizde alinacaktir.!")
	new menu = menu_create(banka_ismi,"bankredileri_devam")
	
	menu_additem(menu,"2500 TL Kredi \d | 20 Dk icerisinde Geri Odemeli","1",0)
	menu_additem(menu,"6000 TL\d | 60 dk icerisinde Geri Odemeli ","2",0)
	menu_additem(menu,"10000 TL \d | 120 Dk icerisinde Geri Odemeli","3",0)
	menu_additem(menu,"15000 TL \d | 140 Dk icerisinde Geri Odemeli","4",0)
	menu_additem(menu,"25000 TL \d | 180 Dk icerisinde Geri Odemeli","5",0)
	menu_additem(menu,"30000 TL \d | 200 Dk icerisinde Geri Odemeli","6",0)
		
	menu_setprop(menu,MPROP_EXIT,MEXIT_ALL)
	menu_display(id,menu,0)
	
	remove_task(2)

	return PLUGIN_HANDLED
	
}


public bankredileri_devam(id,menu,item)
{


	
	if(!is_user_connected(id) || !is_user_alive(id)) return PLUGIN_HANDLED
	
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED	
	}
	
	new acces,data2[24],iname[64],callback,data
	menu_item_getinfo(menu,item,acces,data2,23,iname,63,callback)
	data = str_to_num(data2)
	
	
	
	switch(data)
	{
		
		
		case 1:
		{
			set_task(1.0, "kredi_all2500",id)
		}
		case 2:
		{
			set_task(1.0, "kredi_all6000",id)
		}
		case 3:
		{		
			set_task(1.0, "kredi_all10000",id)
		}
		case 4:
		{		
		
			set_task(1.0, "kredi_all15000",id)
		}
		case 5:
		{
			set_task(1.0, "kredi_all25000",id)
		}
		case 6:
		{
			set_task(1.0, "kredi_all30000",id)
		}
		
		
	
	}
	return PLUGIN_HANDLED
}
	
		
public kredi_all2500(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}
	
	points[id] += 2500
	client_print(id,print_center,"Hesabiniza 2500 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 2500 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 20 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) + 1)
	
	set_task(1200.0,"kredi_tahsilat2500",id)
	
	
	
	return PLUGIN_HANDLED
}




public kredi_all6000(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}
	
	
	points[id] += 6000
	client_print(id,print_center,"Hesabiniza 6000 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 6000 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 60 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	


	set_task(3600.0,"kredi_tahsilat6000",id)
	
	return PLUGIN_HANDLED
}




public kredi_all10000(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}

	
	
	points[id] += 10000
	client_print(id,print_center,"Hesabiniza 10000 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 10000 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 120 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) + 2)
	
	set_task(7200.0,"kredi_tahsilat10000",id)
	return PLUGIN_HANDLED
}



public kredi_all15000(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}
	
	
	points[id] += 15000
	client_print(id,print_center,"Hesabiniza 15000 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 15000 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 140 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	


	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) + 3)

	set_task(8400.0,"kredi_tahsilat15000",id)
	
	return PLUGIN_HANDLED
}



public kredi_all25000(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}

	
	
	points[id] += 25000
	client_print(id,print_center,"Hesabiniza 25000 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 25000 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 180 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	
	

	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) + 4)
	
	set_task(10800.0,"kredi_tahsilat25000",id)
	
	return PLUGIN_HANDLED
}



public kredi_all30000(id)
{
	
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	if(kredikontrol_ammo(username[id]) > 0)
	{
	   
	 ColorChat( id, NORMAL, " %s Maalesef 1 Den Fazla Kredi Alamazsiniz..",bnkPrefix)
	}

	
	
	points[id] += 30000
	client_print(id,print_center,"Hesabiniza 30000 TL transfer edildi..")
	ColorChat( id, NORMAL, " %s Market Cuzdaniniza ^4 30000 TL ^3 Krediniz Yatirilmistir.!",bnkPrefix)
	ColorChat( id, NORMAL, " %s 200 Dk Sonra Kredi Tahsilatiniz Yapilacaktir. Oyundan ciktiginiz zaman giriste tahsil edilecektir.!",bnkPrefix)
	
	
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) + 5)
	

	
	
	set_task(12000.0,"kredi_tahsilat30000",id)
	
	return PLUGIN_HANDLED
}







// KREDILERI TAHSILATI


public kredi_tahsilat2500(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(points[id] < 2500)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 2500 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 20 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode2500 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat2500",id)
		return PLUGIN_HANDLED
	}
	
	
	points[id] -= 2500
	client_print(id,print_center,"Hesabinizdan 6000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 2500 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 1)
	
	
	
	return PLUGIN_HANDLED
}



public kredi_tahsilat6000(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(points[id] < 6000)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 6000 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 60 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode6000 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat6000",id)
		
		return PLUGIN_HANDLED
	}
	
	
	points[id] -= 6000
	client_print(id,print_center,"Hesabinizdan 6000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 6000 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 2)
	return PLUGIN_HANDLED
}





public kredi_tahsilat10000(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(points[id] < 10000)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 10000 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 120 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode10000 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat10000",id)
		return PLUGIN_HANDLED
		
		
	}
	
	
	points[id] -= 10000
	client_print(id,print_center,"Hesabinizdan 10000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 10000 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 3)
	
	return PLUGIN_HANDLED
}


public kredi_tahsilat15000(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(points[id] < 15000)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 15000 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 140 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode 15000 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat15000",id)
		
		return PLUGIN_HANDLED
	}
	
	
	points[id] -= 15000
	client_print(id,print_center,"Hesabinizdan 15000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 15000 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	

	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 4)

	return PLUGIN_HANDLED
}


public kredi_tahsilat25000(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		return PLUGIN_HANDLED
	
	if(points[id] < 25000)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 25000 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 180 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode 25000 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat25000",id)
		return PLUGIN_HANDLED
	}
	
	
	points[id] -= 25000
	client_print(id,print_center,"Hesabinizdan 25000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 25000 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 5)

	return PLUGIN_HANDLED
}




public kredi_tahsilat30000(id)
{
	new say[300]
	read_args(say, charsmax(say))
	
	remove_quotes(say)
	
	if(!is_str_num(say) || equal(say, "") || equal(username[id],"") || strlen(say) > 9)
		
	
	if(points[id] < 30000)
	{
		client_print(id,print_center,"Mevcut Paraniz Tahsilata Yetmemekte ( Gereken TL = 30000 TL )")
		ColorChat( id, NORMAL, " %s Tahsilat icin mevcut paraniz yetmemekte..! Tahsilat 200 Dakika sonra tekrar yapilacaktir.! (Gereken Puan = ^4 %d Puan^1)")
		ColorChat( id, NORMAL, " %s Eger Sureyi Beklemeden Odemek isterseniz say'a ^4/krediode 30000 ^3 Yazabilirsiniz..! ")
		set_task(1200.0,"kredi_tahsilat30000",id)
		return PLUGIN_HANDLED
	}
	
	
	points[id] -= 30000
	client_print(id,print_center,"Hesabinizdan 30000 TL tahsilat edilmistir")
	ColorChat( id, NORMAL, " %s Market Cuzdaninizdan ^4 30000 TL ^3 Krediniz Tahsilat Edilmistir",bnkPrefix)
	ColorChat( id, NORMAL, " %s Tahsilat icin gerekli zamana ozen gosterdiginiz icin tesekkur ederiz..!",bnkPrefix)
	
	kredi_hesap_ammo(username[id],kredikontrol_ammo(username[id]) - 6)

	
	
	
	return PLUGIN_HANDLED
}




public kredikontrol_ammo(userid[])
{
	new gData[64], gAmmoKey[64]
	formatex(gAmmoKey,63,"%s-TL",userid)
	nvault_get(kredivault,gAmmoKey,gData,63)
	return str_to_num(gData)
}

public kredi_hesap_ammo(userid[],miktar)
{
	new gAmmoKey[64], miktar2[128]
	num_to_str(miktar,miktar2,127)
	formatex(gAmmoKey,63,"%s-TL",userid)
	nvault_set(kredivault,gAmmoKey,miktar2)
	return 1
}







// TL TRANSFER MENU



	
new ananzaa[33]

public transfer_menu(id) {
    if( !is_user_alive(id) ) return PLUGIN_HANDLED
    new menu = menu_create("\yCSDURAGI | \rTL TRANSFER^n\d Birine TL gonderin.. \r| \dwww.redarmygaming.org", "transfer_case")
    
    menu_additem(menu, "\y5 \rTL TRANSFER", "1", 0);
    menu_additem(menu, "\y10 \rTL TRANSFER", "2", 0);
    menu_additem(menu, "\y20 \rTL TRANSFER", "3", 0);
    menu_additem(menu, "\y50 \rTL TRANSFER", "4", 0);
    menu_additem(menu, "\y100 \rTL TRANSFER", "5", 0);
    menu_additem(menu, "\y1000 \rTL TRANSFER", "6", 0);
    menu_additem(menu, "\y5000 \rTL TRANSFER", "7", 0);
    
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
    return PLUGIN_HANDLED
}

public transfer_case(id, menu, item)
{
    
    if( item == MENU_EXIT )
    {
        menu_destroy(menu);
        return PLUGIN_HANDLED;
    }
    
    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
    new key = str_to_num(data);
    new adminismi[32]
    get_user_name(id,adminismi,31)
    
    switch(key)
    {
        case 1: {
            ananzaa[id] = 5;
            OyuncuSec(id)
        }
        case 2: { 
            ananzaa[id] = 10;
            OyuncuSec(id)
        }
        case 3: { 
            ananzaa[id] = 20;
            OyuncuSec(id)
        }
        case 4: {
            ananzaa[id] = 50;
            OyuncuSec(id)
        }
        case 5: {
            ananzaa[id] = 100;
            OyuncuSec(id)
        }
        case 6: {
            ananzaa[id] = 1000;
            OyuncuSec(id)
        }
        case 7: {
            ananzaa[id] = 5000;
            OyuncuSec(id)
        }		
    }
    
    menu_destroy(menu);
    return PLUGIN_HANDLED;
}  


public OyuncuSec(id)
{
    new ad[32],sznum[6]
    new menu = menu_create("TRANSFER EDILECEK OYUNCU SECIN","OyuncuHand")
    for(new i = 1;i<=get_maxplayers();i++)
        if(is_user_connected(i))
    {
        num_to_str(i,sznum,5)
        get_user_name(i,ad,31)
        menu_additem(menu,ad,sznum)
    }
    menu_display(id,menu)
    return PLUGIN_HANDLED
}
public OyuncuHand(id,menu,item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu)
        return PLUGIN_HANDLED
    }
    new ad[32],callback,access,data[6]
    menu_item_getinfo(menu,item,access,data,5,ad,31,callback)
    new name[32];
    get_user_name(id,name,31)
    new tid = str_to_num(data)
    get_user_name(tid,ad,31)
    
    if(ananzaa[id] == 5)
    {
        if(points[id] >= 5) {
            points[id] -= 5
            points[tid] += 5
            ColorChat(id,NORMAL," %s %s Kisiye 5 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"%s %s Kisi Size 5 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
        }
        else {
            
            ColorChat(id,RED,"[%s] 5 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
        }
    }
    if(ananzaa[id] == 10)
    {
    if(points[id] >= 10) 
    {
    points[id] -= 10
    points[tid] += 10
    ColorChat(id,NORMAL,"%s %s Kisiye 10 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
    ColorChat(tid,NORMAL,"%s %s Kisi Size 10 TL TRANSFER ETTI.",bnkPrefix,name)
    ananzaa[id] = 0
    }
    else {
           
    ColorChat(id,RED,"%s 10 TL'Niz Bulunmamaktadir.",bnkPrefix)
    ananzaa[id] = 0
    }
    }
    ///
    if(ananzaa[id] == 20)
    {
        if(points[id] >= 20) {
            points[id] -= 20
            points[tid] += 20
            ColorChat(id,NORMAL,"[%s] %s Kisiye 20 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"[%s] %s Kisi Size 20 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
        }
        else {
            
            ColorChat(id,RED,"[%s] 20 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
        }
    }
    if(ananzaa[id] == 50)
    {
        if(points[id] >= 5) {
            points[id] -= 50
            points[tid] += 50
            ColorChat(id,NORMAL,"[%s] %s Kisiye 50 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"[%s] %s Kisi Size 50 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
        }
        else {
            
            ColorChat(id,RED,"[%s] 50 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
        }
    }
    if(ananzaa[id] == 100)
    {
        if(points[id] >= 100) {
            points[id] -= 1000
            points[tid] += 1000
            ColorChat(id,NORMAL,"[%s] %s Kisiye 100 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"[%s] %s Kisi Size 100 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
            
        }
        else {
            
            ColorChat(id,RED,"[%s] 100 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
            
        }
    }
    if(ananzaa[id] == 1000)
    {
        if(points[id] >= 1000) {
            points[id] -= 1000
            points[tid] += 1000
            ColorChat(id,NORMAL,"[%s] %s Kisiye 1000 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"[%s] %s Kisi Size 1000 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
            
        }
        else {
            
            ColorChat(id,RED,"[%s] 1000 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
            
        }
    }
    if(ananzaa[id] == 5000)
    {
        if(points[id] >= 100) {
            points[id] -= 5000
            points[tid] += 5000
            ColorChat(id,NORMAL,"[%s] %s Kisiye 5000 TL TRANSFER ETTINIZ.",bnkPrefix,ad)
            ColorChat(tid,NORMAL,"[%s] %s Kisi Size 5000 TL TRANSFER ETTI.",bnkPrefix,name)
            ananzaa[id] = 0
            
        }
        else {
            
            ColorChat(id,RED,"[%s] 5000 TL'Niz Bulunmamaktadir.",bnkPrefix)
            ananzaa[id] = 0
            
        }
    }
    
    return PLUGIN_HANDLED
}
