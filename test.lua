require "pdf"

p = PDF.new()

helv = p:new_font{ name = "Helvetica" }
times = p:new_font{ name = "Times-Roman" }

page = p:new_page()

page:setrgbcolor("stroke", 0.5, 0, 1)
page:moveto(150, 250)
page:lineto(150, 350)
page:stroke()

page:setrgbcolor("stroke", 0, 1, 0.3)
page:moveto(250, 250)
page:lineto(250, 350)
page:stroke()

page:save()

page:begin_text()
page:set_font(helv, 24)
page:set_text_pos(100, 100)
page:show("Hello, world!")
page:end_text()

page:begin_text()
page:set_font(times, 12)

for i = 1, 40 do
	page:save()
	page:translate(400, 400)
	page:rotate((3.14159 / 40) * i)
	page:moveto(0, 0)
	page:lineto(25, 0)
	page:stroke()
	page:set_text_pos(0, 0)
	page:show("<<and goodbye>>")
	page:restore()
end

page:end_text()

page:restore()

page2 = p:new_page()
page2:moveto(250, 250)
page2:lineto(350, 250)
page2:stroke()

page2:begin_text()
page2:set_font(times, 24)
page2:set_text_pos(250, 250)
page2:show("Text")
page2:end_text()

draw_circle = function(p, x, y, r)
	local k = 0.5522847498 * r

	p:moveto(x - r, y)
	p:curveto(x - r, y + k, x - k, y + r, x, y + r)
	p:curveto(x + k, y + r, x + r, y + k, x + r, y)
	p:curveto(x + r, y - k, x + k, y - r, x, y - r)
	p:curveto(x - k, y - r, x - r, y - k, x - r, y)
	
end

draw_circle(page2, 300, 400, 100)
page2:stroke()

page:add()
page2:add()

p:write("test.pdf")

