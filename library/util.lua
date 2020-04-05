function sign(x)
    if x<0 then
        return -1
    elseif x>0 then
        return 1
    else
        return 0
    end
end

function lerp(a,b,t) return (1-t)*a + t*b end

function UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end