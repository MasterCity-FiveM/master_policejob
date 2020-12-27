Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society

Config.EnableESXService           = false -- enable esx service?
Config.MaxInService               = 30

Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 53
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Jail = {
			vector3(725.3011, 133.767, 80.94141)
		},
		
		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.Uniforms = {
	bullet_wear = {
		male = {
			bproof_1 = 12,  bproof_2 = 3
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	
	unbullet_wear = {
		male = {
			bproof_1 = 0,  bproof_2 = 0
		},
		female = {
			bproof_1 = 0,  bproof_2 = 0
		}
	}
}

Config.SubJobUniforms = {
	VIZHE = {
		{
			label = "یگان ویژه 1",
			model = {
				male = {
					tshirt_1 = 53,  tshirt_2 = 1,
					torso_1 = 49,   torso_2 = 2,
					decals_1 = 3,   decals_2 = 0,
					arms = 38,
					pants_1 = 31,   pants_2 = 2,
					shoes_1 = 25,   shoes_2 = 0,
					mask_1  = 52,    mask_2  = 0,
					bproof_1  = 16, bproof_2  = 0,
					helmet_1 = 117,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 24,     glasses_2 = 2
				},
				female = {
					tshirt_1 = 51,  tshirt_2 = 0,
					torso_1 = 48,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 31,
					pants_1 = 34,   pants_2 = 0,
					shoes_1 = 52,   shoes_2 = 0,
					helmet_1 = 10,  helmet_2 = 2,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0
				}
			}
		}
	},
	ZARBAT = {
		{
			label = "گروه ضربت 1",
			model = {
				male = {
					tshirt_1 = 15,  tshirt_2 = 0,
					torso_1 = 53,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 38,
					pants_1 = 37,   pants_2 = 0,
					shoes_1 = 25,   shoes_2 = 0,
					mask_1  = 130,    mask_2  = 0,
					bproof_1  = 15, bproof_2  = 2,
					helmet_1 = 117,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 51,  tshirt_2 = 0,
					torso_1 = 48,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 31,
					pants_1 = 34,   pants_2 = 0,
					shoes_1 = 52,   shoes_2 = 0,
					helmet_1 = 10,  helmet_2 = 2,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0
				}
			}
		}
	}
}

Config.CustomUniforms = {
	sarbaz = {
		{
			label = "لباس سرباز",
			model = {
				male = {
					tshirt_1 = 44,  tshirt_2 = 0,
					torso_1 = 55,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 30,
					pants_1 = 35,   pants_2 = 0,
					shoes_1 = 15,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 23,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = 46,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 51,  tshirt_2 = 0,
					torso_1 = 48,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 31,
					pants_1 = 34,   pants_2 = 0,
					shoes_1 = 52,   shoes_2 = 0,
					helmet_1 = 10,  helmet_2 = 2,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0
				}
			}
		}
	},

	sotvan = {
		{
			label = "لباس پلیس 1",
			model = {
				male = {
					tshirt_1 = 38,  tshirt_2 = 0,
					torso_1 = 102,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 19,
					pants_1 = 52,   pants_2 = 1,
					shoes_1 = 24,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 0,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	},
	
	sarvan = {
		{
			label = "لباس پلیس 2",
			model = {
				male = {
					tshirt_1 = 37,  tshirt_2 = 0,
					torso_1 = 101,   torso_2 = 0,
					decals_1 = 11,   decals_2 = 0,
					arms = 38,
					pants_1 = 52,   pants_2 = 1,
					shoes_1 = 24,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 35,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	},

	sargord = {
		{
			label = "لباس پلیس 3",
			model = {
				male = {
					tshirt_1 = 56,  tshirt_2 = 0,
					torso_1 = 101,   torso_2 = 0,
					decals_1 = 12,   decals_2 = 3,
					arms = 38,
					pants_1 = 52,   pants_2 = 1,
					shoes_1 = 24,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 179,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = 10,  helmet_2 = 6,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	},
	
	sarhang = {
		{
			label = "لباس پلیس 4",
			model = {
				male = {
					tshirt_1 = 54,  tshirt_2 = 0,
					torso_1 = 12,   torso_2 = 6,
					decals_1 = 12,   decals_2 = 6,
					arms = 38,
					pants_1 = 28,   pants_2 = 0,
					shoes_1 = 10,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 0,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = 28,  helmet_2 = 1,
					chain_1 = 28,    chain_2 = 2,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	},
	
	janeshinf = {
		{
			label = "لباس جانشین فرماندهی",
			model = {
				male = {
					tshirt_1 = 20,  tshirt_2 = 1,
					torso_1 = 12,   torso_2 = 1,
					decals_1 = 11,   decals_2 = 4,
					arms = 38,
					pants_1 = 28,   pants_2 = 0,
					shoes_1 = 10,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 52,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 28,    chain_2 = 2,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	},

	boss = {
		{
			label = "لباس فرمانده",
			model = {
				male = {
					tshirt_1 = 130,  tshirt_2 = 0,
					torso_1 = 12,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 38,
					pants_1 = 28,   pants_2 = 0,
					shoes_1 = 10,   shoes_2 = 0,
					mask_1  = 0,    mask_2  = 52,
					bproof_1  = 12, bproof_2  = 3,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 28,    chain_2 = 2,
					ears_1 = 0,     ears_2 = 0,
					glasses_1 = 0,     glasses_2 = 0
				},
				female = {
					tshirt_1 = 33,  tshirt_2 = 0,
					torso_1 = 92,   torso_2 = 0,
					decals_1 = 0,   decals_2 = 0,
					arms = 26,
					pants_1 = 47,   pants_2 = 0,
					shoes_1 = 27,   shoes_2 = 0,
					helmet_1 = -1,  helmet_2 = 0,
					chain_1 = 0,    chain_2 = 0,
					ears_1 = 2,     ears_2 = 0
				}
			}
		}
	}
}

