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
Config.HandcuffTimer              = 30 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society

Config.EnableESXService           = true -- enable esx service?
Config.MaxInService               = 100

Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 53,
			name = 'Edare Police'
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
		}
	}
}

Config.SheriffStation = {

	Sheriff = {

		Blip = {
			Coords  = vector3(1857.666, 3677.763, 33.72),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 69,
			name = 'Kalantari'
		},

		Cloakrooms = {
			vector3(1859.196, 3695.222, 34.23364)
		},

		Armories = {
			vector3(1861.411, 3690.369, 34.25061)
		},

		Jail = {
			vector3(725.3011, 133.767, 80.94141)
		},
		
		Vehicles = {
			{
				Spawner = vector3(1855.332, 3679.279, 33.77881),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(1853.09, 3676.958, 33.77881), heading = 90.0, radius = 6.0},
					{coords = vector3(1849.991, 3675.099, 33.77881), heading = 90.0, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1862.519, 3664.708, 33.94727),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(1869.376, 3676.035, 35.37952), heading = 92.6, radius = 10.0}
				}
			}
		}
	}
}

Config.FBIStation = {

	FBI = {

		Blip = {
			Coords  = vector3(93.67912, -742.7604, 45.74219),
			Sprite  = 468,
			Display = 4,
			Scale   = 0.8,
			Colour  = 78,
			name = 'Police Amniat'
		},

		Cloakrooms = {
			vector3(143.4725, -764.3472, 242.1436)
		},

		Armories = {
			vector3(151.6615, -736.1407, 242.1436)
		},

		Jail = {
			vector3(725.3011, 133.767, 80.94141)
		},
		
		Vehicles = {
			{
				Spawner = vector3(96.35605, -723.5736, 33.12158),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(96.17143, -728.9011, 33.12158), heading = 90.0, radius = 6.0},
					{coords = vector3(99.85056, -730.444, 33.12158), heading = 90.0, radius = 6.0}
				}
			}
		},
		
		FastTravelsPrompt = {
			{
				From = vector3(136.0615, -761.8022, 45.74219),
				To = { coords = vector3(136.1143, -761.8681, 242.1436), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(136.1143, -761.8681, 242.1436),
				To = { coords = vector3(136.0615, -761.8022, 45.74219), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(138.8957, -762.8307, 45.74219),
				To = { coords = vector3(2155.16, 2920.945, -61.91138), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(2155.16, 2920.945, -61.91138),
				To = { coords = vector3(138.8957, -762.8307, 45.74219), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			}
		}
	}
}

Config.JusticeStation = {

	Justice = {

		Blip = {
			Coords  = vector3(243.178, -1071.336, 29.27991),
			Sprite  = 409,
			Display = 4,
			Scale   = 0.1,
			Colour  = 15,
			name = 'DadSetani'
		},

		Cloakrooms = {
			vector3(248.1494, -1095.626, 36.1377)
		},

		Armories = {
			vector3(252.9099, -1097.552, 36.1377)
		},

		Jail = {
			vector3(725.3011, 133.767, 80.94141)
		},
		
		Vehicles = {
			{
				Spawner = vector3(235.8462, -1072.629, 29.27991),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(222.6725, -1079.222, 29.26306), heading = 90.0, radius = 6.0},
					{coords = vector3(222.5538, -1090.536, 29.24609), heading = 90.0, radius = 6.0}
				}
			}
		},
		
		FastTravelsPrompt = {
			{
				From = vector3(255.244, -1083.956, 36.12085),
				To = { coords = vector3(255.1253, -1083.943, 29.27991), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(255.1253, -1083.943, 29.27991),
				To = { coords = vector3(255.244, -1083.956, 36.12085), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			}
		}
	}
}


Config.Uniforms = {
	police = {
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
	},
	sheriff = {
		bullet_wear = {
			male = {
				bproof_1 = 12,  bproof_2 = 2
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
	},
	fbi = {
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
	},
	dadsetani = {
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
}

Config.SubJobUniforms = {
	police = {
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
			},
			{
				label = "یگان ویژه 2",
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
		},
		ZARBAT = {
			{
				label = "گروه ضربت 1",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 49,   torso_2 = 4,
						decals_1 = 5,   decals_2 = 0,
						arms = 38,
						pants_1 = 87,   pants_2 = 10,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 10,
						bproof_1  = 7, bproof_2  = 0,
						helmet_1 = 59,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 0
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
			},
			{
				label = "گروه ضربت 2",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 139,   torso_2 = 3,
						decals_1 = 0,   decals_2 = 0,
						arms = 27,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 7, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 2,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 6
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
	},
	
	sheriff = {
		VIZHE = {
			{
				label = "یگان ویژه 1",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 49,   torso_2 = 1,
						decals_1 = 4,   decals_2 = 0,
						arms = 38,
						pants_1 = 31,   pants_2 = 1,
						shoes_1 = 35,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 3,
						bproof_1  = 27, bproof_2  = 0,
						helmet_1 = 75,  helmet_2 = 1,
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
			},
			{
				label = "یگان ویژه 2",
				model = {
					male = {
						tshirt_1 = 0,  tshirt_2 = 0,
						torso_1 = 53,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 37,   pants_2 = 2,
						shoes_1 = 35,   shoes_2 = 0,
						mask_1  = 57,    mask_2  = 1,
						bproof_1  = 27, bproof_2  = 0,
						helmet_1 = 59,  helmet_2 = 1,
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
		ZARBAT = {
			{
				label = "گروه ضربت 1",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 49,   torso_2 = 4,
						decals_1 = 5,   decals_2 = 0,
						arms = 38,
						pants_1 = 87,   pants_2 = 10,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 10,
						bproof_1  = 7, bproof_2  = 0,
						helmet_1 = 59,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 0
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
			},
			{
				label = "گروه ضربت 2",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 139,   torso_2 = 3,
						decals_1 = 0,   decals_2 = 0,
						arms = 27,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 7, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 2,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 6
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
	},
	fbi = {},
	dadsetani = {}
}

Config.CustomUniforms = {
	police = {
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
	},
	sheriff = {
		sarbaz = {
			{
				label = "لباس سرباز",
				model = {
					male = {
						tshirt_1 = 38,  tshirt_2 = 0,
						torso_1 = 100,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 74,
						pants_1 = 25,   pants_2 = 0,
						shoes_1 = 15,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 23,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = -1,  helmet_2 = 0,
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
						tshirt_1 = 37,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 75,
						pants_1 = 25,   pants_2 = 2,
						shoes_1 = 15,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
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
						tshirt_1 = 54,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 11,   decals_2 = 0,
						arms = 75,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = 13,  helmet_2 = 0,
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
						tshirt_1 = 55,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 11,   decals_2 = 3,
						arms = 75,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = 13,  helmet_2 = 0,
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
						tshirt_1 = 129,  tshirt_2 = 0,
						torso_1 = 94,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						pants_1 = 52,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = 10,  helmet_2 = 7,
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
		
		janeshinf = {
			{
				label = "لباس جانشین فرماندهی",
				model = {
					male = {
						tshirt_1 = 122,  tshirt_2 = 0,
						torso_1 = 12,   torso_2 = 10,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = 13,  helmet_2 = 0,
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
						pants_1 = 28,   pants_2 = 5,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 12, bproof_2  = 2,
						helmet_1 = 13,  helmet_2 = 3,
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
	},
	fbi = {},
	dadsetani = {}
}

