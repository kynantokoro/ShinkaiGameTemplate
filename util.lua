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