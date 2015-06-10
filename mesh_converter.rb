def lonlat2mesh(x,y,meshsize)

	y = y.to_f * 1.5
	x = x.to_f - 100
	
	mesh1_y = y.to_i
	mesh1_x = x.to_i
	
	tmp_y = (y - mesh1_y)/(10.0/8.0)
	tmp_x = (x - mesh1_x)/(10.0/8.0)
	
	mesh2_y = (tmp_y * 10).to_i
	mesh2_x = (tmp_x * 10).to_i
	
	tmp_y = (tmp_y * 10 - mesh2_y)
	tmp_x = (tmp_x * 10 - mesh2_x)
	
	mesh3_y = (tmp_y * 10).to_i
	mesh3_x = (tmp_x * 10).to_i
	
	tmp_y = (tmp_y * 10 - mesh3_y)
	tmp_x = (tmp_x * 10 - mesh3_x)
	
	if tmp_y >= 0.5
		if tmp_x >= 0.5
			mesh4 = 4
			tmp_x -= 0.5
		else
			mesh4 = 3
		end
		tmp_y -= 0.5
	else
		if tmp_x >= 0.5
			mesh4 = 2
			tmp_x -= 0.5
		else
			mesh4 = 1
		end
	end
	
	if meshsize == 250 or meshsize == 50
		div_y = tmp_y.div(0.25)
		div_x = tmp_x.div(0.25)
		
		mesh5 = div_x + div_y * 2 + 1
		tmp_x -= 0.25 if tmp_x > 0.25
		tmp_y -= 0.25 if tmp_y > 0.25
			
		if meshsize == 50
		#puts tmp_y,tmp_x
			div_y = tmp_y.div(0.05)
			div_x = tmp_x.div(0.05)
			
			mesh50 = div_x + div_y * 5 + 1
			mesh50 = "0" + mesh50.to_s if mesh50.to_i < 10
		end
		
	elsif meshsize == 100
		div_y = tmp_y.div(0.1)
		div_x = tmp_x.div(0.1)
		
		mesh100 = div_x + div_y * 5 + 1
		mesh100 = "0" + mesh100.to_s if mesh100.to_i < 10
	end

	
	if meshsize == 250
		result = mesh1_y.to_s + mesh1_x.to_s + mesh2_y.to_s + mesh2_x.to_s + mesh3_y.to_s + mesh3_x.to_s + mesh4.to_s + mesh5.to_s #10
	elsif meshsize == 100
		result = mesh1_y.to_s + mesh1_x.to_s + mesh2_y.to_s + mesh2_x.to_s + mesh3_y.to_s + mesh3_x.to_s + mesh4.to_s + mesh100.to_s #11
	elsif meshsize == 50
		result = mesh1_y.to_s + mesh1_x.to_s + mesh2_y.to_s + mesh2_x.to_s + mesh3_y.to_s + mesh3_x.to_s + mesh4.to_s + mesh5.to_s + mesh50.to_s #12
	else
		result = mesh1_y.to_s + mesh1_x.to_s + mesh2_y.to_s + mesh2_x.to_s + mesh3_y.to_s + mesh3_x.to_s + mesh4.to_s
	end
	#puts mesh1_y.to_s, mesh1_x.to_s, mesh2_y.to_s, mesh2_x.to_s, mesh3_y.to_s, mesh3_x.to_s, mesh4.to_s

	return result

end

def mesh2lonlat(mesh, meshsize)

	mesh1_y = mesh[0,2].to_f / 1.5
	mesh1_x = mesh[2,2].to_f + 100
	mesh2_y = mesh[4,1].to_f * 5
	mesh2_x = mesh[5,1].to_f * 7.5
	mesh3_y = mesh[6,1].to_f * 30
	mesh3_x = mesh[7,1].to_f * 45
	mesh4 = mesh[8,1].to_i
	
	if mesh4 == 1
		mesh4_y = 30.0 * 0
		mesh4_x = 45.0 * 0
	elsif mesh4 == 2
		mesh4_y = 30.0 * 0
		mesh4_x = 45.0 * 0.5
	elsif mesh4 == 3
		mesh4_y = 30.0 * 0.5
		mesh4_x = 45.0 * 0
	else
		mesh4_y = 30.0 * 0.5
		mesh4_x = 45.0 * 0.5
	end
	center_y = 7.5
	center_x = 11.25
	
	if meshsize == 250 or meshsize == 50
		mesh5 = mesh[9,1].to_i - 1
		div5 = mesh5.divmod(2)
		div_y = div5[0]
		div_x = div5[1]
		mesh5_y = 7.5 * div_y.to_f
		mesh5_x = 11.25 * div_x.to_f
		center_y = 3.75
		center_x = 5.55

		if meshsize == 50
			mesh50 = mesh[10,2].to_i - 1
			div50 = mesh50.divmod(5)
			div_y = div50[0]
			div_x = div50[1]
			mesh50_y = 1.5 * div_y.to_f
			mesh50_x = 2.25 * div_x.to_f
			center_y = 0.75
			center_x = 1.125
		end
		
	end
	
	if meshsize == 	100
		mesh100 = mesh[9,2].to_i - 1
		div100 = mesh100.divmod(5)
		div_y = div100[0]
		div_x = div100[1]
		mesh100_y = 3.0 * div_y.to_f
		mesh100_x = 4.5 * div_x.to_f
		center_y = 1.5
		center_x = 2.25
	end
	
	if meshsize == 500
		lat = (mesh1_y * 3600 + mesh2_y * 60 + mesh3_y + mesh4_y + center_y).to_f / 3600
		lon = (mesh1_x * 3600 + mesh2_x * 60 + mesh3_x + mesh4_x + center_x).to_f / 3600
	elsif meshsize == 250
		lat = (mesh1_y * 3600 + mesh2_y * 60 + mesh3_y + mesh4_y + mesh5_y + center_y).to_f / 3600
		lon = (mesh1_x * 3600 + mesh2_x * 60 + mesh3_x + mesh4_x + mesh5_x + center_x).to_f / 3600
	elsif meshsize == 100
		lat = (mesh1_y * 3600 + mesh2_y * 60 + mesh3_y + mesh4_y + mesh100_y + center_y).to_f / 3600
		lon = (mesh1_x * 3600 + mesh2_x * 60 + mesh3_x + mesh4_x + mesh100_x + center_x).to_f / 3600
	elsif meshsize == 50
		lat = (mesh1_y * 3600 + mesh2_y * 60 + mesh3_y + mesh4_y + mesh5_y + mesh50_y + center_y).to_f / 3600
		lon = (mesh1_x * 3600 + mesh2_x * 60 + mesh3_x + mesh4_x + mesh5_x + mesh50_x + center_x).to_f / 3600
	else
		lat = (mesh1_y * 3600 + mesh2_y * 60 + mesh3_y + mesh4_y + center_y).to_f / 3600
		lon = (mesh1_x * 3600 + mesh2_x * 60 + mesh3_x + mesh4_x + center_x).to_f / 3600
	end

	return lat,lon
end