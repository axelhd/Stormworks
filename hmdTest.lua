m,i,o,p = math,input,output,property
ign,osn,igb,osb = i.getNumber, o.setNumber, i.getBool, o.setBool
pgn,pgb = p.getNumber, p.getBool
abs,cos,sin,acos,asin,tan,atan = m.abs, m.cos, m.sin, m.acos, m.asin, m.tan, m.atan
pi = m.pi
pi2 = pi*2
s = screen
text,line,rect,rectF,circl,clear,setcolor = s.drawText,s.drawLine,s.drawRect,s.drawRectF,s.drawCircle,s.drawClear,s.setColor
log = debug.log

local Vertices = {
    [0] = {
        [0] = { 1,  1,  1},
        [1] = {-1,  1,  1},
        [2] = {-1, -1,  1},
        [3] = { 1, -1,  1},
        [4] = { 1,  1, -1},
        [5] = {-1,  1, -1},
        [6] = {-1, -1, -1},
        [7] = { 1, -1, -1}
    }
}
local Triangles = {
    [0] = {
         [0] = 0, 1, 2,
         [1] = 0, 2, 3,
         [2] = 4, 0, 3,
         [3] = 4, 3, 7,
         [4] = 5, 4, 7,
         [5] = 5, 7, 6,
         [6] = 1, 5, 6,
         [7] = 1, 6, 2,
         [8] = 4, 5, 1,
         [9] = 4, 1, 0,
        [10] = 2, 6, 7,
        [11] = 2, 7, 3
    }
}


function RenderObject(vertices, triangles)
    projected = {}
    for i, v in vertices do
        table.insert(projected, )
    end
end

function RenderTriangle(triangle, projected)
    
end

function DrawWireframeTriangle(P0, P1, P2)
    line(P0[1], P0[2], P1[1], P1[2])
    line(P1[1], P1[2], P2[1], P2[2])
    line(P2[1], P2[2], P0[1], P0[2])
end



function onTick()
    viewX = ign(1)
end

function onDraw()
    screen.drawText(0, 0, viewX)
    screen.drawText(0, 4, screen.getHeight())
    screen.drawText(0, 9, screen.getWidth())
    DrawWireframeTriangle({0, 0}, {100, 100}, {50, 200})
end
