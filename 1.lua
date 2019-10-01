module(...,package.seeall)

local m, vs, col
function setup()
	m = sphere()
	fgu:add(meshnode(m))
	vs = vertexlist(m)
	
	n = sphere()
	fgu:add(meshnode(n))
	ns = vertexlist(n)
	
	q = sphere()
	fgu:add(meshnode(q))
	qs = vertexlist(q)
end

function update(dt)		
	each(vs, function(v)
		pos = v:getPos()
		v.c = col(pos.x,pos.y,pos.z,fgu.t)
		local vp = v.p
		v.p = v.p + get_flux(vp.x-vp.y,vp.x*vp.y,vp.z,fgu.t)
	end)
		
	each(ns, function(v)
		pos = v:getPos()
		v.c = col(pos.x,pos.y,pos.z,fgu.t)
		local vp = v.p
		v.p = v.p - get_flux(vp.x+vp.y*math.random(),vp.x-vp.y,vp.z,fgu.t)
	end)
		
	each(qs, function(v)
		pos = v:getPos()
		v.c = col(pos.x,pos.y,pos.z,fgu.t)
		local vp = v.p
		v.p = v.p - get_flux(vp.y*vp.y*math.random(),vp.x-vp.y,vp.z,fgu.t)
	end)
end

col = function(x,y,z,t) 
	return vec3(
		noise(x,y+t,z+t),
		noise(x+t,y,z+t),
		1) 
end

get_flux = function(x,y,z,t)
	return vec3(
		noise (math.sin(x),y,z+t),
		noise (x+t,y,math.cos(z)),
		noise (x,y*math.sin(t),z*x)
		)*.02
end
