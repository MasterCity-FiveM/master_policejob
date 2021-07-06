Config                            = {}
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

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires master_society

Config.EnableESXService           = true -- enable esx service?
Config.MaxInService               = 100

Config.Locale                     = 'en'

Config.JobAllowedCars = {
	GetHashKey('polmav'),
	GetHashKey('prevolter'),
	GetHashKey('jtdurus2'),
	GetHashKey('21hoe'),
	GetHashKey('policeb'),
	GetHashKey('police3'),
	GetHashKey('2015polstang'),
	GetHashKey('polgs350'),
	GetHashKey('polmp4'),
	GetHashKey('wmfenyrcop'),
	GetHashKey('riot'),
	GetHashKey('insSWAT'),
	GetHashKey('insSAS'),
	GetHashKey('anpc_l200'),
	GetHashKey('polgs350sh'),
	GetHashKey('polmp4sh'),
	GetHashKey('wmfenyrcopsh'),
	GetHashKey('sheriff'),
	GetHashKey('sheriff2'),
	GetHashKey('police'),
	GetHashKey('police2'),
	GetHashKey('police3'),
	GetHashKey('police4'),
}

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

		BossActions = {
			vector3(450.5275, -975.4418, 30.67834)
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
				Spawner = vector3(449.5, -981.2, 43.6),
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
		
		BossActions = {
			vector3(1852.391, 3690.29, 34.19995)
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
				Spawner = vector3(1854.079, 3675.257, 33.00366),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(1854.237, 3675.31, 33.00366), heading = 215.0, radius = 6.0},
					{coords = vector3(1847.538, 3671.644, 32.98682), heading = 209.0, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1869.363, 3675.956, 35.37952),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(1869.363, 3675.956, 35.37952), heading = 116.346454620361, radius = 10.0}
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
		
		BossActions = {
			vector3(148.9978, -758.3736, 242.1436)
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
				Spawner = vector3(94.35165, -716.5319, 33.12158),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(96.17143, -728.9011, 33.12158), heading = 340.0, radius = 6.0},
					{coords = vector3(103.85056, -730.444, 33.12158), heading = 340.0, radius = 6.0}
				}
			}
		},
		
		Helicopters = {
			{
				Spawner = vector3(-75.20439, -818.7165, 326.1736),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(-75.42857, -819.1912, 326.1736), heading = 308.97637, radius = 10.0}
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
			},
			{
				From = vector3(78.1055, -702.211, 31.82422),
				To = { coords = vector3(140.9934, -765.9692, 45.74219), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(140.9934, -765.9692, 45.74219),
				To = { coords = vector3(78.1055, -702.211, 31.82422), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(139.3714, -770.611, 45.74219),
				To = { coords = vector3(-75.53406, -824.9275, 321.2872), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
			},
			{
				From = vector3(-75.53406, -824.9275, 321.2872),
				To = { coords = vector3(139.3714, -770.611, 45.74219), heading = 0.0 },
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
		
		BossActions = {
			vector3(238.0352, -1100.229, 36.12085)
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
				Spawner = vector3(240.8835, -1061.499, 29.1787),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(222.6725, -1079.222, 29.26306), heading = 357.0, radius = 6.0},
					{coords = vector3(222.5538, -1090.536, 29.24609), heading = 357.0, radius = 6.0}
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
				bproof_1 = 19,  bproof_2 = 0
			},
			female = {
				bproof_1 = 19,  bproof_2 = 0
			}
		},
		
		bullet_wear2 = {
			male = {
				bproof_1 = 16,  bproof_2 = 0
			},
			female = {
				bproof_1 = 16,  bproof_2 = 0
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
				bproof_1 = 19,  bproof_2 = 1
			},
			female = {
				bproof_1 = 19,  bproof_2 = 1
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
				bproof_1 = 39,  bproof_2 = 0
			},
			female = {
				bproof_1 = 39,  bproof_2 = 0
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
						tshirt_1 = 15,  tshirt_2 = 1,
						torso_1 = 49,   torso_2 = 2,
						decals_1 = 5,   decals_2 = 0,
						arms = 31,
						pants_1 = 59,   pants_2 = 0,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 0,
						bproof_1  = 16, bproof_2  = 0,
						helmet_1 = 117,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
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
						tshirt_1 = 122,  tshirt_2 = 0,
						torso_1 = 93,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						pants_1 = 59,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 10,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 117,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 1
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
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 59,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 161,  tshirt_2 = 0,
						torso_1 = 327,   torso_2 = 8,
						decals_1 = -1,   decals_2 = 0,
						arms = 36,
						pants_1 = 37,   pants_2 = 0,
						shoes_1 = 29,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 59,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 15,     glasses_2 = 0
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
						bproof_1  = 19, bproof_2  = 0,
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
						bproof_1  = 19, bproof_2  = 1,
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
						bproof_1  = 19, bproof_2  = 1,
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
						torso_1 = 94,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 74,
						pants_1 = 28,   pants_2 = 4,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 58,  helmet_2 = 0,
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
						tshirt_1 = 122,  tshirt_2 = 0,
						torso_1 = 94,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 74,
						pants_1 = 59,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 10,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 117,  helmet_2 = 1,
						chain_1 = 1,    chain_2 = 0,
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
	fbi = {
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
						bproof_1  = 39, bproof_2  = 0,
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
						bproof_1  = 39, bproof_2  = 0,
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
						torso_1 = 94,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 74,
						pants_1 = 28,   pants_2 = 4,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 0,
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
						tshirt_1 = 122,  tshirt_2 = 0,
						torso_1 = 94,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 74,
						pants_1 = 59,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 52,    mask_2  = 10,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 117,  helmet_2 = 1,
						chain_1 = 1,    chain_2 = 0,
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
	dadsetani = {}
}

Config.CustomUniforms = {
	police = {
		sarbaz = {
			{
				label = "لباس سرباز",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 93,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						bags_1 = -1, bags_2 = 0,
						pants_1 = 59,   pants_2 = 0,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 48,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 31,
						pants_1 = 34,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},

		sotvan = {
			{
				label = "لباس پلیس 1",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 102,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						bags_1 = -1, bags_2 = 0,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 16, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 27,  tshirt_2 = 0,
						torso_1 = 93,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 31,
						pants_1 = 54,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 10,  helmet_2 = 2,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		
		sarvan = {
			{
				label = "لباس پلیس 2",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 102,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						bags_1 = -1, bags_2 = 0,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 16, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 31,  tshirt_2 = 0,
						torso_1 = 92,   torso_2 = 2,
						decals_1 = 10,   decals_2 = 0,
						arms = 39,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 10,  helmet_2 = 2,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},

		sargord = {
			{
				label = "لباس پلیس 3",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 102,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						bags_1 = -1, bags_2 = 0,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 16, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 38,  tshirt_2 = 0,
						torso_1 = 102,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 19,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					}
				}
			}
		},
		
		sarhang = {
			{
				label = "لباس پلیس 4",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 102,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						bags_1 = -1, bags_2 = 0,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 24,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 106,  helmet_2 = 20,
						chain_1 = 1,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 84,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 31,
						pants_1 = 31,   pants_2 = 1,
						shoes_1 = 9,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 28,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		
		janeshinf = {
			{
				label = "لباس جانشین فرماندهی",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 12,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 33,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 28,    chain_2 = 2,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 5,     glasses_2 = 5
					},
					female = {
						tshirt_1 = 152,  tshirt_2 = 0,
						torso_1 = 86,   torso_2 = 1,
						decals_1 = 0,   decals_2 = 0,
						arms = 41,
						pants_1 = 23,   pants_2 = 12,
						shoes_1 = 28,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 2,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},

		boss = {
			{
				label = "لباس فرمانده",
				model = {
					male = {
						tshirt_1 = 21,  tshirt_2 = 0,
						torso_1 = 4,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 33,
						bags_1 = 58, bags_2 = 1,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 52,
						bproof_1  = -1, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 5,     ears_2 = 5,
						glasses_1 = 5,     glasses_2 = 5
					},
					female = {
						tshirt_1 = 38,  tshirt_2 = 0,
						torso_1 = 339,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 36,
						pants_1 = 37,   pants_2 = 0,
						shoes_1 = 29,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 86,    chain_2 = 1,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
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
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 44,   torso_2 = 1,
						decals_1 = 0,   decals_2 = 0,
						arms = 96,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},

		sotvan = {
			{
				label = "لباس شریف 1",
				model = {
					male = {
						tshirt_1 = 37,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 75,
						pants_1 = 25,   pants_2 = 2,
						shoes_1 = 15,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 33,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 96,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		
		sarvan = {
			{
				label = "لباس شریف 2",
				model = {
					male = {
						tshirt_1 = 54,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 11,   decals_2 = 0,
						arms = 75,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 13,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 40,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 53,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},

		sargord = {
			{
				label = "لباس شریف 3",
				model = {
					male = {
						tshirt_1 = 55,  tshirt_2 = 0,
						torso_1 = 99,   torso_2 = 0,
						decals_1 = 11,   decals_2 = 3,
						arms = 75,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 13,  helmet_2 = 0,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 85,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 96,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		
		sarhang = {
			{
				label = "لباس شریف 4",
				model = {
					male = {
						tshirt_1 = 129,  tshirt_2 = 0,
						torso_1 = 94,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						pants_1 = 52,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 10,  helmet_2 = 7,
						chain_1 = 0,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 85,   torso_2 = 1,
						decals_1 = 0,   decals_2 = 0,
						arms = 96,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
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
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 13,  helmet_2 = 0,
						chain_1 = 28,    chain_2 = 2,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 34,  tshirt_2 = 0,
						torso_1 = 90,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 92,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
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
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = 13,  helmet_2 = 3,
						chain_1 = 28,    chain_2 = 2,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 32,  tshirt_2 = 0,
						torso_1 = 40,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 92,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 19, bproof_2  = 1,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = 11,     glasses_2 = 1
					}
				}
			}
		}
	},
	fbi = {
		agent = {
			{
				label = "لباس مامور",
				model = {
					male = {
						tshirt_1 = 28,  tshirt_2 = 0,
						torso_1 = 35,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = 10,  helmet_2 = 4,
						chain_1 = 0,    chain_2 = 38,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 23,  tshirt_2 = 1,
						torso_1 = 179,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 26,
						pants_1 = 6,   pants_2 = 0,
						shoes_1 = 28,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = -1, bproof_2  = 0,
						helmet_1 = 10,  helmet_2 = 3,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		specialagent = {
			{
				label = "لباس مامور ویژه",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 51,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 2,
						chain_1 = 6,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 44,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 31,
						pants_1 = 54,   pants_2 = 1,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 10,  helmet_2 = 3,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		janeshinf = {
			{
				label = "لباس جانشین فرمانده",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 193,   torso_2 = 12,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 24,   pants_2 = 2,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 28,  helmet_2 = 0,
						chain_1 = 6,    chain_2 = 0,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 202,   torso_2 = 11,
						decals_1 = 0,   decals_2 = 0,
						arms = 27,
						pants_1 = 61,   pants_2 = 0,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 28,  helmet_2 = 1,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		},
		boss = {
			{
				label = "لباس فرمانده",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 13,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 37,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 0,
						chain_1 = 21,    chain_2 = 1,
						ears_1 = 0,     ears_2 = 0,
						glasses_1 = 0,     glasses_2 = 0
					},
					female = {
						tshirt_1 = 14,  tshirt_2 = 1,
						torso_1 = 332,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 28,
						pants_1 = 54,   pants_2 = 3,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = -1,    mask_2  = 0,
						bproof_1  = 39, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 0,
						chain_1 = -1,    chain_2 = 0,
						ears_1 = -1,     ears_2 = 0,
						glasses_1 = -1,     glasses_2 = 0
					}
				}
			}
		}
	},
	dadsetani = {
		bodyguard = {
			{
				label = "لباس بادیگارد",
				model = {
					male = {
						tshirt_1 = 15,  tshirt_2 = 0,
						torso_1 = 73,   torso_2 = 2,
						decals_1 = 0,   decals_2 = 0,
						arms = 30,
						pants_1 = 52,   pants_2 = 1,
						shoes_1 = 25,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 23,
						bproof_1  = 6, bproof_2  = 0,
						helmet_1 = 58,  helmet_2 = 2,
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
		vakil1 = {
			{
				label = "لباس وکیل",
				model = {
					male = {
						tshirt_1 = 31,  tshirt_2 = 0,
						torso_1 = 29,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 28,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 28,    chain_2 = 4,
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
		vakil2 = {
			{
				label = "لباس وکیل 2",
				model = {
					male = {
						tshirt_1 = 31,  tshirt_2 = 0,
						torso_1 = 29,   torso_2 = 6,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 24,   pants_2 = 6,
						shoes_1 = 20,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 28,    chain_2 = 10,
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
		ghazi = {
			{
				label = "لباس قاضی",
				model = {
					male = {
						tshirt_1 = 33,  tshirt_2 = 0,
						torso_1 = 142,   torso_2 = 0,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 24,   pants_2 = 0,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 28,    chain_2 = 15,
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
		dadsetan = {
			{
				label = "لباس دادستان",
				model = {
					male = {
						tshirt_1 = 31,  tshirt_2 = 0,
						torso_1 = 29,   torso_2 = 1,
						decals_1 = 0,   decals_2 = 0,
						arms = 38,
						pants_1 = 24,   pants_2 = 1,
						shoes_1 = 10,   shoes_2 = 0,
						mask_1  = 0,    mask_2  = 0,
						bproof_1  = 0, bproof_2  = 0,
						helmet_1 = -1,  helmet_2 = 0,
						chain_1 = 10,    chain_2 = 0,
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
}

