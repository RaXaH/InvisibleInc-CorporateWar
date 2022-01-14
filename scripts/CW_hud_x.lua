local inserts =
{
	{
		"hud.lua",
		{"widgets", 9, "children"},
		{
				name = [[guardPanel]],
				isVisible = true,
				noInput = false,
				anchor = 5,
				rotation = 0,
				x = 35,
				xpx = true,
				y = 188,
				ypx = true,
				w = 0,
				h = 0,
				sx = 1,
				sy = 1,
				ctor = [[group]],
				children =
				{
						{
								name = [[enemyAbility1]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -7,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility2]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -66,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility3]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -126,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility4]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -185,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility5]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -244,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility6]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -304,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility7]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -363,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
								name = [[enemyAbility8]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -253,
								xpx = true,
								y = -423,
								ypx = true,
								w = 0,
								h = 0,
								sx = 1,
								sy = 1,
								skin = [[EnemyAbility]],
						},
						{
							name = [[enemyAbility9]],
							isVisible = true,
							noInput = false,
							anchor = 1,
							rotation = 0,
							x = -253,
							xpx = true,
							y = -482,
							ypx = true,
							w = 0,
							h = 0,
							sx = 1,
							sy = 1,
							skin = [[EnemyAbility]],
						},
						{
							name = [[enemyAbility10]],
							isVisible = true,
							noInput = false,
							anchor = 1,
							rotation = 0,
							x = -253,
							xpx = true,
							y = -541,
							ypx = true,
							w = 0,
							h = 0,
							sx = 1,
							sy = 1,
							skin = [[EnemyAbility]],
						},
						{
							name = [[enemyAbility11]],
							isVisible = true,
							noInput = false,
							anchor = 1,
							rotation = 0,
							x = -253,
							xpx = true,
							y = -600,
							ypx = true,
							w = 0,
							h = 0,
							sx = 1,
							sy = 1,
							skin = [[EnemyAbility]],
						},
						{
							name = [[enemyAbility12]],
							isVisible = true,
							noInput = false,
							anchor = 1,
							rotation = 0,
							x = -253,
							xpx = true,
							y = -660,
							ypx = true,
							w = 0,
							h = 0,
							sx = 1,
							sy = 1,
							skin = [[EnemyAbility]],
						},
						{
							name = [[daemonScrollbar]],
							isVisible = false,
							noInput = false,
							anchor = 1,
							rotation = 0,
							x = -291,
							xpx = true,
							y = -202,
							ypx = true,
							w = 0,
							wpx = true,
							h = 468,
							hpx = true,
							sx = 1,
							sy = 1,
							skin = [[listbox_vscroll]],
						},
						{
							name = [[daemonScroller]],
							isVisible = false,
							noInput = true,
							anchor = 1,
							rotation = 0,
							x = -49,
							xpx = true,
							y = -250,
							ypx = true,
							w = 163,
							wpx = true,
							h = 468,
							hpx = true,
							sx = 1,
							sy = 1,
							ctor = [[image]],
							color =
							{
								0,
								0,
								0,
								0,
							},
							images =
							{
								{
									file = [[white.png]],
									name = [[]],
									color =
									{
										0,
										0,
										0,
										0,
									},
								},
							},
						},
						{
								name = [[daemonPnlTitle]],
								isVisible = true,
								noInput = false,
								anchor = 1,
								rotation = 0,
								x = -89,
								xpx = true,
								y = -4,
								ypx = true,
								w = 192,
								wpx = true,
								h = 21,
								hpx = true,
								sx = 1,
								sy = 1,
								ctor = [[label]],
								halign = MOAITextBox.RIGHT_JUSTIFY,
								valign = MOAITextBox.LEFT_JUSTIFY,
								text_style = [[font1_14_r]],
								color =
								{
										0.823529412,
										0.494117647,
										0,
										1,
								},
								str = [[STR_3797234799]],
						},
				},
		},
	},
	{
		"hud.lua",
		{"widgets", 9, "children"},
		{
			name = [[ControlPnl]],
			isVisible = true,
			noInput = false,
			anchor = 5,
			rotation = 0,
			x = 35,
			xpx = true,
			y = 145,
			ypx = true,
			w = 0,
			h = 0,
			sx = 1,
			sy = 1,
			ctor = [[group]],
			children =
			{
				{
					name = [[switchDaemonBtn]],
					isVisible = true,
					noInput = false,
					anchor = 1,
					rotation = 0,
					x = 24,
					xpx = true,
					y = -26,
					ypx = true,
					w = 20,
					wpx = true,
					h = 20,
					hpx = true,
					sx = 1,
					sy = 1,
					ctor = [[button]],
					clickSound = [[SpySociety/HUD/menu/click]],
					hoverSound = [[SpySociety/HUD/menu/rollover]],
					hoverScale = 1,
					halign = MOAITextBox.CENTER_JUSTIFY,
					valign = MOAITextBox.CENTER_JUSTIFY,
					text_style = [[]],
					images =
					{
						{
							file = [[gui/hud3/CW_daemon_red_btn_down.png]],
							name = [[inactive]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
						{
							file = [[gui/hud3/CW_daemon_red_btn_up.png]],
							name = [[hover]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
						{
							file = [[gui/hud3/CW_daemon_red_btn_up.png]],
							name = [[active]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
					},
				},
				{
					name = [[switchGuardBtn]],
					isVisible = true,
					noInput = false,
					anchor = 1,
					rotation = 0,
					x = 24,
					xpx = true,
					y = -46,
					ypx = true,
					w = 20,
					wpx = true,
					h = 20,
					hpx = true,
					sx = 1,
					sy = 1,
					ctor = [[button]],
					clickSound = [[SpySociety/HUD/menu/click]],
					hoverSound = [[SpySociety/HUD/menu/rollover]],
					hoverScale = 1,
					halign = MOAITextBox.CENTER_JUSTIFY,
					valign = MOAITextBox.CENTER_JUSTIFY,
					text_style = [[]],
					images =
					{
						{
							file = [[gui/hud3/CW_daemon_yellow_btn_down.png]],
							name = [[inactive]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
						{
							file = [[gui/hud3/CW_daemon_yellow_btn_up.png]],
							name = [[hover]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
						{
							file = [[gui/hud3/CW_daemon_yellow_btn_up.png]],
							name = [[active]],
							color =
							{
								1,
								1,
								1,
								1,
							},
						},
					},
				},
			},
		},
	},
}

return inserts